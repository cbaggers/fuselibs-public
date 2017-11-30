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
		// [Test]
		// public void Tarst0()
		// {
		// 	var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
		// 	debug_log "FOOOK YARR 0: " + jscCtx;
		// 	var p = new UX.Observable.TwoWayMapFlat();
		// 	using (var root = TestRootPanel.CreateWithChild(p))
		// 	{
		// 		root.StepFrameJS();
		// 		Assert.AreEqual("abc","abc");
		// 		var q = new UX.Observable.TwoWayMapFlat();
		// 		using (var root2 = TestRootPanel.CreateWithChild(q))
		// 		{
		// 			debug_log "oh!"
		// 			root2.StepFrameJS();
		// 			Assert.AreEqual("abc","abc");
		// 			debug_log "still here!"
		// 		}
		// 	}
		// 	debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
		// 	jscCtx.GarbageCollect();
		// }

		// [Test]
		// public void Tarst1()
		// {
		// 	var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
		// 	debug_log "FOOOK YARR 1: " + jscCtx;
		// 	var p = new UX.Observable.TwoWayMapFlat();
		// 	var root = TestRootPanel.CreateWithChild(p);
		// 	root.StepFrameJS();
		// 	Assert.AreEqual("abc","abc");
		// 	debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
		// 	jscCtx.GarbageCollect();
		// }

		// [Test]
		// public void Tarst2()
		// {
		// 	var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
		// 	debug_log "FOOOK YARR 2: " + jscCtx;
		// 	var p = new UX.Observable.TwoWayMapFlat();
		// 	var root = TestRootPanel.CreateWithChild(p);
		// 	root.StepFrameJS();
		// 	Assert.AreEqual("abc","abc");
		// 	debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
		// 	jscCtx.GarbageCollect();
		// }

		// [Test]
		// public void Tarst3()
		// {
		// 	var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
		// 	debug_log "FOOOK YARR 3: " + jscCtx;
		// 	var p = new UX.Observable.TwoWayMapFlat();
		// 	var root = TestRootPanel.CreateWithChild(p);
		// 	root.StepFrameJS();
		// 	Assert.AreEqual("abc","abc");
		// 	debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
		// 	jscCtx.GarbageCollect();
		// }

		// [Test]
		// public void Tarst4()
		// {
		// 	var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
		// 	debug_log "FOOOK YARR 4: " + jscCtx;
		// 	var p = new UX.Observable.TwoWayMapFlat();
		// 	using (var root = TestRootPanel.CreateWithChild(p))
		// 	{
		// 		root.StepFrameJS();
		// 		Assert.AreEqual("abc","abc");
		// 	}
		// 	debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
		// 	jscCtx.GarbageCollect();
		// }

		// [Test]
		// public void Tarst1()
		// {
		// 	for (var i = 0; i<10; i++)
		// 	{
		// 		debug_log "==============- Loop: " + i +" -==============";
		// 		debug_log "----------- horse 0 ----------";
		// 		var p = new UX.Observable.TwoWayMapFlat();
		// 		debug_log "----------- horse 1 ----------";
		// 		var root = TestRootPanel.CreateWithChild(p);
		// 		debug_log "----------- horse 2 ----------";
		// 		root.StepFrameJS();
		// 		debug_log "----------- horse 2.1 ----------";
		// 		root.StepFrameJS();
		// 		debug_log "----------- horse 2.2 ----------";
		// 		root.StepFrameJS();
		// 		debug_log "----------- horse 2.3 ----------";
		// 		root.StepFrameJS();
		// 		debug_log "----------- horse 2.4 ----------";
		// 		root.StepFrameJS();
		// 		debug_log "----------- horse 3 ----------";
		// 		var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
		// 		jscCtx.GarbageCollect();
		// 		debug_log "----------- horse 4 ----------";
		// 		Fuse.Scripting.JavaScript.JSContext.FCTX.ThreadWorker.Invoke(Hmm);
		// 		debug_log "----------- horse 5 ----------";
		// 		root.StepFrameJS();
		// 		debug_log "----------- horse 6 " + Uno.Threading.Thread.CurrentThread.Name + " ----------";
		// 	}
		// 	Assert.AreEqual("abc","abc");
		// }

		[Test]
		public void Tarst1()
		{
			for (var i = 0; i<10; i++)
			{
				debug_log "==============- Loop: " + i +" -==============";


				var p = new UX.Observable.TwoWayMapFlat();
				var root = TestRootPanel.CreateWithChild(p);

				debug_log "----------- horse 0 ----------";

				// var worker = new Fuse.Scripting.JavaScript.ThreadWorker();

				debug_log "----------- horse 1 ----------";
				while (Fuse.Scripting.JavaScript.JSContext.FCTX == null) {}
				debug_log "foo " + Fuse.Scripting.JavaScript.JSContext.FCTX;
				var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
				Fuse.Scripting.JavaScript.JSContext.FCTX.ThreadWorker.Invoke(Hmm);
				debug_log "----------- horse 2 ----------";
				root.StepFrameJS();
				debug_log "----------- horse 3 ----------";
				jscCtx.GarbageCollect();
				debug_log "----------- horse 4 ----------";
				Fuse.Scripting.JavaScript.JSContext.FCTX.ThreadWorker.Invoke(Hmm);
				debug_log "----------- horse 5 ----------";
				root.StepFrameJS();
				debug_log "----------- horse 6 ----------";
				jscCtx.GarbageCollect();
				debug_log "----------- horse 7 ----------";
				Fuse.Scripting.JavaScript.JSContext.FCTX.ThreadWorker.Invoke(Hmm);
				debug_log "----------- horse 8 ----------";
				root.StepFrameJS();
				debug_log "----------- horse 9 ----------";
				jscCtx.GarbageCollect();
				debug_log "----------- horse 10 ----------";
				Fuse.Scripting.JavaScript.JSContext.FCTX.ThreadWorker.Invoke(Hmm);
				debug_log "----------- horse 11 ----------";
				root.StepFrameJS();
				debug_log "----------- horse 12 " + Uno.Threading.Thread.CurrentThread.Name + " ----------";
			}
			Assert.AreEqual("abc","abc");
		}

		void Hmm(Context ctx)
		{
			ctx.Evaluate("(FOOO)", "var test = function() {\nvar makeFat = function(length) {\nvar data = [];\nfor(var i = 0; i < length; i++) {\ndata.push(\"jamHam\");\n}\nreturn data;\n}\nmakeFat(100000);\nreturn null;\n}\ntest();");
		}

		// public static void StepFrameJS()
		// {
		// 	var w = Fuse.Reactive.JavaScript.Worker;
		// 	if (w == null)
		// 		throw new Exception("Calling stepFrameJS though there is no JavaScript worker" );

		// 	var fence = Fuse.Reactive.JavaScript.Worker.PostFence();
		// 	var loop = true;
		// 	var e = 0f;
		// 	while(loop)
		// 	{
		// 		loop = !fence.IsSignaled;
		// 		IncrementFrameImpl(_frameIncrement, StepFlags.WaitJS | StepFlags.IncrementFrame);
		// 		e += _frameIncrement;
		// 	}
		// }
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
