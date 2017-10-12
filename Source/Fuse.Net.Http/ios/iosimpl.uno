using Uno;
using Uno.Compiler.ExportTargetInterop;
using Uno.Threading;

namespace Fuse.Net.Http
{
	[Require("Xcode.Framework", "Foundation.framework")]
	[ForeignInclude(Language.ObjC, "ios/HttpClientObjc.h")]
	extern(iOS) class HttpClientCILImplementation : IDisposable
	{
		ObjC.Object _client;
		Uno.Threading.Promise<Response> _promise;

		public HttpClientCILImplementation()
		{
			_client = Create();
		}
		
		[Foreign(Language.ObjC)]
		ObjC.Object Create()
		@{
			return [[HttpClientObjc alloc] init];
		@}

		
		public Future<Response> SendAsync(Request request, HttpCancelationToken c)
		{
			_promise = new Uno.Threading.Promise<Response>();
			Connect(request.Url, Continue);
			return _promise;
		}

		void Continue(string response)
		{
			debug_log "IsCompleted " + response;
			if (response != null)
			{
				debug_log "got response";
				
				_promise.Resolve(new Response());
			}
			else
			{
				debug_log "err";
				_promise.Reject(new Exception("SendAsync failed"));
			}
		}

		[Foreign(Language.ObjC)]
		void Connect(string strURL, Action<string> completeHandler)
		@{
			[@{HttpClientCILImplementation:Of(_this)._client:Get()} connect:strURL onCompleteHandler:^(NSString * response) {
					completeHandler(response);
				}];
		@}

		public void Dispose()
		{
			_client = null;
		}
	}
}