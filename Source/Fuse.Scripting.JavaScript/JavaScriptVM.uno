//using Uno;
using Uno.UX;
using Uno.Collections;
using Uno.Compiler;
using Fuse.Scripting;
using Uno.Testing;
using Uno.Threading;
using Fuse.Reactive;

namespace Fuse.Scripting.JavaScript
{
	internal static class JavaScriptVM
	{
		static object _handle = new object();
		static ThreadWorker _threadWorker;

		public static ThreadWorker ThreadWorker
		{
			get
			{
				lock (_handle)
				{
					if (_threadWorker == null)
					{
						_threadWorker = new Fuse.Scripting.JavaScript.ThreadWorker();
					}
					return _threadWorker;
				}
			}
		}
	}
}
