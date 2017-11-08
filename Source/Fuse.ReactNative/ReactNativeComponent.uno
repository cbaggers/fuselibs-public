using Uno.Compiler.ExportTargetInterop;
using Uno.Threading;
using Uno.UX;
using Uno;
using Fuse.Controls.Native;
using Fuse.Controls;

namespace Fuse.Scripting.ReactNative
{
	public class ReactNativeComponentHostBase : Panel
	{
		string _moduleName;
		public string ModuleName
		{
			get
			{
				return _moduleName;
			}
			set
			{
				if(_moduleName != value)
				{
					_moduleName = value;
					if defined(USE_REACTNATIVE)
					{
						Fuse.Scripting.ReactNative.ReactNativeContext.RunWithInstanceManager(SetWithManager);
					}
				}
			}
		}

		void SetWithManager(object manager)
		{
			var handler = ModuleNameChanged;
			if (handler != null)
			{
				handler(_moduleName, manager);
			}
		}

		public event Action<string, object> ModuleNameChanged;
	}

	extern(!Android || !USE_REACTNATIVE) public class ReactNativeComponent {
		[UXConstructor]
		public ReactNativeComponent([UXParameter("Host")]ReactNativeComponentHostBase host) {}
	}

	[ForeignInclude(Language.Java, "com.facebook.react.*", "com.facebook.react.common.*")]
	extern (Android && USE_REACTNATIVE) public class ReactNativeComponent : ViewHandle
	{
		string _moduleName;

		[UXConstructor]
		public ReactNativeComponent([UXParameter("Host")]ReactNativeComponentHostBase host) : base(InstantiateViewGroupImpl())
		{
			// By requesting the ThreadWorker we ensure a VM is available. ThreadWorker is available immediately and the
			// JS vm thread will be started asyncronously
			var forceInit = Fuse.Scripting.JavaScript.JavaScriptVM.ThreadWorker;

			if(host.ModuleName != null)
			{
				_moduleName = host.ModuleName;
				Fuse.Scripting.ReactNative.ReactNativeContext.RunWithInstanceManager(SetWithManager);
			}

			host.ModuleNameChanged += OnModuleNameChanged;
		}

		void SetWithManager(object manager)
		{
			OnModuleNameChanged(_moduleName, manager);
		}

		void OnModuleNameChanged(string moduleName, object instanceManager)
		{
			var manager = (Java.Object)instanceManager;
			InsertChild(new ViewHandle(CreateView(moduleName, manager)));
		}

		[Foreign(Language.Java)]
		static Java.Object CreateView(string moduleName, Java.Object reactInstanceManager)
		@{
			ReactRootView reactRootView = new ReactRootView(com.fuse.Activity.getRootActivity());
			reactRootView.startReactApplication((ReactInstanceManager)reactInstanceManager, moduleName);
			reactRootView.setLayoutParams(
				new android.widget.FrameLayout.LayoutParams(android.view.ViewGroup.LayoutParams.MATCH_PARENT, android.view.ViewGroup.LayoutParams.MATCH_PARENT));
			return reactRootView;
		@}

		[Foreign(Language.Java)]
		static Java.Object InstantiateViewGroupImpl()
		@{
			android.widget.FrameLayout frameLayout = new com.fuse.android.views.ViewGroup(@(Activity.Package).@(Activity.Name).GetRootActivity());
			frameLayout.setFocusable(true);
			frameLayout.setFocusableInTouchMode(true);
			frameLayout.setClipChildren(false);
			frameLayout.setClipToPadding(false);
			frameLayout.setLayoutParams(new android.widget.FrameLayout.LayoutParams(android.view.ViewGroup.LayoutParams.MATCH_PARENT, android.view.ViewGroup.LayoutParams.MATCH_PARENT));
			return frameLayout;
		@}
	}
}
