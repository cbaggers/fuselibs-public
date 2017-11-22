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
		// public void TwoWayMapFlat()
		// {
		// 	for (var i = 0; i<1024; i++)
		// 	{
		// 		var p = new UX.Observable.TwoWayMapFlat();
		// 		using (var root = TestRootPanel.CreateWithChild(p))
		// 		{
		// 			root.StepFrameJS();

		// 			p.Step1.Perform();
		// 			root.StepFrameJS();
		// 			Assert.AreEqual("abc",p.IV.Value);
		// 			Assert.AreEqual("abc",p.OV.Value);

		// 			p.Step2.Perform();
		// 			root.StepFrameJS();
		// 			Assert.AreEqual("abcdef",p.IV.Value);
		// 			Assert.AreEqual("abcdef",p.OV.Value);

		// 			p.OV.Value = "hello";
		// 			root.StepFrameJS();
		// 			Assert.AreEqual("hello",p.IV.Value);
		// 			Assert.AreEqual("hello",p.OV.Value);
		// 		}
		// 	}
		// }

		[Test]
		public void Tarst0()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

		[Test]
		public void Tarst1()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

		[Test]
		public void Tarst2()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

		[Test]
		public void Tarst3()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

		[Test]
		public void Tarst4()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}
		[Test]
		public void Tarst5()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

		[Test]
		public void Tarst6()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

		[Test]
		public void Tarst7()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

		[Test]
		public void Tarst8()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

		[Test]
		public void Tarst9()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

		[Test]
		public void Tarst10()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

		[Test]
		public void Tarst11()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

		[Test]
		public void Tarst12()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

		[Test]
		public void Tarst13()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

		[Test]
		public void Tarst14()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}
		[Test]
		public void Tarst15()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

		[Test]
		public void Tarst16()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

		[Test]
		public void Tarst17()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

		[Test]
		public void Tarst18()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

		[Test]
		public void Tarst19()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

		[Test]
		public void Tarst20()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

		[Test]
		public void Tarst21()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

		[Test]
		public void Tarst22()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

		[Test]
		public void Tarst23()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

		[Test]
		public void Tarst24()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}
		[Test]
		public void Tarst25()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

		[Test]
		public void Tarst26()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

		[Test]
		public void Tarst27()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

		[Test]
		public void Tarst28()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

		[Test]
		public void Tarst29()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

				[Test]
		public void Tarst30()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

		[Test]
		public void Tarst31()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

		[Test]
		public void Tarst32()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

		[Test]
		public void Tarst33()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);
			}
		}

		[Test]
		public void Tarst34()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}
		[Test]
		public void Tarst35()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

		[Test]
		public void Tarst36()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

		[Test]
		public void Tarst37()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

		[Test]
		public void Tarst38()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

		[Test]
		public void Tarst39()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

				[Test]
		public void Tarst40()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

		[Test]
		public void Tarst41()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

		[Test]
		public void Tarst42()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

		[Test]
		public void Tarst43()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

		[Test]
		public void Tarst44()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}
		[Test]
		public void Tarst45()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

		[Test]
		public void Tarst46()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

		[Test]
		public void Tarst47()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

		[Test]
		public void Tarst48()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

		[Test]
		public void Tarst49()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

				[Test]
		public void Tarst50()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

		[Test]
		public void Tarst51()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

		[Test]
		public void Tarst52()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

		[Test]
		public void Tarst53()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

		[Test]
		public void Tarst54()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}
		[Test]
		public void Tarst55()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

		[Test]
		public void Tarst56()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

		[Test]
		public void Tarst57()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

		[Test]
		public void Tarst58()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

		[Test]
		public void Tarst59()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

				[Test]
		public void Tarst60()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

		[Test]
		public void Tarst61()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

		[Test]
		public void Tarst62()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

		[Test]
		public void Tarst63()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

		[Test]
		public void Tarst64()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}
		[Test]
		public void Tarst65()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

		[Test]
		public void Tarst66()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

		[Test]
		public void Tarst67()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

		[Test]
		public void Tarst68()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

		[Test]
		public void Tarst69()
		{
			var p = new UX.Observable.TwoWayMapFlat();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abc",p.IV.Value);
				Assert.AreEqual("abc",p.OV.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.IV.Value);
				Assert.AreEqual("abcdef",p.OV.Value);

				p.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.IV.Value);
				Assert.AreEqual("hello",p.OV.Value);
			}
		}

	}
}
// 880 passed & failed randomly but usually passed
// 900 passed...the fuck?
