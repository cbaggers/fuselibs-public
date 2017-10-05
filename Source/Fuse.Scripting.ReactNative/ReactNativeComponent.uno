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
					if(ModuleNameChanged != null)
						ModuleNameChanged(_moduleName);
				}
			}
		}

		public event Action<string> ModuleNameChanged;
	}

	extern(!Android || !USE_REACTNATIVE) public class ReactNativeComponent {
		[UXConstructor]
		public ReactNativeComponent([UXParameter("Host")]ReactNativeComponentHostBase host) {}
	}

	[ForeignInclude(Language.Java, "com.facebook.react.*", "com.facebook.react.common.*")]
	extern (Android && USE_REACTNATIVE) public class ReactNativeComponent : ViewHandle
	{
		[UXConstructor]
		public ReactNativeComponent([UXParameter("Host")]ReactNativeComponentHostBase host) : base(InstantiateViewGroupImpl())
		{
			if(host.ModuleName != null) OnModuleNameChanged(host.ModuleName);
			host.ModuleNameChanged += OnModuleNameChanged;
		}

		void OnModuleNameChanged(string moduleName)
		{
			InsertChild(new ViewHandle(CreateView(moduleName, ReactNativeSetup.ReactInstanceManager)));
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