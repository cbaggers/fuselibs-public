using Uno.Compiler.ExportTargetInterop;
using Uno.Threading;
using Uno.UX;
using Uno;

namespace Fuse.Scripting.ReactNative
{
	[ForeignInclude(Language.Java, "android.os.Bundle", "android.content.res.Configuration", "android.content.Intent", "android.app.Activity", "com.facebook.react.*", "com.facebook.react.bridge.*", "com.facebook.react.common.*", "android.provider.*")]
	[Require("AndroidManifest.ActivityElement", "<activity android:name=\"com.facebook.react.devsupport.DevSettingsActivity\" />")]
	[Require("Gradle.Dependency.Compile", "com.facebook.react:react-native:+")]
	[Require("Gradle.Repository", "maven { url '@(PACKAGE_DIR:Path)/node_modules/react-native/android' }")]
	public extern(Android && USE_REACTNATIVE) class ReactNativeSetup
	{
		Java.Object _reactInstanceManager;
		Java.Object _reactContext;

		long _javascriptContextPtr;
		public long JavascriptContextPtr 
		{
			get 
			{
				_ready.WaitOne();
				return _javascriptContextPtr;
			} 
		}
		readonly ManualResetEvent _ready = new ManualResetEvent(false);

		public ReactNativeSetup()
		{
			_reactInstanceManager = CreateInstanceManager(OnReactContextInitialized);
		}

		[Foreign(Language.Java)]
		Java.Object CreateInstanceManager(Action<Java.Object> onReactContextInitialized)
		@{
			final Activity rootActivity = com.fuse.Activity.getRootActivity();
			final ReactInstanceManagerBuilder reactInstanceManagerBuilder = ReactInstanceManager.builder()
				.setApplication(rootActivity.getApplication())
				.setCurrentActivity(rootActivity)
				.setBundleAssetName("index.android.bundle")
				.setJSMainModuleName("index.android")
				.addPackage(new com.facebook.react.shell.MainReactPackage())
				.setUseDeveloperSupport(true) //BuildConfig.DEBUG
				.setInitialLifecycleState(LifecycleState.RESUMED);

			final com.foreign.Uno.Action_Object reactContextInitialized = onReactContextInitialized;

			final ReactInstanceManager manager = reactInstanceManagerBuilder.build();

			if(!Settings.canDrawOverlays(rootActivity)) {
				Intent intent = new Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION, android.net.Uri.parse("package:" + rootActivity.getPackageName()));
				rootActivity.startActivityForResult(intent, 12393);
			}

			com.fuse.Activity.SubscribeToLifecycleChange(new com.fuse.Activity.ActivityListener() {
				public void onPause() {					
					if(manager != null)
						manager.onHostPause(rootActivity);
				}

				public void onResume() {
					if(manager != null)
						manager.onHostResume(rootActivity, null);
				}

				public void onDestroy() {
					if(manager != null)
						manager.onHostDestroy();
				}

				public void onStart() {}
				
				public void onStop() {}
				
				public void onWindowFocusChanged(boolean hasFocus) {}
				
				public void onConfigurationChanged(Configuration config) {}
			});

			manager.addReactInstanceEventListener(new ReactInstanceManager.ReactInstanceEventListener() {
				@Override
				public void onReactContextInitialized(ReactContext context) {
					reactContextInitialized.run(context);
				}
			});

			manager.createReactContextInBackground();

			return manager;
		@}

		[Foreign(Language.Java)]
		public void InvokeOnJSThread(Action action)
		@{
			ReactContext ctx = (ReactContext)@{ReactNativeSetup:Of(_this)._reactContext:Get()};
			final com.foreign.Uno.Action javaAction = action;
			ctx.runOnJSQueueThread(new java.lang.Runnable() {
				@Override
				public void run() {
					javaAction.run();
				}
			});
		@}

		void OnReactContextInitialized(Java.Object reactContext) 
		{	
			debug_log("React context initialized");
			_reactContext = reactContext;
			_javascriptContextPtr = GetJavaScriptContext(_reactContext);
			_ready.Set();
		}

		[Foreign(Language.Java)]
		static long GetJavaScriptContext(Java.Object reactContext)
		@{
			return ((ReactContext)reactContext).getJavaScriptContext();
		@}
	}
}