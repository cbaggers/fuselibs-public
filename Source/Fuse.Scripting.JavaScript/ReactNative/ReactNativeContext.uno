using Uno;
using Uno.IO;
using Uno.UX;
using Uno.Threading;
using Uno.Collections;
using Uno.Compiler.ExportTargetInterop;

namespace Fuse.Scripting.ReactNative
{
	[ForeignInclude(Language.Java, "android.os.Bundle", "android.content.res.Configuration", "android.content.Intent", "android.app.Activity", "com.facebook.react.*", "com.facebook.react.bridge.*", "com.facebook.react.common.*", "android.provider.*")]
	[Require("AndroidManifest.ActivityElement", "<activity android:name=\"com.facebook.react.devsupport.DevSettingsActivity\" />")]
	[Require("Gradle.Dependency.Compile", "com.facebook.react:react-native:+")]
	[Require("Gradle.Repository", "maven { url '@(Project.NodeModules:Path)/react-native/android' }")]
	public extern(USE_REACTNATIVE) class ReactNativeContext : Fuse.Scripting.JavaScriptCore.Context
	{
		static readonly Java.Object _reactContext;
		static readonly Java.Object _instanceManager;
		static readonly IntPtr _javascriptContextPtr;
		static readonly List<Action<object>> _queue = new List<Action<object>>();

		ReactNativeContext(ASyncInitBox box) : base(box.ContextPtr)
		{
			// lock (_queue)
			// {
				_javascriptContextPtr = box.ContextPtr;
				_instanceManager = box.InstanceManager;
				_reactContext = box.ReactContext;

			// 	Fuse.UpdateManager.PostAction(DispatchActionsWaitingOnManager);
			// }
		}

		public static Fuse.Scripting.JavaScript.JSContext Create()
		{
			var init = new ASyncInitBox();
			init.Ready.WaitOne();
			init.Ready.Dispose();
			return new ReactNativeContext(init);
		}

		protected override Fuse.Reactive.FuseJS.Builtins CreateBuiltins()
		{
			var box = new ASyncInitBuiltinsBox();
			box.Ready.WaitOne();
			box.Ready.Dispose();
			return box.BuiltIns;
		}

		class ASyncInitBuiltinsBox
		{
			public ManualResetEvent Ready = new ManualResetEvent(false);
			public Fuse.Reactive.FuseJS.Builtins BuiltIns;

			public ASyncInitBuiltinsBox()
			{
				InvokeOnJSThread(box.OnJS, null);
			}

			public bool OnJS(Fuse.Scripting.JavaScript.JSContext ctx)
			{
				BuiltIns = new Fuse.Reactive.FuseJS.Builtins(ctx);
				Ready.Set();
				return false;
			}
		}

		[Foreign(Language.Java)]
		public void InvokeOnJSThread(Func<Fuse.Scripting.JavaScript.JSContext, bool> action, Action<string> exceptionCallback)
		@{
			ReactContext ctx = (ReactContext)@{ReactNativeContext._reactContext:Get()};
			final com.foreign.Uno.Func_UnoObject javaAction = action;
			final com.foreign.Uno.Action_String exception = exceptionCallback;
			ctx.runOnJSQueueThread(new java.lang.Runnable()
			{
				public void run()
				{
					try
					{
						javaAction.run(_this);
					}
					catch(java.lang.Exception e)
					{
						debug_log(e.toString());
						exception.run(e.toString());
					}
				}
			});
		@}

		class ASyncInitBox
		{
			public ManualResetEvent Ready = new ManualResetEvent(false);
			public Java.Object ReactContext;
			public Java.Object InstanceManager;
			public IntPtr ContextPtr;

			public ASyncInitBox()
			{
				BundleFile reactNativeBundle = Bundle.Get(@(Project.ReactNativePackageName))
					.GetFile(@(Project.ReactNativeBundle));

				string bundlePath;
				if defined(PREVIEW)
				{
					var dataDir = Directory.GetUserDirectory(UserDirectory.Data);
					bundlePath = dataDir + "/reactnative.bundle";
					File.WriteAllBytes(dataDir + "/reactnative.bundle", reactNativeBundle.ReadAllBytes());
				}
				else
				{
					bundlePath = "assets://" + reactNativeBundle.BundlePath;
				}

				CreateInstanceManager(bundlePath);
			}

			void Done()
			{
				Ready.Set();
			}

			void SetPtr(long lptr)
			{
				ContextPtr = extern<IntPtr> "(@{IntPtr})$0";
			}

			[Foreign(Language.Java)]
			void CreateInstanceManager(string bundleFileName)
			@{
				debug_log("Bundle filename: " + bundleFileName);
				final Activity rootActivity = com.fuse.Activity.getRootActivity();
				rootActivity.runOnUiThread(new Runnable()
				{
					public void run()
					{
						final ReactInstanceManagerBuilder reactInstanceManagerBuilder = ReactInstanceManager.builder()
							.setApplication(rootActivity.getApplication())
							.setCurrentActivity(rootActivity)
							.setJSBundleFile(bundleFileName)
							.addPackage(new com.facebook.react.shell.MainReactPackage())
							@(ReactNative.Package:Join('\n', '.addPackage(new ', '())'))
							// NOTE: if we set this to true uncomment the canDrawOverlays stuff below
							.setUseDeveloperSupport(false) //BuildConfig.DEBUG 
							.setInitialLifecycleState(LifecycleState.RESUMED);

						final ReactInstanceManager manager = reactInstanceManagerBuilder.build();

						/*if(!Settings.canDrawOverlays(rootActivity)) {
							Intent intent = new Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION, android.net.Uri.parse("package:" + rootActivity.getPackageName()));
							rootActivity.startActivityForResult(intent, 12393);
						}*/

						com.fuse.Activity.SubscribeToLifecycleChange(new com.fuse.Activity.ActivityListener()
						{
							public void onPause()
							{
								if(manager != null)
									manager.onHostPause(rootActivity);
							}

							public void onResume()
							{
								if(manager != null)
									manager.onHostResume(rootActivity, null);
							}

							public void onDestroy()
							{
								if(manager != null)
									manager.onHostDestroy();
							}

							public void onStart() {}

							public void onStop() {}

							public void onWindowFocusChanged(boolean hasFocus) {}

							public void onConfigurationChanged(Configuration config) {}
						});
						@{ASyncInitBox:Of(_this).InstanceManager:Set(manager)};

						manager.addReactInstanceEventListener(new ReactInstanceManager.ReactInstanceEventListener()
						{
							@Override
							public void onReactContextInitialized(ReactContext context)
							{
								@{ASyncInitBox:Of(_this).SetPtr(long):Call(context.getJavaScriptContextHolder().get())};
								@{ASyncInitBox:Of(_this).ReactContext:Set(context)};
								@{ASyncInitBox:Of(_this).Done():Call()};
							}
						});

						manager.createReactContextInBackground();
					}
				});
			@}
		}

		public static void RunWithInstanceManager(Action<object> act)
		{
			// if (_instanceManager != null)
			// {
			// 	act(_instanceManager);
			// }
			// else
			// {
			// 	lock (_queue)
			// 	{
			// 		_queue.Add(act);
			// 	}
			// }
		}

		static void DispatchActionsWaitingOnManager()
		{
			foreach (var act in _queue)
			{
				act(_instanceManager);
			}
		} 
	}
}
