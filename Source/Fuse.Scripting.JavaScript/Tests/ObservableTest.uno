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
		public void TwoWayMapFlat()
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
		public void TwoWayMapFlatProperty()
		{
			var p = new UX.Observable.TwoWayMapFlatProperty();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("abc",p.T.IV.Value);
				Assert.AreEqual("abc",p.T.OV.Value);
				Assert.AreEqual("abc",p.SV.Value);

				p.T.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("abcdef",p.T.IV.Value);
				Assert.AreEqual("abcdef",p.T.OV.Value);
				Assert.AreEqual("abcdef",p.SV.Value);

				p.T.OV.Value = "hello";
				root.StepFrameJS();
				Assert.AreEqual("hello",p.T.IV.Value);
				Assert.AreEqual("hello",p.T.OV.Value);
				Assert.AreEqual("hello",p.SV.Value);
			}
		}

		[Test]
		public void Map()
		{
			var p = new UX.Observable.Map();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("$a", p.OC.JoinValues());

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("$a,$b", p.OC.JoinValues());

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("$c,$a,$b", p.OC.JoinValues());

				p.Step3.Perform();
				root.StepFrameJS();
				Assert.AreEqual("$c,$b", p.OC.JoinValues());

				p.Step4.Perform();
				root.StepFrameJS();
				Assert.AreEqual("$c,$d,$e,$f,$g,$b", p.OC.JoinValues());

				p.Step5.Perform();
				root.StepFrameJS();
				Assert.AreEqual("$c,$d,$b", p.OC.JoinValues());

				p.Step6.Perform();
				root.StepFrameJS();
				Assert.AreEqual("$c,$d,$h", p.OC.JoinValues());

				p.Step7.Perform();
				root.StepFrameJS();
				Assert.AreEqual("", p.OC.JoinValues());

				p.Step8.Perform();
				root.StepFrameJS();
				Assert.AreEqual("$i", p.OC.JoinValues());
			}
		}

		[Test]
		public void Where()
		{
			var p = new UX.Observable.Where();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("0,1", p.OL.JoinValues());
				Assert.AreEqual("2,3", p.OH.JoinValues());

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("0,1", p.OL.JoinValues());
				Assert.AreEqual("2,3,4", p.OH.JoinValues());

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("0,1", p.OL.JoinValues());
				Assert.AreEqual("5,2,3,4", p.OH.JoinValues());

				p.Step3.Perform();
				root.StepFrameJS();
				Assert.AreEqual("1", p.OL.JoinValues());
				Assert.AreEqual("5,2,3,4", p.OH.JoinValues());

				p.Step4.Perform();
				root.StepFrameJS();
				Assert.AreEqual("1", p.OL.JoinValues());
				Assert.AreEqual("5,6,7,8,2,3,4", p.OH.JoinValues());

				p.Step5.Perform();
				root.StepFrameJS();
				Assert.AreEqual("", p.OL.JoinValues());
				Assert.AreEqual("5,6,2,3,4", p.OH.JoinValues());

				p.Step6.Perform();
				root.StepFrameJS();
				Assert.AreEqual("1", p.OL.JoinValues());
				Assert.AreEqual("5,6,3,4", p.OH.JoinValues());

				p.Step7.Perform();
				root.StepFrameJS();
				Assert.AreEqual("1,0", p.OL.JoinValues());
				Assert.AreEqual("5,6,3", p.OH.JoinValues());

				p.Step8.Perform();
				root.StepFrameJS();
				Assert.AreEqual("", p.OL.JoinValues());
				Assert.AreEqual("", p.OH.JoinValues());

				p.Step9.Perform();
				root.StepFrameJS();
				Assert.AreEqual("0", p.OL.JoinValues());
				Assert.AreEqual("", p.OH.JoinValues());
			}
		}
	}
}
