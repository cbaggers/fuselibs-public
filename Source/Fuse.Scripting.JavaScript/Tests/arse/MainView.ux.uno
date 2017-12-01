using Uno;
using Uno.UX;
using Uno.Collections;
using Uno.Compiler.ExportTargetInterop;
using Uno.Compiler.ExportTargetInterop.Android;
using Fuse;
using Fuse.Triggers;
using Fuse.Controls;
using Fuse.Controls.Native;
using Fuse.Controls.Native.Android;

[ForeignInclude(Language.Java, "@(Activity.Package).@(Activity.Name)")]
public partial class MainView
{
	extern(android) void DoGC(object a1, EventArgs a2)
	{
		Fuse.Scripting.JavaScriptCore.HORSE.GLUE();
	}

	extern(!android) void DoGC(object a1, EventArgs a2) {}
}
