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
	public extern(USE_JAVASCRIPTCORE) class ReactNativeContext : Fuse.Scripting.JavaScriptCore.Context
	{
		public readonly Java.Object ReactContext;
		public readonly Java.Object InstanceManager;
		public readonly IntPtr JavascriptContextPtr;

		ReactNativeContext(ASyncInitBox box) : base(box.ContextPtr)
		{
			JavascriptContextPtr = box.ContextPtr;
			InstanceManager = box.InstanceManager;
			ReactContext = box.ReactContext;
		}

		public static Fuse.Scripting.JavaScript.JSContext Create()
		{
			var init = new ASyncInitBox();
			init.Ready.WaitOne();
			init.Ready.Dispose();
			return new ReactNativeContext(init);
		}

		[Foreign(Language.Java)]
		public void InvokeOnJSThread(Action action, Action<string> exceptionCallback)
		@{
			ReactContext ctx = (ReactContext)@{ReactNativeContext:Of(_this).ReactContext:Get()};
			final com.foreign.Uno.Action javaAction = action;
			final com.foreign.Uno.Action_String exception = exceptionCallback;
			ctx.runOnJSQueueThread(new java.lang.Runnable()
			{
				public void run()
				{
					try
					{
						javaAction.run();
					}
					catch(java.lang.Exception e)
					{
						debug_log(e.toString());
						exception.run(e.toString());
					}
				}
			});
		@}

		Future<object> AquireInstanceManager()
		{
			var promise = new Promise<object>();
			if (InstanceManager != null)
			{
				promise.Resolve(InstanceManager);
			}
			else
			{
				Invoke(new WaitOnInstanceManager(promise).WaitOnJS);
			}
			return promise;
		}

		class WaitOnInstanceManager
		{
			Promise<object> _promise;
			object _manager;

			public IndirectOnNameChange(Promise<object> promise)
			{
				_promise = promise;
			}

			public void WaitOnJS(Scripting.Context ctx)
			{
				_manager = ((ReactNativeContext)ctx).InstanceManager;
				Fuse.UpdateManager.PostAction(BackOnUI);
			}

			void BackOnUI()
			{
				_promise.Resolve(_manager);
			}
		}

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
	}
}
