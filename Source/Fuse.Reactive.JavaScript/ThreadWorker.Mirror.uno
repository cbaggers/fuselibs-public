using Fuse.Scripting;
using Uno;
using Uno.Collections;
using Uno.Threading;
using Fuse.Scripting.JavaScript;

namespace Fuse.Reactive
{
	public class TypeMirror : IMirror
	{
		// Used for stack overflow protection
		int _reflectionDepth;
		JavaScriptContext _context;

		public TypeMirror(JavaScriptContext context)
		{
			_context = context;
		}

		public object Reflect(object obj)
		{
			var e = obj as Scripting.External;
			if (e != null) return e.Object;

			var sobj = obj as Scripting.Object;
			if (sobj != null)
			{
				if (sobj.ContainsKey("external_object"))
				{
					var ext = sobj["external_object"] as Scripting.External;
					if (ext != null) return ext.Object;
				}
			}

			_reflectionDepth++;
			var res = CreateMirror(obj);
			_reflectionDepth--;

			if (res != null) return res;

			return obj;
		}

		object CreateMirror(object obj)
		{
			if (_reflectionDepth > 50)
			{
				Diagnostics.UserWarning("JavaScript data model contains circular references or is too deep. Some data may not display correctly.", this);
				return null;
			}
			
			var a = obj as Scripting.Array;
			if (a != null)
			{
				return new ArrayMirror(this, a);
			}

			var f = obj as Scripting.Function;
			if (f != null)
			{
				return new FunctionMirror(_context, f);
			}

			var o = obj as Scripting.Object;
			if (o != null)
			{
				if (o.InstanceOf(_context.Observable)) 
				{
					return new Observable(_context, o, false);
				}
				else if (o.InstanceOf(_worker.FuseJS.Date))
				{
					return DateTimeConverterHelpers.ConvertDateToDateTime(_context, o);
				}
				else
				{
					return new ObjectMirror(this, o);	
				}
			}

			return null;
		}
	}
}
