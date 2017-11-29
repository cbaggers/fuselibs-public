comment out

```
_moduleResult.Dispose();
_moduleResult = null;
```

in `ModuleInstance.uno` and it breaks faster 

from 12 `RunOnce` steps to 9

.. 

Well it's still `EvaluateModule` that dies

```
::g::Fuse::Scripting::ModuleResult* newModuleResult = uPtr(uPtr(_js)->ScriptModule())->Evaluate1(ctx, globalId);
```

some of the things in the `STRINGS` for the dying scriptmodule are odd

[5] = {uString * | 0xac0ef930} 0xac0ef930
uObject = {uObject} 
_ptr = {char16_t * | 0xac0ef948} u"(function (cl, callback) { cl.prototype."
_length = {int32_t} 40

ah no it's fine..just some string math going on on those

```
"(function(module, exports, require) {
	var test = function() {
		var makeFat = function(length) {
			var data = [];
			for(var i = 0; i < length; i++) {
				data.push(\"jamHam\");
			}
			return data;
		}
		makeFat(10000);
		return null;
	}
	test();
 })"
```
-----------------------------------

Ok so wtf. It dies on a call to an object that was apparently just created..however the log suggests it was protected ages ago
