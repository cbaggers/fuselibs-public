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
}
