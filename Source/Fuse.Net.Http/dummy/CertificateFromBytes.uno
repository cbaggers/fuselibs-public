using Uno;
using Uno.Collections;
using Uno.Threading;

namespace Fuse.Net.Http
{
	extern(!android && !iOS)
	public class LoadCertificateFromBytes : Promise<X509Certificate>
	{
		public LoadCertificateFromBytes(byte[] data)
		{
			Reject(new Exception("LoadCertificateFromBytes is not implemented on this platform"));
		}
	}
}
