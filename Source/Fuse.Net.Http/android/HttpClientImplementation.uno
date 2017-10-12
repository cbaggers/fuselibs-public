using Uno;
using Uno.Collections;
using Uno.Compiler.ExportTargetInterop;

namespace Fuse.Net.Http
{
	[ForeignInclude(Language.Java, "com.fusetools.http.*")]
	extern(Android) class HttpClientImplementation
	{
		Uno.Threading.Promise<Response> _promise;
		HttpClient _client;

		public HttpClientImplementation(HttpClient client)
		{
			_client = client;
		}

		public Uno.Threading.Future<Response> SendAsync(Request request)
		{
			_promise = new Uno.Threading.Promise<Response>();
			debug_log "Run";

			connect(request.Url, Continue);

			return _promise;
		}

		[Foreign(Language.Java)]
		void connect(string uri, Action<string> cont)
		@{
			HttpTest client = new HttpTest();
			client.callback = new MyCallback() {
				public void onDone(String response) {
					cont.run(response);
				}
			};
			client.createRequest(uri);
		@}

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
	}
}
