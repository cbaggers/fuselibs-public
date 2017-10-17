using Uno.Compiler.ExportTargetInterop;
using Uno.Threading;
using Uno.UX;
using Uno;
using Uno.IO;

namespace Fuse.Scripting.ReactNative
{

	[ForeignInclude(Language.Java, "android.os.Bundle", "android.content.res.Configuration", "android.content.Intent", "android.app.Activity", "com.facebook.react.*", "com.facebook.react.bridge.*", "com.facebook.react.common.*", "android.provider.*")]
	[Require("AndroidManifest.ActivityElement", "<activity android:name=\"com.facebook.react.devsupport.DevSettingsActivity\" />")]
	[Require("Gradle.Dependency.Compile", "com.facebook.react:react-native:+")]
	[Require("Gradle.Repository", "maven { url '@(Project.NodeModules:Path)/react-native/android' }")]
	public extern(Android && USE_REACTNATIVE) class ReactNativeSetup
	{
		static ReactNativeSetup _instance;

		public Java.Object ReactContext { get; private set; }
		public Java.Object InstanceManager { get; private set; }
		public long JavascriptContextPtr { get; private set; }

		public static Future<ReactNativeSetup> Aquire()
		{
			if (_instance != null)
			{
				var foo = new Promise<ReactNativeSetup>();
				foo.Resolve(_instance);
				return foo;
			}
			else
			{
				return new AquirePromise();
			}
		}

		ReactNativeSetup(Java.Object instanceManager, Java.Object context)
		{
			ReactContext = context;
			InstanceManager = instanceManager;
			JavascriptContextPtr = GetJavaScriptContext(ReactContext);
		}

		[Foreign(Language.Java)]
		public void InvokeOnJSThread(Action action, Action<string> exceptionCallback)
		@{
			ReactContext ctx = (ReactContext)@{ReactNativeSetup:Of(_this).ReactContext:Get()};
			final com.foreign.Uno.Action javaAction = action;
			final com.foreign.Uno.Action_String exception = exceptionCallback;
			ctx.runOnJSQueueThread(new java.lang.Runnable() {
				@Override
				public void run() {
					try {
						javaAction.run();
					}
					catch(java.lang.Exception e) {
						debug_log(e.toString());
						exception.run(e.toString());
					}
				}
			});
		@}

		[Foreign(Language.Java)]
		static long GetJavaScriptContext(Java.Object reactContext)
		@{
			return ((ReactContext)reactContext).getJavaScriptContext();
		@}

		extern(Android && USE_REACTNATIVE) class AquirePromise : Promise<ReactNativeSetup>
		{
			public AquirePromise()
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

						manager.addReactInstanceEventListener(new ReactInstanceManager.ReactInstanceEventListener()
						{
							@Override
							public void onReactContextInitialized(ReactContext context)
							{
								@{AquirePromise:Of(_this).Resolve(ReactNativeSetup):Call(@{ReactNativeSetup(Java.Object, Java.Object):New(manager, context)})};
							}
						});

						manager.createReactContextInBackground();
					}
				});
			@}
		}
	}
}