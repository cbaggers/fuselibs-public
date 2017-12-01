using Uno;
using Uno.Threading;
using Uno.Compiler.ExportTargetInterop;

extern(!android)
public class Purple : Uno.Application
{
	public Purple()
	{
	}
}

extern(android)
public class Purple : Uno.Application
{
	public Purple()
	{
		var worker = new Fuse.Scripting.JavaScript.ThreadWorker();
		while (Fuse.Scripting.JavaScript.JSContext.FCTX == null) {}

		//Fuse.Scripting.JavaScriptCore.HORSE.GLUE(); // do gc
		worker.Invoke(Hmm);
		StepFrameJS(worker);
		worker.Invoke(Hmm);
		StepFrameJS(worker);
		worker.Invoke(Hmm);
		StepFrameJS(worker);
		worker.Invoke(Hmm);
		StepFrameJS(worker);
		worker.Invoke(Hmm);
		StepFrameJS(worker);
	}

	void Hmm(Fuse.Scripting.Context ctx)
	{
		Fuse.Scripting.JavaScriptCore.HORSE.GLUE(); // do gc
		ctx.Evaluate("(FOOO)", "var test = function() {\nvar makeFat = function(length) {\nvar data = [];\nfor(var i = 0; i < length; i++) {\ndata.push(\"jamHam\");\n}\nreturn data;\n}\nmakeFat(100000);\nreturn null;\n}\ntest();");
	}

	//-------------------

	static float _frameIncrement = 1/60f;

	enum StepFlags
	{
		None = 0,
		WaitJS = 1 << 0,
		IncrementFrame = 1 << 1,
	}

	static void StepFrameJS(Fuse.Scripting.JavaScript.ThreadWorker worker)
	{
		if (worker == null)
			throw new Exception("Calling stepFrameJS though there is no JavaScript worker" );

		var fence = worker.PostFence();
		var loop = true;
		var e = 0f;
		while (loop)
		{
			loop = !fence.IsSignaled;
			IncrementFrameImpl(worker, _frameIncrement, StepFlags.WaitJS | StepFlags.IncrementFrame);
			e += _frameIncrement;
		}
	}

	static void IncrementFrameImpl(Fuse.Scripting.JavaScript.ThreadWorker worker, float elapsedTime = -1, StepFlags flags = StepFlags.IncrementFrame)
	{
		debug_log "----------- wat 0 ----------";
		if (elapsedTime < 0)
			elapsedTime = _frameIncrement;
		debug_log "----------- wat 1 ----------";
		if (flags.HasFlag(StepFlags.WaitJS))
		{
			if (worker != null)
				worker.WaitIdle();
		}
		debug_log "----------- wat 2 ----------";
		Fuse.Time.Set(Fuse.Time.FrameTime + elapsedTime);
		Fuse.UpdateManager.Update();
		if (flags.HasFlag(StepFlags.IncrementFrame))
			Fuse.UpdateManager.IncreaseFrameIndex();
		debug_log "----------- wat 3 ----------";
	}
}
