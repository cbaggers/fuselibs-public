using Uno;
using Uno.Platform;
using Uno.Collections;
using Uno.Testing;
using Uno.Threading;
using Fuse.Scripting;
using Uno.Compiler.ExportTargetInterop;

namespace Fuse.Reactive
{
	partial class ThreadWorker: IDisposable, IDispatcher, IThreadWorker
	{
		IDispatcher IThreadWorker.Dispatcher { get { return this; } }
		Function IThreadWorker.Observable { get { return FuseJS.Observable; } }

		static Scripting.Context _context;

		static FuseJS.Builtins _fuseJS;
		public static FuseJS.Builtins FuseJS { get { return _fuseJS; } }

		readonly ManualResetEvent _idle = new ManualResetEvent(true);
		readonly ManualResetEvent _terminate = new ManualResetEvent(false);
		readonly ConcurrentQueue<Action> _queue = new ConcurrentQueue<Action>();
		readonly ConcurrentQueue<Exception> _exceptionQueue = new ConcurrentQueue<Exception>();

		Thread _thread;
		extern(USE_REACTNATIVE) Fuse.Scripting.ReactNative.ReactNativeSetup _rnManager;

		public ThreadWorker()
		{
			if defined(USE_REACTNATIVE)
			{
				var setupPromise = Fuse.Scripting.ReactNative.ReactNativeSetup.Aquire();
				setupPromise.Then(Foo);
			}
			else
			{
				Begin();
			}
		}

		[Foreign(Language.Java)]
		extern(USE_REACTNATIVE) void Foo(Fuse.Scripting.ReactNative.ReactNativeSetup setup)
		@{
			// Set
			@{ThreadWorker:Of(_this)._rnManager:Set(setup)};

			// unpack
			final com.facebook.react.bridge.ReactContext reactContext = (com.facebook.react.bridge.ReactContext)@{Fuse.Scripting.ReactNative.ReactNativeSetup:Of(setup).ReactContext:Get()};
			final com.facebook.react.ReactInstanceManager instManager = (com.facebook.react.ReactInstanceManager)@{Fuse.Scripting.ReactNative.ReactNativeSetup:Of(setup).InstanceManager:Get()};

			// Make context on JS thread
			final long ctxPtr = reactContext.getJavaScriptContext();
			reactContext.runOnJSQueueThread(new java.lang.Runnable()
			{
				public void run()
				{
					@{ThreadWorker._context:Set(@{Fuse.Scripting.JavaScriptCore.Context(IThreadWorker, long):New(_this, ctxPtr)})};
					com.fuse.Activity.getRootActivity().runOnUiThread(new Runnable()
					{
						public void run()
						{
							@{ThreadWorker:Of(_this).Begin():Call()};
						}
					});
				}
			});
		@}

		void Begin()
		{
			_thread = new Thread(Run);

			if defined(DotNet)
			{
				// TODO: Create a method for canceling the thread safely
				// Threads are by default foreground threads
				// Foreground threads prevents the owner process from exiting, before the thread is safely closed
				// This is a workaround by setting the thread to be a background thread.
				_thread.IsBackground = true;
			}

			_thread.Start();
		}

		void OnTerminating(Fuse.Platform.ApplicationState newState)
		{
			Dispose();
		}

		public void Dispose()
		{
			Fuse.Platform.Lifecycle.Terminating -= OnTerminating;

			_terminate.Set();
			_thread.Join();
			_terminate.Dispose();
		}

		bool _subscribedForClosing;

		void Run()
		{
			try
			{
				RunInner();
			}
			catch(Exception e)
			{
				Fuse.Diagnostics.UnknownException( "ThreadWorked failed", e, this );
				_exceptionQueue.Enqueue(e);
			}

			if (_context != null)
			{
				_context.Dispose();
			}
		}

		void RunInner()
		{
			// TODO: ENSURE THIS HAS BEEN DEALT WITH
			//
			// if defined(!USE_REACTNATIVE)
			// {
			// 	_context = CreateContext(this);
			// }

			if (_context == null)
			{
				throw new Exception("Could not create script context");
			}

			UpdateManager.AddAction(CheckAndThrow);

			if defined(USE_REACTNATIVE)
			{
				_rnManager.InvokeOnJSThread(CreateBuiltins, HandleException);
			}
			else
			{
				CreateBuiltins();
			}

			double t = Uno.Diagnostics.Clock.GetSeconds();

			while (true)
			{
				if (_terminate.WaitOne(0))
					break;

				if defined(CPLUSPLUS) extern "uAutoReleasePool ____pool";

				if (!_subscribedForClosing)
				{
					if (Uno.Application.Current != null)
					{
						Fuse.Platform.Lifecycle.Terminating += OnTerminating;
						_subscribedForClosing = true;
					}
				}

				bool didAnything = false;

				Action action;
				if (_queue.TryDequeue(out action))
				{
					try
					{
						didAnything = true;
						if defined(USE_REACTNATIVE)
						{
							_rnManager.InvokeOnJSThread(action, HandleException);
						}
						else
						{
							action();
						}
					}
					catch (Exception e)
					{
						_exceptionQueue.Enqueue(e);
					}
				}
				else
					_idle.Set();

				try
				{
					if defined(USE_REACTNATIVE)
					{
						_rnManager.InvokeOnJSThread(UpdateModules, HandleException);
					}
					else
					{
						UpdateModules();
					}
				}
				catch (Exception e)
				{
					_exceptionQueue.Enqueue(e);
				}

				var t2 = Uno.Diagnostics.Clock.GetSeconds();

				if (!didAnything || t2-t > 5)
				{
					Thread.Sleep(1);	
					t = t2;
				}
			}
		}

		void HandleException(string e)
		{
			_exceptionQueue.Enqueue(new Exception(e));
		}

		static void CreateBuiltins()
		{
			_fuseJS = new FuseJS.Builtins(_context);
		}

		static void UpdateModules()
		{
			_fuseJS.UpdateModules(_context);
		}

		/**
			Waits for any queued items to finish executing. Used only for testing now.
		*/
		public void WaitIdle()
		{
			_idle.WaitOne();
		}

		/*
			Throws an exception that was generated on the thread. If there are more than one then the previous
			ones will be reported and the last one thrown.
		*/
		public void CheckAndThrow()
		{
			Exception next = null, prev = null;
			while (_exceptionQueue.TryDequeue(out next))
			{
				if (prev != null)
					Fuse.Diagnostics.UnknownException("Skipped Exception", prev, this);
				prev = next;
			}
			
			if (prev != null)
				throw new WrapException(prev);
		}

		public void Invoke(Action action)
		{
			_idle.Reset();
			_queue.Enqueue(action);
		}

		public class Fence
		{
			ManualResetEvent _signaled = new ManualResetEvent(false);

			public bool IsSignaled { get { return _signaled.WaitOne(0); } }
			public void Wait() { _signaled.WaitOne(); }

			internal void Signal() { _signaled.Set(); }
		}

		public Fence PostFence()
		{
			var f = new Fence();
			Invoke(f.Signal);
			return f;
		}
	}
}
