#import <Foundation/Foundation.h>
#import "AFNetworking.h"

FOUNDATION_EXPORT NSString * const NetWorkDidChangeNotification;

typedef enum : NSUInteger {
    GET,
    POST,
    PUT,
    DELETE
} requestMethod;

@interface Network : NSObject

+ (instancetype)shareRequest;

//// 程序启动要开启网络状态监听
- (void)startMonitor;
- (void)stopMonitor;
- (BOOL)isHaveNetwork;//当前是否有网络

//取消结束之前的所有请求
- (void)cancelAllRequested;

//取消当前单个请求
- (void)cancelSingleRequest:(BOOL)isCancel;

- (void)requsetDataWithPath:(NSString *)path
                 params:(NSDictionary *)params
                 method:(requestMethod)mothod
            handleBlcok:(void (^)(id response, NSError *error))block;


- (void)uploadImage:(UIImage *)image
                       path:(NSString *)path
                   filename:(NSString *)filename
                       name:(NSString *)name
                     params:(NSDictionary *)params
                   progress:(void (^)(CGFloat progressValue))progress
                    success:(void (^)(id response))success
            failure:(void (^)(NSError *error))failure;
/*
- (void)uploadVoice:(NSString *)file
           withPath:(NSString *)path
         withParams:(NSDictionary*)params
           andBlock:(void (^)(id data, NSError *error))block;
 */


@end
