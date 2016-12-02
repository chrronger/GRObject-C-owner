#import "Network.h"

#import "AFNetworkActivityIndicatorManager.h"

NSString *const NetWorkDidChangeNotification= @"NetWorkDidChangeNotification";

#define BASE_URL @""
#define TIMEOUT 60

@interface Network ()
@property(nonatomic,strong)AFHTTPSessionManager *manager;
@property(nonatomic,strong)NSURLSessionDataTask *task;

@end

@implementation Network

+ (instancetype)shareRequest
{
    static Network *_HWNetworkRequest = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _HWNetworkRequest = [[self alloc] init];
    });
    return _HWNetworkRequest;
}

- (instancetype)init {
    if (self = [super init]) {
        // 网络状态监听
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            if (status == AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi) {
                //NSLog(@"有网络");
                [[NSNotificationCenter defaultCenter] postNotificationName:NetWorkDidChangeNotification object:nil userInfo:@{@"status": [NSNumber numberWithBool:true]}];
            } else {
               // NSLog(@"无网络");
                [[NSNotificationCenter defaultCenter] postNotificationName:NetWorkDidChangeNotification object:nil userInfo:@{@"status": [NSNumber numberWithBool:false]}];
            }
        }];
    }
    return self;
}



- (void)startMonitor
{
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

- (void)stopMonitor
{
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}

- (BOOL)isHaveNetwork
{
    AFNetworkReachabilityStatus status = [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
    //
    if (status == AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi) {
        return true;
    }
    return false;
}

- (AFHTTPSessionManager *)manager
{
    if (_manager == nil) {
        if (BASE_URL) {
           _manager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:BASE_URL]];
        }
       // _manager.requestSerializer = [AFJSONRequestSerializer serializer];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html",@"text/xml", nil];
        
        [_manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
       // [_manager.requestSerializer setValue:BASE_URL.absoluteString forHTTPHeaderField:@"Referer"];
        //请求超时时间
        _manager.requestSerializer.timeoutInterval = TIMEOUT;
        _manager.securityPolicy.allowInvalidCertificates = YES;

    }
    return _manager;
}

- (void)cancelAllRequested
{
    //结束之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
}

//取消当前单个请求
- (void)cancelSingleRequest:(BOOL)isCancel
{
    if (isCancel) {
        [self.task cancel];
    }
}

- (void)requsetDataWithPath:(NSString *)path
                     params:(NSDictionary *)params
                     method:(requestMethod)mothod
                handleBlcok:(void (^)(id response, NSError *error))block
{
    if (![self validateString:path]) return;
    
    [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
    
    switch (mothod) {
        case GET:
        {
            [self.manager GET:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                self.task = task;
                if (block) {
                    block(responseObject, nil)  ;
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (block) {
                    //请求错误，可以在这里设置HUD提示，或者在使用的地方设置提示
                    block(nil, error);
                }
            }];
        }
            break;
        case POST:
        {
            [self.manager POST:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                self.task = task;
                if (block) {
                    block(responseObject, nil);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                if (block) {
                    block(nil, error);
                }
            }];
        }
            break;
        case PUT:
        {
             [self.manager PUT:path parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                self.task = task;
                if (block) {
                    block(responseObject, nil);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (block) {
                    block(nil, error);
                }
            }];
        }
            break;
        case DELETE:
        {
             [self.manager DELETE:path parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                self.task = task;
                if (block) {
                    block(responseObject, nil);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (block) {
                    block(nil, error);
                }
            }];
        }
            break;
        default:
            break;
    }

}

- (void)uploadImage:(UIImage *)image
               path:(NSString *)path
           filename:(NSString *)filename
               name:(NSString *)name
             params:(NSDictionary *)params
           progress:(void (^)(CGFloat progressValue))progress
            success:(void (^)(id response))success
            failure:(void (^)(NSError *error))failure
{
    if (!image) return;
    NSURLSessionTask *sessionTask =
    [self.manager POST:path parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *imageData = UIImageJPEGRepresentation(image, 1);
        
        NSString *imageFileName = filename;
        if (filename == nil || ![filename isKindOfClass:[NSString class]] || filename.length == 0) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            imageFileName = [NSString stringWithFormat:@"%@.jpg", str];
        }
        
        // 上传图片，以文件流的格式
        [formData appendPartWithFileData:imageData name:name fileName:imageFileName mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress((CGFloat)uploadProgress.completedUnitCount / (CGFloat)uploadProgress.totalUnitCount);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
        }
    }];
    [sessionTask resume];

}


#pragma mark - 判断字符串是否为空  string分类
- (BOOL)validateString:(NSString *)str
{
    if(str.length ==  0 || [str isKindOfClass:[NSNull class]] || str == nil || str == NULL || [str isEqualToString:@"(null)"] || [[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0 || [str isEqualToString:@"null"])
    {
        return NO;
    }
    return YES;
}

@end
