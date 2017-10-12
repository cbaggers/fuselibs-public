using Uno.Threading;

namespace Fuse.Net.Http
{
	public class HttpClient
	{
		HttpClientImplementation _impl;

		public HttpClient()
		{
			debug_log "init HttpClient";
			_impl = new HttpClientImplementation();
		}

		public Future<Response> Send(Request request)
		{
			return _impl.SendAsync(request);
		}
	}
	extern(!DOTNET && !iOS && !Android) class HttpClientImplementation
	{
		public Future<Response> SendAsync(Request request)
		{
			debug_log "Target not supported";
			return null;
		}
	}
}
