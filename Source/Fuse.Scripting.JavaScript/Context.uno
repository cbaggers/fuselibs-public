using Uno;
using Uno.UX;
using Uno.Collections;
using Uno.Compiler;
using Fuse.Scripting;
using Uno.Testing;
using Uno.Threading;

namespace Fuse.Scripting.JavaScript
{
	public interface ITypeWrapper
	{
		object Unwrap(object obj);
		object Wrap(object obj);
		void Initialize(Context context);
	}

	public interface IMirror
	{
		object Reflect(object obj);
	}

	public abstract class JavaScriptContext: Scripting.Context
	{
		readonly ITypeWrapper TypeWrapper;

		protected abstract IMirror AquireMirror(JavaScriptContext context);
		public readonly IMirror Mirror;

		static JavaScriptContext()
		{
			// Make sure all objects have script classes
			ScriptClass.Register(typeof(object));
		}

		protected JavaScriptContext(ITypeWrapper typeWrapper) : base()
		{
			typeWrapper.Initialize(this);
			TypeWrapper = typeWrapper;
			Mirror = AquireMirror(this);
		}

		public override object Wrap(object obj) { return TypeWrapper.Wrap(obj); }
		public override object Unwrap(object obj) { return TypeWrapper.Unwrap(obj); }
	}
}
