using Uno;
using Uno.Collections;
using Uno.Compiler.ExportTargetInterop;

using Uno.Threading;

namespace Foundation
{
	/*[DotNetType("MonoMac.AppKit.NSApplication")]
	extern(CIL && OSX) internal class NSApplication
	{
		public extern static void Init();
	}*/

	[DotNetType("Foundation.NSObject")]
	extern(DOTNET && HOST_MAC) public class NSObject
	{
	}

	[DotNetType("Foundation.NSUrl")]
	extern(DOTNET && HOST_MAC) public class NSUrl
	{
		public extern NSUrl(string urlString);

		public extern static NSUrl FromString(string s);

		public extern string AbsoluteString { get; }
	}

	[DotNetType("Foundation.NSUrlRequest")]
	extern(DOTNET && HOST_MAC) internal class NSUrlRequest
	{
		public static NSUrlRequest FromUrl(NSUrl url)
		{
			// return NSURLRequest *request = [NSURLRequest requestWithURL:URL];
			return null;
		}
	}

	[DotNetType("Foundation.NSUrlSession")]
	extern(DOTNET && HOST_MAC) internal class NSUrlSession
	{
		public extern static NSUrlSession FromConfiguration(NSUrlSessionConfiguration configuration, NSUrlSessionDelegate urlSessionDelegate, object delegateQueue);
		public static NSUrlSession SharedSession
		{
			get
			{
				//NSURLSession *session = [NSURLSession sharedSession];
				return null;
			}
		}

		public virtual NSUrlSessionDataTask CreateDataTask(NSUrlRequest request, NSUrlSessionResponse completionHandler)
		{
			 return null;
		}
	}

	[DotNetType("Foundation.NSUrlSessionResponse")]
	extern(DOTNET && HOST_MAC) internal delegate void NSUrlSessionResponse(NSData data, NSUrlResponse response, NSError error);

	[DotNetType("Foundation.NSUrlSessionDataTask")]
	extern(DOTNET && HOST_MAC) internal class NSUrlSessionDataTask
	{
		public extern void Resume();
		public extern void Cancel();
	}

	[DotNetType("Foundation.NSUrlResponse")]
	extern(DOTNET && HOST_MAC) internal class NSUrlResponse
	{
		public extern long ExpectedContentLength { get; }
	}
 
	[DotNetType("Foundation.NSError")]
	extern(DOTNET && HOST_MAC) internal class NSError
	{}

	[DotNetType("Foundation.NSData")]
	extern(DOTNET && HOST_MAC) internal class NSData
	{}

	[DotNetType("Foundation.NSUrlSessionConfiguration")]
	extern(DOTNET && HOST_MAC) internal class NSUrlSessionConfiguration : Uno.IDisposable
	{
		public extern static NSUrlSessionConfiguration DefaultSessionConfiguration { get; }
	}

	[DotNetType("Foundation.NSUrlSessionDelegate")]
	extern(DOTNET && HOST_MAC) internal class NSUrlSessionDelegate
	{
		public extern virtual void DidBecomeInvalid(NSUrlSession session, NSError error);

		public extern virtual void DidFinishEventsForBackgroundSession(NSUrlSession session);

		public extern virtual void DidReceiveChallenge(NSUrlSession session, NSUrlAuthenticationChallenge challenge, Action<NSUrlSessionAuthChallengeDisposition, NSUrlCredential> completionHandler);
	}

	[DotNetType("Foundation.NSUrlAuthenticationChallenge")]
	extern(DOTNET && HOST_MAC) internal class NSUrlAuthenticationChallenge
	{
		public extern virtual NSUrlProtectionSpace ProtectionSpace { get; }
	}

	[DotNetType("Foundation.NSUrlProtectionSpace")]
	extern(DOTNET && HOST_MAC) internal class NSUrlProtectionSpace
	{
		public extern virtual string AuthenticationMethod { get; }
		
		public extern virtual string Host { get; }

		public extern SecTrust ServerSecTrust { get; }
	}

	[DotNetType("Foundation.NSUrlCredential")]
	extern(DOTNET && HOST_MAC) internal class NSUrlCredential
	{
		public extern static NSUrlCredential FromTrust(SecTrust trust);
	}

	[DotNetType("Security.SecTrust")]
	extern(DOTNET && HOST_MAC) internal class SecTrust
	{}

	[DotNetType("Foundation.NSUrlSessionAuthChallengeDisposition")]
	extern(DOTNET && HOST_MAC) internal enum NSUrlSessionAuthChallengeDisposition : long
	{
		UseCredential = 0l,
		PerformDefaultHandling,
		CancelAuthenticationChallenge,
		RejectProtectionSpace
	}
}