using Uno;
using Uno.Collections;
using Uno.Text;
using Uno.Threading;
using Uno.IO;
using Uno.UX;

namespace Fuse.Scripting
{
	public interface IThreadWorker
	{
		Function Observable { get; }
		IDispatcher Dispatcher { get; }
	}

	public interface ITypeWrapper
	{
		object Unwrap(object obj);
		object Wrap(object obj);
	}

	public interface IMirror
	{
		object Reflect(object obj);
	}

	public abstract partial class Context: Uno.IDisposable
	{
		ConcurrentDictionary<string, ModuleResult> _moduleResults = new ConcurrentDictionary<string, ModuleResult>();

		public void RegisterGlobalModuleResult(ModuleResult result)
		{
			if (result.Id == null) return;

			_moduleResults.Add(result.Id, result);
		}

		public ModuleResult TryGetGlobalModuleResult(string id)
		{
			if (id == null) return null;

			if (_moduleResults.ContainsKey(id)) return _moduleResults[id];
			return null;
		}

		internal void DeleteGlobalModuleResult(ModuleResult mr)
		{
			if (mr.Id == null) return;

			if (_moduleResults.ContainsKey(mr.Id))
				_moduleResults.Remove(mr.Id);
		}

		string Escape(string str)
		{
			var sb = new StringBuilder();
			for (int i = 0; i < str.Length; ++i)
			{
				char c = str[i];
				switch (c)
				{
					case '\\': sb.Append("\\\\"); break;
					case '\'': sb.Append("\\'"); break;
					case '"': sb.Append("\\\""); break;
					default: sb.Append(new char[] {c}); break;
				}
			}
			return sb.ToString();
		}

		readonly IThreadWorker _worker;

		protected Context()
		{
			_worker = AquireThreadWorker();
			Mirror = AquireMirror();
			TypeWrapper = AquireTypeWrapper(this);
		}

		protected abstract IThreadWorker AquireThreadWorker(); // new ThreadWorker();
		protected abstract IMirror AquireMirror();
		protected abstract ITypeWrapper AquireTypeWrapper(Scripting.Context ctx);

		public IThreadWorker ThreadWorker { get { return _worker; } }
		public readonly IMirror Mirror;
		readonly ITypeWrapper TypeWrapper;

		public object Wrap(object obj) { return TypeWrapper.Wrap(obj); }
		public object Unwrap(object obj) { return TypeWrapper.Unwrap(obj); }

		public IDispatcher Dispatcher { get { return _worker.Dispatcher; } }

		public void Invoke(Action action)
		{
			_worker.Dispatcher.Invoke(action);
		}

		public Function Observable
		{
			get { return _worker.Observable; }
		}

		Function _identity;

		public Function CallbackToFunction(Callback c)
		{
			if (_identity == null) 
				_identity = (Function)Evaluate("(Context)", "(function(x) { return x; })");

			return (Function)_identity.Call(c);
		}

		public void ObjectDefineProperty(Object obj, string name, Callback getProperty, Callback setProperty = null, bool enumerable = false, bool configurable = false)
		{
			var func = Evaluate(name, "(function(obj, name, getCallback, setCallback, e, c) { Object.defineProperty(obj, name, { get: getCallback, "
				+ (setProperty != null ? " set: setCallback," : "") + " enumerable: e, configurable: c }); })") as Scripting.Function;
			func.Call(obj, name, getProperty, setProperty, enumerable, configurable);
		}

		public void ObjectDefineProperty(Object obj, string name, object value, bool enumerable = false, bool configurable = false)
		{
			var func = Evaluate(name, "(function(obj, name, value, e, c) { Object.defineProperty(obj, name, { value: value, enumerable: e, configurable: c }); })") as Scripting.Function;
			func.Call(obj, name, value, enumerable, configurable);
		}

		public Object ObjectCreate(params object[] args)
		{
			var objectCreate = Evaluate("(Context)", "Object.create") as Scripting.Function;
			if(objectCreate != null)
				return objectCreate.Call(args) as Scripting.Object;

			return null;
		}

		Function _parseJson;
		public object ParseJson(string json)
		{
			if (_parseJson == null)
				_parseJson = (Function)Evaluate("(Context)", "JSON.parse");

			return _parseJson.Call(json);
		}

		Function _newObject;
		public Object NewObject()
		{
			if (_newObject == null) _newObject = (Function)Evaluate("(Context)", "(function() { return new Object; })");
			return (Object)_newObject.Call();
		}

		Function _newArray;
		public Array NewArray(params object[] values)
		{
			if (_newArray == null) _newArray = (Function)Evaluate("(Context)", "(function(count) { return new Array(count); })");
			var a = (Array)_newArray.Call(values.Length);
			for (int i = 0; i < values.Length; i++) a[i] = values[i];
			return a;
		}

		Function _newError;
		public Object NewError(params object[] args)
		{
			_newError = GlobalObject["Error"] as Function;
			return _newError.Construct(args);
		}

		public abstract object Evaluate(string fileName, string code);
		public abstract Object GlobalObject { get; }
		public abstract void Dispose();
	}
}
