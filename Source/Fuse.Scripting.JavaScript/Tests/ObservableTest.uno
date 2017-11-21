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
		public void DoubleSubscribe()
		{
			CreateCountPanel.Count = 0;
			Instance.InsertCount = 0;
			var p = new UX.Observable.DoubleSubscribe();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				root.StepFrameJS();
				root.StepFrameJS();
				Assert.AreEqual(3, CreateCountPanel.Count);
				Assert.AreEqual(3, CreateCountPanel.RootedCount);
				Assert.AreEqual(3, Instance.InsertCount);
				Instance.InsertCount = 0;
				p.flip.Perform();
				root.StepFrameJS();
				Assert.AreEqual(9, CreateCountPanel.Count);
				Assert.AreEqual(9, CreateCountPanel.RootedCount);
				Assert.AreEqual(7, Instance.InsertCount);
			}
		}

		[Test]
		public void ReplaceAll()
		{
			var p = new UX.Observable.ReplaceAll();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("1,2,3,4,11,12,13,14", p.OC.JoinValues() );

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("1,2,5", p.OC.JoinValues() );

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("2,5,6,7,8", p.OC.JoinValues() );

				p.Step3.Perform();
				root.StepFrameJS();
				Assert.AreEqual("", p.OC.JoinValues() );

				p.Step4.Perform();
				root.StepFrameJS();
				Assert.AreEqual("9", p.OC.JoinValues() );
			}
		}

		[Test]
		//catches https://github.com/fusetools/fuselibs/issues/3371
		public void RefreshAll()
		{
			var p = new UX.Observable.RefreshAll();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("1,2,3,4,11,12,13,14", p.OC.JoinValues() );

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("1,2,5", p.OC.JoinValues() );

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("2,5,6,7,8", p.OC.JoinValues() );

				p.Step3.Perform();
				root.StepFrameJS();
				Assert.AreEqual("", p.OC.JoinValues() );

				p.Step4.Perform();
				root.StepFrameJS();
				Assert.AreEqual("9", p.OC.JoinValues() );
			}
		}

		[Test]
		public void AddAll()
		{
			var p = new UX.Observable.AddAll();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("1,2", p.OC.JoinValues() );

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("1,2,1,2,5", p.OC.JoinValues() );

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("1,2,1,2,5", p.OC.JoinValues() );
			}
		}

		[Test]
		public void ReplaceAtFail()
		{
			var p = new UX.Observable.ReplaceAtFail();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("1,2", p.OC.JoinValues());

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("1,2", p.OC.JoinValues() );
			}
		}

		// [Test]
		// public void TwoWayMapFlat()
		// {
		// 	var p = new UX.Observable.TwoWayMapFlat();
		// 	using (var root = TestRootPanel.CreateWithChild(p))
		// 	{
		// 		root.StepFrameJS();

		// 		p.Step1.Perform();
		// 		root.StepFrameJS();
		// 		Assert.AreEqual("abc",p.IV.Value);
		// 		Assert.AreEqual("abc",p.OV.Value);

		// 		p.Step2.Perform();
		// 		root.StepFrameJS();
		// 		Assert.AreEqual("abcdef",p.IV.Value);
		// 		Assert.AreEqual("abcdef",p.OV.Value);

		// 		p.OV.Value = "hello";
		// 		root.StepFrameJS();
		// 		Assert.AreEqual("hello",p.IV.Value);
		// 		Assert.AreEqual("hello",p.OV.Value);
		// 	}
		// }

		// [Test]
		// public void TwoWayMapFlatProperty()
		// {
		// 	var p = new UX.Observable.TwoWayMapFlatProperty();
		// 	using (var root = TestRootPanel.CreateWithChild(p))
		// 	{
		// 		root.StepFrameJS();
		// 		Assert.AreEqual("abc",p.T.IV.Value);
		// 		Assert.AreEqual("abc",p.T.OV.Value);
		// 		Assert.AreEqual("abc",p.SV.Value);

		// 		p.T.Step1.Perform();
		// 		root.StepFrameJS();
		// 		Assert.AreEqual("abcdef",p.T.IV.Value);
		// 		Assert.AreEqual("abcdef",p.T.OV.Value);
		// 		Assert.AreEqual("abcdef",p.SV.Value);

		// 		p.T.OV.Value = "hello";
		// 		root.StepFrameJS();
		// 		Assert.AreEqual("hello",p.T.IV.Value);
		// 		Assert.AreEqual("hello",p.T.OV.Value);
		// 		Assert.AreEqual("hello",p.SV.Value);
		// 	}
		// }

		// [Test]
		// public void Map()
		// {
		// 	var p = new UX.Observable.Map();
		// 	using (var root = TestRootPanel.CreateWithChild(p))
		// 	{
		// 		root.StepFrameJS();
		// 		Assert.AreEqual("$a", p.OC.JoinValues());

		// 		p.Step1.Perform();
		// 		root.StepFrameJS();
		// 		Assert.AreEqual("$a,$b", p.OC.JoinValues());

		// 		p.Step2.Perform();
		// 		root.StepFrameJS();
		// 		Assert.AreEqual("$c,$a,$b", p.OC.JoinValues());

		// 		p.Step3.Perform();
		// 		root.StepFrameJS();
		// 		Assert.AreEqual("$c,$b", p.OC.JoinValues());

		// 		p.Step4.Perform();
		// 		root.StepFrameJS();
		// 		Assert.AreEqual("$c,$d,$e,$f,$g,$b", p.OC.JoinValues());

		// 		p.Step5.Perform();
		// 		root.StepFrameJS();
		// 		Assert.AreEqual("$c,$d,$b", p.OC.JoinValues());

		// 		p.Step6.Perform();
		// 		root.StepFrameJS();
		// 		Assert.AreEqual("$c,$d,$h", p.OC.JoinValues());

		// 		p.Step7.Perform();
		// 		root.StepFrameJS();
		// 		Assert.AreEqual("", p.OC.JoinValues());

		// 		p.Step8.Perform();
		// 		root.StepFrameJS();
		// 		Assert.AreEqual("$i", p.OC.JoinValues());
		// 	}
		// }

		// [Test]
		// public void Where()
		// {
		// 	var p = new UX.Observable.Where();
		// 	using (var root = TestRootPanel.CreateWithChild(p))
		// 	{
		// 		root.StepFrameJS();
		// 		Assert.AreEqual("0,1", p.OL.JoinValues());
		// 		Assert.AreEqual("2,3", p.OH.JoinValues());

		// 		p.Step1.Perform();
		// 		root.StepFrameJS();
		// 		Assert.AreEqual("0,1", p.OL.JoinValues());
		// 		Assert.AreEqual("2,3,4", p.OH.JoinValues());

		// 		p.Step2.Perform();
		// 		root.StepFrameJS();
		// 		Assert.AreEqual("0,1", p.OL.JoinValues());
		// 		Assert.AreEqual("5,2,3,4", p.OH.JoinValues());

		// 		p.Step3.Perform();
		// 		root.StepFrameJS();
		// 		Assert.AreEqual("1", p.OL.JoinValues());
		// 		Assert.AreEqual("5,2,3,4", p.OH.JoinValues());

		// 		p.Step4.Perform();
		// 		root.StepFrameJS();
		// 		Assert.AreEqual("1", p.OL.JoinValues());
		// 		Assert.AreEqual("5,6,7,8,2,3,4", p.OH.JoinValues());

		// 		p.Step5.Perform();
		// 		root.StepFrameJS();
		// 		Assert.AreEqual("", p.OL.JoinValues());
		// 		Assert.AreEqual("5,6,2,3,4", p.OH.JoinValues());

		// 		p.Step6.Perform();
		// 		root.StepFrameJS();
		// 		Assert.AreEqual("1", p.OL.JoinValues());
		// 		Assert.AreEqual("5,6,3,4", p.OH.JoinValues());

		// 		p.Step7.Perform();
		// 		root.StepFrameJS();
		// 		Assert.AreEqual("1,0", p.OL.JoinValues());
		// 		Assert.AreEqual("5,6,3", p.OH.JoinValues());

		// 		p.Step8.Perform();
		// 		root.StepFrameJS();
		// 		Assert.AreEqual("", p.OL.JoinValues());
		// 		Assert.AreEqual("", p.OH.JoinValues());

		// 		p.Step9.Perform();
		// 		root.StepFrameJS();
		// 		Assert.AreEqual("0", p.OL.JoinValues());
		// 		Assert.AreEqual("", p.OH.JoinValues());
		// 	}
		// }

		[Test]
		public void Function()
		{
			var p=  new UX.Observable.Function();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("ab", p.C.Value);
				Assert.AreEqual( "$*ab", p.F.Value );

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("cb", p.C.Value);
				Assert.AreEqual( "$*cb", p.F.Value );

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("cb", p.C.Value);
				Assert.AreEqual( "$gcb", p.F.Value );
			}
		}

		[Test]
		public void Expand()
		{
			var p = new UX.Observable.Expand();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("", p.T1.Value);

				Assert.AreEqual("1,2,3", p.OC.JoinValues());
			}
		}

		[Test]
		public void CombineArrays()
		{
			var p = new UX.Observable.CombineArrays();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("1a*,2b*,*c*", p.OC.JoinValues());

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("1a%,2b*,*c*", p.OC.JoinValues());

				p.OC.AllowFailed = true;
				p.Failed.Perform();
				root.StepFrameJS();
				Assert.AreEqual("", p.OC.JoinValues());
				Assert.IsTrue(p.OC.Failed);

				p.Restore.Perform();
				root.StepFrameJS();
				Assert.AreEqual("1a#,2b*,*c*", p.OC.JoinValues());
				Assert.IsFalse(p.OC.Failed);
			}
		}

		[Test]
		public void Combine()
		{
			var p = new UX.Observable.Combine();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("1a*", p.A.Value);
				Assert.AreEqual("", p.B.Value);

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("1a@", p.A.Value);
				Assert.AreEqual("1a@", p.B.Value);

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("*a@", p.A.Value);
				Assert.AreEqual("", p.B.Value);

				p.Failed.Perform();
				root.StepFrameJS();
				Assert.AreEqual("", p.A.Value);
				Assert.AreEqual("", p.B.Value);

				p.Restore.Perform();
				root.StepFrameJS();
				Assert.AreEqual("#a@", p.A.Value);
				Assert.AreEqual("#a@", p.B.Value);
			}
		}

		[Test]
		public void MapTwoWay()
		{
			var p = new UX.Observable.MapTwoWay();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual( "$a", p.T.Value );

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual( "$b", p.T.Value );

				p.T.Value = "$c";
				root.StepFrameJS();
				Assert.AreEqual( "$c", p.T.Value );
				Assert.AreEqual( "c", p.S.Value );
			}
		}

		[Test]
		public void MapTwoWayFloat3()
		{
			var p = new UX.Observable.MapTwoWayFloat3();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				//multi-step an Observable linked between two JavaScript elements involved
				root.MultiStepFrameJS(2);
				Assert.AreEqual( "1,2,3", p.S.Value );
				Assert.AreEqual( "1", p.C.TX.Value );
				Assert.AreEqual( "2", p.C.TY.Value );
				Assert.AreEqual( "3", p.C.TZ.Value );

				p.C.TX.Value = "10";
				root.MultiStepFrameJS(2);
				Assert.AreEqual( "10,2,3", p.S.Value );
				Assert.AreEqual( "10", p.C.TX.Value );
				Assert.AreEqual( "2", p.C.TY.Value );
				Assert.AreEqual( "3", p.C.TZ.Value );

				p.C.TZ.Value = "30";
				root.MultiStepFrameJS(2);
				Assert.AreEqual( "10,2,30", p.S.Value );
				Assert.AreEqual( "10", p.C.TX.Value );
				Assert.AreEqual( "2", p.C.TY.Value );
				Assert.AreEqual( "30", p.C.TZ.Value );

				p.ChangeY.Perform();
				root.MultiStepFrameJS(2);
				Assert.AreEqual( "10,20,30", p.S.Value );
				Assert.AreEqual( "10", p.C.TX.Value );
				Assert.AreEqual( "20", p.C.TY.Value );
				Assert.AreEqual( "30", p.C.TZ.Value );
			}
		}

		[Test]
		public void Inner()
		{
			var p = new UX.Observable.Inner();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("one", p.A.Value);
				Assert.AreEqual("one", p.C.Value);
				Assert.AreEqual("d-one",p.D.Value);

				p.A.Value = "two";
				root.StepFrameJS();
				Assert.AreEqual("two", p.A.Value);
				Assert.AreEqual("two", p.C.Value);

				p.Swap.Perform();
				root.StepFrameJS();
				Assert.AreEqual("two",p.A.Value);
				Assert.AreEqual("d-one",p.C.Value);
				Assert.AreEqual("d-one",p.D.Value);

				p.D.Value = "d-two";
				root.StepFrameJS();
				Assert.AreEqual("two",p.A.Value);
				Assert.AreEqual("d-two",p.C.Value);
				Assert.AreEqual("d-two",p.D.Value);
			}
		}

		[Test]
		[Ignore("https://github.com/fusetools/fuselibs-public/issues/671", "Android || iOS")]
		public void InnerInner()
		{
			var p = new UX.Observable.InnerInner();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("one", p.A.Value);
				Assert.AreEqual("one", p.C.Value);
				Assert.AreEqual("d-one",p.D.Value);

				p.A.Value = "two";
				root.StepFrameJS();
				Assert.AreEqual("two", p.A.Value);
				Assert.AreEqual("two", p.C.Value);

				p.Swap.Perform();
				root.StepFrameJS();
				Assert.AreEqual("two",p.A.Value);
				Assert.AreEqual("d-one",p.C.Value);
				Assert.AreEqual("d-one",p.D.Value);

				p.D.Value = "d-two";
				root.StepFrameJS();
				Assert.AreEqual("two",p.A.Value);
				Assert.AreEqual("d-two",p.C.Value);
				Assert.AreEqual("d-two",p.D.Value);
			}
		}

		[Test]
		public void InnerTwoWay()
		{
			var p = new UX.Observable.InnerTwoWay();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("one", p.A.Value);
				Assert.AreEqual("one", p.C.Value);
				Assert.AreEqual("d-one", p.D.Value);

				p.A.Value = "two";
				root.StepFrameJS();
				Assert.AreEqual("two", p.A.Value);
				Assert.AreEqual("two", p.C.Value);

				p.C.Value = "three";
				root.StepFrameJS();
				Assert.AreEqual("three", p.A.Value);
				Assert.AreEqual("three", p.C.Value);

				p.Swap.Perform();
				root.StepFrameJS();
				Assert.AreEqual("three", p.A.Value);
				Assert.AreEqual("d-one", p.C.Value);
				Assert.AreEqual("d-one", p.D.Value);

				p.D.Value = "d-two";
				root.StepFrameJS();
				Assert.AreEqual("three", p.A.Value);
				Assert.AreEqual("d-two", p.C.Value);
				Assert.AreEqual("d-two", p.D.Value);
			}
		}

		[Test]
		public void TwoWaySimple()
		{
			var p = new UX.Observable.TwoWaySimple();
			using (var dg = new RecordDiagnosticGuard())
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("1-2", p.A.Value);
				Assert.AreEqual("1",p.C.Value);

				p.C.Value = "3";
				root.StepFrameJS();
				//two-way just doesn't work correctly
				//Assert.AreEqual("3-2", p.A.Value);
				Assert.AreEqual("3",p.C.Value);

				var diagnostics = dg.DequeueAll();
				Assert.AreEqual(1, diagnostics.Count);
				Assert.Contains("twoWayMap", diagnostics[0].Message);
			}
		}

		[Test]
		//copied from Map, since a non-observable .inner should behave just like .map with identity functions
		public void InnerTwoWayNonObservable()
		{
			var p = new UX.Observable.InnerTwoWayNonObservable();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("a", p.SC.JoinValues());
				Assert.AreEqual("a", p.OC.JoinValues());

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("a,b", p.OC.JoinValues());
				Assert.AreEqual("a,b", p.SC.JoinValues());

				p.Step2.Perform();
				root.StepFrameJS();
				Assert.AreEqual("c,a,b", p.OC.JoinValues());
				Assert.AreEqual("c,a,b", p.SC.JoinValues());

				p.Step3.Perform();
				root.StepFrameJS();
				Assert.AreEqual("c,b", p.OC.JoinValues());
				Assert.AreEqual("c,b", p.SC.JoinValues());

				p.Step4.Perform();
				root.StepFrameJS();
				Assert.AreEqual("c,d,e,f,g,b", p.OC.JoinValues());
				Assert.AreEqual("c,d,e,f,g,b", p.SC.JoinValues());

				p.Step5.Perform();
				root.StepFrameJS();
				Assert.AreEqual("c,d,b", p.OC.JoinValues());
				Assert.AreEqual("c,d,b", p.SC.JoinValues());

				p.Step6.Perform();
				root.StepFrameJS();
				Assert.AreEqual("c,d,h", p.OC.JoinValues());
				Assert.AreEqual("c,d,h", p.SC.JoinValues());

				p.Step7.Perform();
				root.StepFrameJS();
				Assert.AreEqual("", p.OC.JoinValues());
				Assert.AreEqual("", p.SC.JoinValues());

				p.Step8.Perform();
				root.StepFrameJS();
				Assert.AreEqual("i", p.OC.JoinValues());
				Assert.AreEqual("i", p.SC.JoinValues());
			}
		}

		[Test]
		public void MapObservableInner()
		{
			var p = new UX.Observable.MapObservableInner();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual(3, p.R.Value);
				Assert.AreEqual("0,1,2",p.OC.JoinValues());

				p.R.Value = 5;
				root.StepFrameJS();
				Assert.AreEqual(5, p.R.Value);
				Assert.AreEqual("0,1,2,3,4",p.OC.JoinValues());

				p.R.Value = 0;
				root.StepFrameJS();
				Assert.AreEqual(0, p.R.Value);
				Assert.AreEqual("",p.OC.JoinValues());
			}
		}

		[Test]
		public void FlatMap()
		{
			var p = new UX.Observable.FlatMap();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("", p.N.Value);

				p.Parameter = "\"A\"";
				root.StepFrameJS();
				Assert.AreEqual("inA", p.N.Value);

				p.Parameter = "\"B\"";
				root.StepFrameJS();
				Assert.AreEqual("inB", p.N.Value);

				p.Step1.Perform();
				root.StepFrameJS();
				Assert.AreEqual("inB*", p.N.Value);
			}
		}

		[Test]
		public void FlatMapWhere()
		{
			var p = new UX.Observable.FlatMapWhere();
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("R1,R2",GetText(p.P));

				p.GotoOther.Perform();
				root.StepFrameJS();
				Assert.AreEqual("O1,O2,O3",GetText(p.P));

				p.GotoGreens.Perform();
				root.StepFrameJS();
				Assert.AreEqual("",GetText(p.P));
			}
		}

		[Test]
		//this tests a deprecated API (the internal mechinism must make these guarantees though, so if
		//removed create an equivalent internal test)
		public void BeginSubscriptions()
		{
			var p = new UX.Observable.BeginSubscriptions();
			using (var dg = new RecordDiagnosticGuard())
			using (var root = TestRootPanel.CreateWithChild(p))
			{
				root.StepFrameJS();
				Assert.AreEqual("", p.W.JoinValues());

				p.Add.Perform();
				root.StepFrameJS();
				Assert.AreEqual("W", p.W.JoinValues());

				p.Remove.Perform();
				root.StepFrameJS();
				Assert.AreEqual("", p.W.JoinValues());

				var diagnostics = dg.DequeueAll();
				Assert.AreEqual(2, diagnostics.Count);
				Assert.Contains("beginSubscriptions", diagnostics[0].Message);
				Assert.Contains("endSubscriptions", diagnostics[1].Message);
			}
		}
	}
}
