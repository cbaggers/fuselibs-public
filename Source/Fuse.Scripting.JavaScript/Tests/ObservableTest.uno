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
		public void Tarst0()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst1()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst2()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst3()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst4()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}
		[Test]
		public void Tarst5()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst6()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst7()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst8()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst9()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst10()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst11()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst12()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst13()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst14()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}
		[Test]
		public void Tarst15()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst16()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst17()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst18()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst19()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst20()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst21()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst22()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst23()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst24()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}
		[Test]
		public void Tarst25()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst26()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst27()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst28()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst29()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

				[Test]
		public void Tarst30()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst31()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst32()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst33()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst34()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}
		[Test]
		public void Tarst35()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst36()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst37()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst38()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst39()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

				[Test]
		public void Tarst40()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst41()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst42()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst43()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst44()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}
		[Test]
		public void Tarst45()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst46()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst47()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst48()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst49()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

				[Test]
		public void Tarst50()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst51()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst52()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst53()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst54()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}
		[Test]
		public void Tarst55()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst56()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst57()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst58()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst59()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst60()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst61()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst62()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst63()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst64()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}
		[Test]
		public void Tarst65()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst66()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst67()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst68()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst69()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}
		[Test]
		public void Tarst70()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst71()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst72()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst73()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst74()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}
		[Test]
		public void Tarst75()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst76()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst77()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst78()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst79()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst80()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst81()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst82()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst83()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst84()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}
		[Test]
		public void Tarst85()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst86()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst87()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst88()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
		}

		[Test]
		public void Tarst89()
		{
			var jscCtx = Fuse.Scripting.JavaScriptCore.Context.WAAAContext;
			debug_log "FOOOK YARR: " + jscCtx;
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc","abc");
			}
			debug_log "----------- horse on "+Uno.Threading.Thread.CurrentThread.Name+" ----------";
			jscCtx.GarbageCollect();
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
