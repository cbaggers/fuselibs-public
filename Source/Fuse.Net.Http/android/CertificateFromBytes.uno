using Uno;
using Uno.Threading;
using Uno.Collections;
using Uno.Compiler.ExportTargetInterop;
using Fuse.Scripting;

namespace Fuse.Net.Http
{
	[ForeignInclude(Language.Java,
					"java.io.InputStream",
					"java.security.cert.CertificateFactory",
					"java.security.cert.X509Certificate")]
	extern(android)
	public class LoadCertificateFromBytes : Promise<X509Certificate>
	{
		public LoadCertificateFromBytes(byte[] data)
		{
			var buf = ForeignDataView.Create(data);
			var inputStream = MakeBufferInputStream(buf);
			LoadCertificateFromInputStream(inputStream);
		}

		[Foreign(Language.Java)]
		static Java.Object MakeBufferInputStream(Java.Object buf) // UnoBackedByteBuffer buf
		@{
			return new com.fuse.android.ByteBufferInputStream((com.uno.UnoBackedByteBuffer)buf);
		@}

		[Foreign(Language.Java)]
		void LoadCertificateFromInputStream(Java.Object inputStream)
		@{
			try
			{
				CertificateFactory fact = CertificateFactory.getInstance("X.509");
				X509Certificate cer = (X509Certificate)fact.generateCertificate((InputStream)inputStream);
				@{LoadCertificateFromBytes:Of(_this).Resolve(Java.Object):Call(cer)};
			}
			catch (Exception e)
			{
				@{LoadCertificateFromBytes:Of(_this).Reject(string):Call("Could not load certificate from byte\nReason: " + e.getMessage())};
			}
		@}

		void Resolve(Java.Object cert)
		{
			// TODO: Extract details here
			Resolve(new X509Certificate("a", "b", "c"));
		}

		void Reject(string reason)
		{
			Reject(new Exception(reason));
		}
	}
}
