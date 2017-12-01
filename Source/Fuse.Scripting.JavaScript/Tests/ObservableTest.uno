using Uno;
using Uno.Collections;
using Uno.UX;
using Uno.Testing;

using Fuse.Controls;
using Fuse.Scripting;

using FuseTest;

namespace Fuse.Reactive.Test
{
	public class CreateCountPanel: Panel
	{
		public static int Count;
		public CreateCountPanel() {
			Count++;
		}
		public static int RootedCount;
		protected override void OnRooted()
		{
			base.OnRooted();
			RootedCount++;
		}
	}

	/*
		This tests the functions of the observable including the protocol used to synchronize
		between JS and Uno. This is meant to be a more direct testing than the EachTest setup.
	*/
	public class ObservableTest : TestBase
	{
		[Test]
		public void Tarst1()
		{
			var worker = new Fuse.Scripting.JavaScript.ThreadWorker();
			while (Fuse.Scripting.JavaScript.JSContext.FCTX == null) {}
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;

			debug_log "==============- About to die -==============";

			jscCtx.GarbageCollect();
			worker.Invoke(Hmm);
			StepFrameJS(worker);

			debug_log "----------- We didnt die! " + Uno.Threading.Thread.CurrentThread.Name + " ----------";

			Assert.AreEqual("abc","abc");
		}

		void Hmm(Context ctx)
		{
			ctx.Evaluate("(FOOO)", "var test = function() {\nvar makeFat = function(length) {\nvar data = [];\nfor(var i = 0; i < length; i++) {\ndata.push(\"jamHam\");\n}\nreturn data;\n}\nmakeFat(100000);\nreturn null;\n}\ntest();");
		}


		static float _frameIncrement = 1/60f;

		enum StepFlags
		{
			None = 0,
			WaitJS = 1 << 0,
			IncrementFrame = 1 << 1,
		}

		static void StepFrameJS(Fuse.Scripting.JavaScript.ThreadWorker worker)
		{
			if (worker == null)
				throw new Exception("Calling stepFrameJS though there is no JavaScript worker" );

			var fence = worker.PostFence();
			var loop = true;
			var e = 0f;
			while (loop)
			{
				loop = !fence.IsSignaled;
				IncrementFrameImpl(worker, _frameIncrement, StepFlags.WaitJS | StepFlags.IncrementFrame);
				e += _frameIncrement;
			}
		}

		static void IncrementFrameImpl(Fuse.Scripting.JavaScript.ThreadWorker worker, float elapsedTime = -1, StepFlags flags = StepFlags.IncrementFrame)
		{
			debug_log "----------- wat 0 ----------";
			if (elapsedTime < 0)
				elapsedTime = _frameIncrement;
			debug_log "----------- wat 1 ----------";
			if (flags.HasFlag(StepFlags.WaitJS))
			{
				if (worker != null)
					worker.WaitIdle();
			}
			debug_log "----------- wat 2 ----------";
			Time.Set(Time.FrameTime + elapsedTime);
			UpdateManager.Update();
			if (flags.HasFlag(StepFlags.IncrementFrame))
				UpdateManager.IncreaseFrameIndex();
			debug_log "----------- wat 3 ----------";
		}
	}
}

// 880 passed & failed randomly but usually passed
// 900 passed...the fuck?

// 48 seperate tests run and then freeze, that was consistant
// 62 seperate that ran with less js going on inside them
// 62 still ran with 1 less assert
// all of em run after removing the perform and StepFrameJS hmmm
// all of em run after removing just the perform
// all of em run after removing just the StepFrameJS gahhh
// 62 still run after removing first StepFrameJS
// up to 100 tests and now we get freezing without any Perform AWESOME
// STILL FREEZES WITHOUT StepFrameJS YES! hmm wait its weird, not failing the rest of the tests hmmmmmm (96 tests run)
// added more tests 96 tests run before freeze, but still no death...wat
// nope it's not correct.. StepFrameJS seems necessary
// ok, reverted. 86 of 100 tests passing before freeze
// ok, it used the overload of CreateWithChild where you pass in a layout size and no difference.
// remove all body code from TwoWayMapFlat and it passes..interesting
// minimizing that code now
// Oh fuck, it's to do with exports!
// Nope memory, the array we allocate forces a gc collect in jsc and that triggers the issue
