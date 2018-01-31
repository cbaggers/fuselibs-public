using Uno;
using Uno.IO;
using Uno.UX;
using Uno.Threading;
using Uno.Collections;
using Uno.Compiler.ExportTargetInterop;


// https://github.com/facebook/react-native/issues/10027#issuecomment-249338419
//
// Hi, guys! This works for me (on simulator):
//
//     Xcode menu -> Product -> Edit Scheme...
//     Environment Variables -> Add -> Name: "OS_ACTIVITY_MODE", Value:"disable"
//     Run your app again, done! 😄

/*

Ok next attempt:

- ReactNativeContext's call to base should pass ptr
- we cant get ptr without async calls so Create has to make an async box just
  like in android. We push a task into the RN js queue and wait for JS to be
  initialized. Then we can grab the context ptr and new the ReactNativeContext
  obj with it.

 */

namespace Fuse.Scripting.ReactNative
{
	[Require("Cocoapods.Podfile.Target", "pod 'React', :path => '../../../node_modules/react-native', :subspecs => [ 'Core', 'DevSupport', 'RCTText', 'RCTNetwork', 'RCTWebSocket' , 'BatchedBridge' ]")]
	[Require("Cocoapods.Podfile.Target", "pod 'yoga', :path => '../../../node_modules/react-native/ReactCommon/yoga'")]
	[Require("Cocoapods.Podfile.Target", "pod 'DoubleConversion', :podspec => '../../../node_modules/react-native/third-party-podspecs/DoubleConversion.podspec'")]
	[Require("Cocoapods.Podfile.Target", "pod 'GLog', :podspec => '../../../node_modules/react-native/third-party-podspecs/GLog.podspec'")]
	[Require("Cocoapods.Podfile.Target", "pod 'Folly', :podspec => '../../../node_modules/react-native/third-party-podspecs/Folly.podspec'")]
	[Require("Source.Include", "@{Uno.Platform.iOS.Application:Include}")]
	[Require("Source.Include", "React/RCTBridge.h")]
	[Require("Source.Include", "React/RCTBridge+Private.h")]
	[Require("Source.Include", "React/RCTBridgeModule.h")]
	[Require("Source.Include", "React/RCTEventDispatcher.h")]
	[Require("Source.Include", "React/RCTJavaScriptExecutor.h")]
	[Require("Source.Include", "React/RCTJSCExecutor.h")]
	extern(USE_REACTNATIVE && iOS)
	public class ReactNativeContext : Fuse.Scripting.JavaScriptCore.Context
	{
		public static ObjC.Object Bridge { get; private set; }
		public static ObjC.Object Executor { get; private set; }
		static readonly List<Action<object>> _queue = new List<Action<object>>();
		static bool _readyTEST = false;

		ReactNativeContext(ASyncInitBox box) : base(box.ContextPtr, false)
		{
			Bridge = box.Bridge;
			Executor = box.Executor;
			Fuse.UpdateManager.PostAction(DispatchActionsWaitingOnManager);
		}

		public static Fuse.Scripting.JavaScript.JSContext Create()
		{
			var init = new ASyncInitBox();
			init.Ready.WaitOne();
			init.Ready.Dispose();
			return new ReactNativeContext(init);
		}

		[Require("Source.Include", "@{Uno.Platform.iOS.Application:Include}")]
		[Require("Source.Include", "React/RCTBridge.h")]
		[Require("Source.Include", "React/RCTBridge+Private.h")]
		[Require("Source.Include", "React/RCTBridgeModule.h")]
		[Require("Source.Include", "React/RCTEventDispatcher.h")]
		[Require("Source.Include", "React/RCTJavaScriptExecutor.h")]
		[Require("Source.Include", "React/RCTJSCExecutor.h")]
		class ASyncInitBox
		{
			public ManualResetEvent Ready = new ManualResetEvent(false);
			public ObjC.Object Bridge;
			public ObjC.Object Executor;
			public IntPtr ContextPtr;

