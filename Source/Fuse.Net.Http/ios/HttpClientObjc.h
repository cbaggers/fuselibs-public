#import <Foundation/Foundation.h>

@interface HttpClientObjc: NSObject <NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDataDelegate>

- (void)connect:(NSString *)url onCompleteHandler:(void (^)(NSString *))completeHandler;

@end