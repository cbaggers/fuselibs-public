using Uno;
using Uno.Collections;
using Fuse.Scripting;
using Fuse.Reactive;

namespace Fuse.Scripting.JavaScript
{
	class TreeObservable: TreeObject, IMirror
	{
		// TreeObservable requires unsafe access to the context. For more info please see this ticket:
		// https://github.com/fusetools/fuselibs-public/issues/639
		readonly Scripting.Context _context;

		public TreeObservable(Scripting.Context context, Scripting.Object obj) : base(obj)
		{
			_context = context;
			Set(context, this, obj);
			Subscribe();
		}

		void Subscribe()
		{
			var obj = (Scripting.Object)Raw;
			obj["__fuse_set"] = (Callback)Set;
			obj["__fuse_add"] = (Callback)Add;
			obj["__fuse_removeAt"] = (Callback)RemoveAt;
			obj["__fuse_insertAt"] = (Callback)InsertAt;
		}

		public override void Unsubscribe()
		{
			Fuse.Reactive.JavaScript.Worker.Invoke(NullifyCallbacks);
		}

		void NullifyCallbacks()
		{
			var obj = (Scripting.Object)Raw;
			obj["__fuse_set"] = null;
			obj["__fuse_add"] = null;
			obj["__fuse_removeAt"] = null;
			obj["__fuse_insertAt"] = null;
		}

		Dictionary<long, ValueMirror> _reflections = new Dictionary<long, ValueMirror>();

		public object Reflect(Scripting.Context context, object obj)
		{
			if (obj is Scripting.Function)
				return new FunctionMirror((Scripting.Function)obj);

			if (obj is Scripting.Object || obj is Scripting.Array)
			{
				var id = GetId(context, obj);
				if (id < 0)
				{
					throw new Exception("Expected TreeObservable node to have an ID");
				}

				ValueMirror res;
				if (_reflections.TryGetValue(id, out res))
					return res;


				if (obj is Scripting.Object)
				{
					var so = (Scripting.Object)obj;
					var k = new TreeObject(so);
					_reflections.Add(id, k); // Important to add to dictionary *before* calling Set
					k.Set(context, this, so);
					return k;
				}

				if (obj is Scripting.Array)
				{
					var sa = (Scripting.Array)obj;
					var k = new TreeArray(sa);
					_reflections.Add(id, k); // Important to add to dictionary *before* calling Set
					k.Set(context, this, sa);
					return k;
				}
			}

			return obj;
		}

		long GetId(Scripting.Context context, object obj)
		{
			var func = (Function)context.Evaluate("(get node ID)", "(function(obj) { if (obj instanceof Object && typeof obj.__fuse_id  !== 'undefined') return obj.__fuse_id; return -1 })");
			var res = func.Call(context, obj);
			if (res is double) return (long)(double)res;
			if (res is int) return (long)(int)res;
			if (res is long) return (long)res;
			return -1;
		}

		object Set(Fuse.Scripting.Context context, object[] args)
		{
			new SetOperation(context, this, args);
			return null;
		}

		object Add(Fuse.Scripting.Context context, object[] args)
		{
			new AddOperation(context, this, args);
			return null;
		}

		object RemoveAt(Fuse.Scripting.Context context, object[] args)
		{
			new RemoveAtOperation(this, args);
			return null;
		}

		object InsertAt(Fuse.Scripting.Context context, object[] args)
		{
			new InsertAtOperation(context, this, args);
			return null;
		}

		abstract class Operation
		{
			protected readonly TreeObservable TreeObservable;
			protected readonly object[] Arguments;
			protected Operation(TreeObservable inst, object[] args)
			{
				Arguments = args;
				TreeObservable = inst;
				UpdateManager.PostAction(PerformStart);
			}

			void PerformStart()
			{
				Perform(TreeObservable, 0);
			} 

			protected abstract int SpecialArgCount { get; }
			protected abstract void Perform(object dc);

			void Perform(object dc, int pos)
			{
				if (pos > Arguments.Length - SpecialArgCount)
				{
					// Replace entire state
					// WARNING: UNSAFE USE OF CACHED JS CONTEXT
					// See issue linked at definition of _context
					TreeObservable.Set(TreeObservable._context, TreeObservable, (Scripting.Object)Arguments[0]);
					return;
				}

				if (pos == Arguments.Length - SpecialArgCount)
				{
					Perform(dc);
					return;
				}

				var obj = dc as TreeObject;
				if (obj != null)
				{
					var key = Arguments[pos].ToString();
					Perform(obj[key], pos+1);
					return;
				}

				var arr = dc as TreeArray;
				if (arr != null)
				{
					var index = Marshal.ToInt(Arguments[pos]);
					Perform(arr[index], pos+1);
					return;
				}

				throw new Error("Unable to update data context. Path doesn't match exports");
			}
		}

		abstract class ValueOperation: Operation
		{
			protected ValueOperation(Scripting.Context context, TreeObservable inst, object[] args): base(inst, args)
			{
				WrappedValue = inst.Reflect(context, args[args.Length-1]);
			}

			protected readonly object WrappedValue;
		}

		class SetOperation: ValueOperation
		{
			public SetOperation(Scripting.Context context, TreeObservable inst, object[] args): base(context, inst, args) {}
			protected override int SpecialArgCount { get { return 2; } }

			protected override void Perform(object dc)
			{
				var key = Arguments[Arguments.Length-2];

				var obj = dc as TreeObject;
				if (obj != null) obj.Set(key.ToString(), WrappedValue, null);

				var arr = dc as TreeArray;
				if (arr != null) arr.Set(Marshal.ToInt(key), WrappedValue);
			}
		}

		class AddOperation: ValueOperation
		{
			public AddOperation(Scripting.Context context, TreeObservable inst, object[] args): base(context, inst, args)
			{
			}

			protected override int SpecialArgCount { get { return 1; } }
			protected override void Perform(object dc)
			{
				var arr = dc as TreeArray;
				if (arr != null) arr.Add(WrappedValue);
			}
		}

		class InsertAtOperation: ValueOperation
		{
			public InsertAtOperation(Scripting.Context context, TreeObservable inst, object[] args): base(context, inst, args)
			{
				_index = Marshal.ToInt(Arguments[Arguments.Length-2]);
			}
			protected override int SpecialArgCount { get { return 2; } }

			int _index;

			protected override void Perform(object dc)
			{
				var arr = dc as TreeArray;
				if (arr != null) arr.InsertAt(_index, WrappedValue);
			}
		}

		class RemoveAtOperation: Operation
		{
			public RemoveAtOperation(TreeObservable inst, object[] args): base(inst, args)
			{
				_index = Marshal.ToInt(Arguments[Arguments.Length-1]);
			}

			int _index;

			protected override int SpecialArgCount { get { return 1; } }

			protected override void Perform(object dc)
			{
				var arr = dc as TreeArray;
				if (arr != null) arr.RemoveAt(_index);
			}
		}
	}
}
