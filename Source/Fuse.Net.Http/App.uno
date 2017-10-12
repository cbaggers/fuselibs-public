using Uno;
using Uno.Threading;
using Fuse.Net.Http;

public partial class App2
{
	HttpClient _client;

	public App2()
	{
		_client = new HttpClient();
		InitializeUX();
	}

	void SendRequest(object a1, EventArgs a2)
	{
		if (!this.isBusy.IsActive)
		{
			this.isBusy.IsActive = true;
			var request = new Request("https://uno-http-testing.azurewebsites.net/cors/delay/1500");
			_client.Send(request).Then(HandleResponse, Error);
		}
	}

	void HandleResponse(Response response)
	{
		if (response != null)
		{
			debug_log response.ContentLength;
			//response.Body.AsString().Then(PrintString, Error);
			//response.Body.AsStream().Then(ConvertStream, Error);
		}
		else
		{
			debug_log "response was null";
		}
		this.isBusy.IsActive = false;
	}
	
	void PrintString(Response response, string content)
	{
		debug_log content;
	}

	/*void ConvertStream(Response response, Stream stream)
	{
		using(var streamReader = new Uno.IO.streamReader())
		{
			PrintString(response, streamReader.ReadToEnd());
		}
	}*/

	void Error(Exception exception)
	{
		debug_log "Request failed: " + exception.Message;
		this.isBusy.IsActive = false;
	}
}
