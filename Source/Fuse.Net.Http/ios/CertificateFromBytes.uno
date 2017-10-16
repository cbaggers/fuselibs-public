using Uno;
using Uno.Threading;
using Uno.Collections;
using Uno.Compiler.ExportTargetInterop;
using Fuse.Scripting;

namespace Fuse.Net.Http
{
	[Require("Xcode.Framework", "Security.framework")]
	[Require("Source.Include", "Security/Security.h")]
	[Set("Include", "Security/Security.h")]
	[Set("TypeName", "SecCertificateRef")]
	[Set("DefaultValue", "NULL")]
	[Set("FileExtension", "mm")]
	[TargetSpecificType]
	extern(iOS) struct SecCertHandle
	{
		public static bool IsNull(SecCertHandle lhs)
		{
			return extern<bool>(lhs)"$0 == NULL";
		}
	}

	[Require("Entity","SecCertHandle")]
	extern(iOS)
	public class LoadCertificateFromBytes : Promise<X509Certificate>
	{
		public LoadCertificateFromBytes(byte[] data) : this(ForeignDataView.Create(data)) {}

		public LoadCertificateFromBytes(ForeignDataView view)
		{
			var certRef = Impl(view);
			if (!SecCertHandle.IsNull(certRef))
			{
				// TODO: Extract details here
				Resolve(new X509Certificate("a", "b", "c"));
			}
			else
			{
				Reject(new Exception("LoadCertificateFromBytes Failed. Certificate was null"));
			}
		}

		[Foreign(Language.ObjC)]
		static SecCertHandle Impl(ForeignDataView view)
		@{
			return SecCertificateCreateWithData(NULL, (__bridge CFDataRef)view);
		@}
	}
}
