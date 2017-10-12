namespace Fuse.Net.Http
{
	public class Response
	{
		//public StatusLine StatusLine { get; private set; }
		//public Headers Headers { get; private set; }
		public string ContentLength { get; set; }
		/*public Body? Body()
		{

		}*/
	}
}

/*HTTP message
	HTTP request message
		request-line
			method
			URI
			protocol version
		HeaderFields
		MessageBody
			payload body

	HTTP response message
		status-line
			HTTP-version
			status-code
			reason-phrase
		HeaderFields
*/
