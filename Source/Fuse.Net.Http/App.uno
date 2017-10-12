using Uno;
using Uno.Collections;
using Uno.Threading;
using Fuse.Net.Http;

public partial class App2
{
	HttpClient _client;
	HttpCancelationToken _cancelToken;

	public App2()
	{
		InitializeUX();
		debug_log "Create client";
		_client = new HttpClient();
	}

	void sendRequest(object a1, EventArgs a2)
	{
		CreateRequest();
	}

	void CreateRequest()
	{
		if (this.isBusy.IsActive)
		{
			debug_log "Already active";
			return;
		}
		this.isBusy.IsActive = true;
		_cancelToken = new HttpCancelationToken();
		// change to SendAsync
		_client.Send(new Request("https://uno-http-testing.azurewebsites.net/cors/delay/1500"), _cancelToken).Then(Log, Error);
	}

	void Log(Response response)
	{
		if (response != null)
		{
			debug_log response.ContentLength;			
		}
		else
		{
			debug_log "response was null";
		}
		this.isBusy.IsActive = false;
	}

	void Error(Exception exception)
	{
		debug_log "Request failed: " + exception.Message;
		this.isBusy.IsActive = false;
	}

	public void Cancel()
	{
		_cancelToken.Cancel();
	}

	void Progress()
	{

	}
}

public class HttpCancelationToken
{
	public void Cancel()
	{}
}

namespace Fuse.Net.Http
{
	public class Request
	{
		public string Url { get; set; }

		public Request(string url)
		{
			Url = url;
		}
	}

	public class HttpClient
	{
		HttpClientImplementation _impl;

		public HttpClient()
		{
			debug_log "init HttpClient";
			_impl = new HttpClientImplementation();
		}

		public Future<Response> Send(Request request, HttpCancelationToken c)
		{
			return _impl.SendAsync(request, c);
		}
	}

	extern(!DOTNET) class HttpClientImplementation
	{
		public Future<Response> SendAsync(Request request, HttpCancelationToken c)
		{
			if defined(Android)
				return new HttpClientAndroid().SendAsync(request, c);

			debug_log "Target not dotnet";
			return null;
		}
	}

	extern(DOTNET && HOST_MAC) class HttpClientImplementation : NSUrlSessionDelegate
	{
		Promise<Response> _response;
		
		public HttpClientImplementation()
		{
			//NSApplication.Init();
			_response = new Promise<Response>();
		}
		
		public Future<Response> SendAsync(Request request, HttpCancelationToken c)
		{
			debug_log "Run";
			var url = NSUrl.FromString(request.Url);
			debug_log url.AbsoluteString;

			var nsUrlRequest = NSUrlRequest.FromUrl(url);

			using (var configuration = NSUrlSessionConfiguration.DefaultSessionConfiguration)
			{
				var _session = NSUrlSession.FromConfiguration(configuration, this, null);
				//var _session = NSUrlSession.SharedSession;
				debug_log "CreateDataTask";
				var task = _session.CreateDataTask(nsUrlRequest, Callback);
				task.Resume();
			}
			debug_log "done run";
			return _response;
		}

		void Callback(NSData data, NSUrlResponse response, NSError error) 
		{
			try
			{
				debug_log "Log:!!";
				if (response == null)
				{
					debug_log "response is null";
				}
				else
				{
					var httpResponse = new Response();
					httpResponse.ContentLength = response.ExpectedContentLength.ToString();
					_response.Resolve(httpResponse);
					return;
				}

				if (data == null)
					debug_log "data is null";
				/*else
					debug_log data.ToString();*/
				//response.Dispose();
				_response.Reject(new Exception("Something wrong happened"));
			}
			catch (Exception e)
			{
				debug_log "Errorlol " + e.Message;
				_response.Reject(e);
			}
			debug_log "log end!";
		}
		
		public override void DidBecomeInvalid(NSUrlSession session, NSError error)
		{
			debug_log "DidBecomeInvalid";
		}

		public override void DidFinishEventsForBackgroundSession(NSUrlSession session)
		{
			debug_log "DidFinishEventsForBackgroundSession";
		}

		public override void DidReceiveChallenge(NSUrlSession session, NSUrlAuthenticationChallenge challenge, Action<NSUrlSessionAuthChallengeDisposition, NSUrlCredential> completionHandler)
		{
			debug_log "DidReceiveChallenge";
			if(challenge.ProtectionSpace.AuthenticationMethod == "NSURLAuthenticationMethodServerTrust")
			{
				debug_log challenge.ProtectionSpace.Host;
				if(challenge.ProtectionSpace.Host == "uno-http-testing.azurewebsites.net")
				{
					var credential = NSUrlCredential.FromTrust(challenge.ProtectionSpace.ServerSecTrust);
					completionHandler(NSUrlSessionAuthChallengeDisposition.UseCredential, credential);
					return;
				}
			}
			completionHandler(NSUrlSessionAuthChallengeDisposition.CancelAuthenticationChallenge, null);
		}
	}
}