			public ASyncInitBox()
			{
				string bundlePath;
				BundleFile reactNativeBundle = Bundle.Get(@(Project.ReactNativePackageName))
					.GetFile(@(Project.ReactNativeBundle));
				if defined(PREVIEW)
				{
					var dataDir = Directory.GetUserDirectory(UserDirectory.Data);
					bundlePath = dataDir + "/reactnative.bundle";
					File.WriteAllBytes(dataDir + "/reactnative.bundle", reactNativeBundle.ReadAllBytes());
				}
				else
				{
					bundlePath = "data/" + reactNativeBundle.BundlePath;
				}
				KickOff(bundlePath, JSAlive);
			}

			void SetPtr(long lptr)
			{
				ContextPtr = extern<IntPtr> "(@{IntPtr})$0";
				Ready.Set();
			}

			[Foreign(Language.ObjC)]
			void JSAlive()
			@{
				RCTBridge* bridge =
					(RCTBridge*)@{ASyncInitBox:Of(_this).Bridge:Get()};
				id<RCTJavaScriptExecutor> executor =
					(id<RCTJavaScriptExecutor>)@{ASyncInitBox:Of(_this).Executor:Get()};

				RCTJSCExecutor* jscExecutor;
				if ([bridge executorClass] == [RCTJSCExecutor class])
				{
					jscExecutor = (RCTJSCExecutor*)executor;
				}
				else
				{
					exit(1);
				}
				JSContext* context = [jscExecutor jsContext];
				// need a JSContextRef
				void* ptr = (void*)context;
				@{ASyncInitBox:Of(_this).SetPtr(long):Call((long)ptr)};
			@}

			[Foreign(Language.ObjC)]
			void KickOff(string bundleFileName, Action jsAlive)
			@{
				// hoo
				NSDictionary* options = (NSDictionary*)@{Uno.Platform.iOS.Application.LaunchOptions:Get()};
				NSURL* url = [NSURL URLWithString:bundleFileName];
				RCTBridge* bridge = [[RCTBridge alloc] initWithBundleURL:url
									 moduleProvider:nil
									 launchOptions:options];
				RCTBridge* batchedBridge = [bridge batchedBridge];
				id<RCTJavaScriptExecutor> executor = batchedBridge.javaScriptExecutor;
				@{ASyncInitBox:Of(_this).Bridge:Set(batchedBridge)};
				@{ASyncInitBox:Of(_this).Executor:Set(executor)};
				[executor executeBlockOnJavaScriptQueue:jsAlive];
			@}
		}

		class Foo
		{
			ReactNativeContext _context;
			Func<Fuse.Scripting.JavaScript.JSContext, bool> _action;
			Action<string> _exceptionCallback;

			public Foo(ReactNativeContext context, Func<Fuse.Scripting.JavaScript.JSContext, bool> action,
					   Action<string> exceptionCallback)
			{
				_context = context;
				_action = action;
				_exceptionCallback = exceptionCallback;
			}

			public void Bar()
			{
				_action(_context);
			}
		}

		internal void InvokeOnJSThread(Func<Fuse.Scripting.JavaScript.JSContext, bool> action,
									   Action<string> exceptionCallback)
		{
			InvokeOnJSThread(new Foo(this, action, exceptionCallback).Bar);
		}

		[Foreign(Language.ObjC)]
		void InvokeOnJSThread(Action act)
		@{
			id<RCTJavaScriptExecutor> executor = (id<RCTJavaScriptExecutor>)@{Executor:Get()};
			[executor executeBlockOnJavaScriptQueue:act];
		@}

		public static void RunWithInstanceManager(Action<object> act)
		{
			if (_readyTEST)
			{
				act(Bridge);
			}
			else
			{
				lock (_queue)
				{
					_queue.Add(act);
				}
			}
		}

		static void DispatchActionsWaitingOnManager()
		{
			_readyTEST = true;
			foreach (var act in _queue)
			{
				act(Bridge);
			}
		}
	}
}
// https://tadeuzagallo.com/blog/react-native-bridge/
// https://github.com/dsibiski/react-native-hybrid-app-examples/search?utf8=%E2%9C%93&q=bridge&type=
//
// may be useful
//
// RCTJSCExecutor
// RCTJavaScriptExecutor
//
// Check useCustomJSCLibrary is false on executor
// executeBlockOnJavaScriptQueue

// _javascriptexecutor
// jsContextRef
