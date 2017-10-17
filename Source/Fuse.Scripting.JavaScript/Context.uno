using Uno;
using Uno.UX;
using Uno.Collections;
using Uno.Compiler;
using Fuse.Scripting;
using Uno.Testing;
using Uno.Threading;

namespace Fuse.Scripting.JavaScript
{
	public abstract class JavaScriptContext: Scripting.Context
	{
		static JavaScriptContext()
		{
			// Make sure all objects have script classes
			ScriptClass.Register(typeof(object));
		}

		protected JavaScriptContext() : base()
		{
		}
	}
}
