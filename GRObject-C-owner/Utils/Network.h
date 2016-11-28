#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef enum : NSUInteger {
    GET,
    POST,
    PUT,
    DELETE
} requestMethod;

@interface Network : NSObject

+ (instancetype)shareRequest;

- (void)cancelAllRequested;

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

- (void)uploadVoice:(NSString *)file
           withPath:(NSString *)path
         withParams:(NSDictionary*)params
           andBlock:(void (^)(id data, NSError *error))block;


@end
