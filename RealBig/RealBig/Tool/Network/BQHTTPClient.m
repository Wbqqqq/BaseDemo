//
//  BQHTTPClient.m
//  BQHttpClient
//
//  Created by lichangwen on 15/12/28.
//  Copyright © 2015年 汪炳权. All rights reserved.
//

#import "BQHTTPClient.h"
#import "NSJSONSerialization+BQJSON.h"

static NSString * const BQHTTPClientURLString = @"";
NSString * const BQHTTPClientRequestCache = @"BQHTTPClientRequestCache";
static NSTimeInterval const BQHTTPClientTimeoutInterval = 30;
typedef NS_ENUM(NSUInteger, BQHTTPClientRequestType) {
    BQHTTPClientRequestTypeGET = 0,
    BQHTTPClientRequestTypePOST,
    BQHTTPClientRequestTypePUT,
};

@implementation BQHTTPClient
static YYCache *_dataCache;

#pragma mark - public

+ (void)initialize {
    _dataCache = [YYCache cacheWithName:BQHTTPClientRequestCache];
    _dataCache.memoryCache.shouldRemoveAllObjectsOnMemoryWarning = YES;
    _dataCache.memoryCache.shouldRemoveAllObjectsWhenEnteringBackground = YES;
   
}


//优先使用缓存
+ (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    return [self requestMethod:BQHTTPClientRequestTypeGET urlString:URLString parameters:parameters timeoutInterval:BQHTTPClientTimeoutInterval cachePolicy:BQHTTPClientReturnCacheDataThenLoad cache:nil success:success failure:failure];
}
+ (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
              timeoutInterval:(NSTimeInterval)timeoutInterval
                  cachePolicy:(BQHTTPClientRequestCachePolicy)cachePolicy
                        cache:(void (^)(id responseObject))cache
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    return [self requestMethod:BQHTTPClientRequestTypeGET urlString:URLString parameters:parameters timeoutInterval:timeoutInterval cachePolicy:cachePolicy cache:cache success:success failure:failure];
}
//优先使用缓存
+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    return [self requestMethod:BQHTTPClientRequestTypePOST urlString:URLString parameters:parameters timeoutInterval:BQHTTPClientTimeoutInterval cachePolicy:BQHTTPClientReloadIgnoringLocalCacheData cache:nil success:success failure:failure];
}
+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                   parameters:(id)parameters
              timeoutInterval:(NSTimeInterval)timeoutInterval
                  cachePolicy:(BQHTTPClientRequestCachePolicy)cachePolicy
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    return [self requestMethod:BQHTTPClientRequestTypePOST urlString:URLString parameters:parameters timeoutInterval:timeoutInterval cachePolicy:cachePolicy cache:nil success:success failure:failure];
}

+ (NSURLSessionDataTask *)PUT:(NSString *)URLString
                    parameters:(id)parameters
               timeoutInterval:(NSTimeInterval)timeoutInterval
                   cachePolicy:(BQHTTPClientRequestCachePolicy)cachePolicy
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    return [self requestMethod:BQHTTPClientRequestTypePUT urlString:URLString parameters:parameters timeoutInterval:timeoutInterval cachePolicy:cachePolicy cache:nil success:success failure:failure];
}





#pragma mark - private
+ (NSURLSessionDataTask *)requestMethod:(BQHTTPClientRequestType)type
                              urlString:(NSString *)URLString
                             parameters:(id)parameters
                        timeoutInterval:(NSTimeInterval)timeoutInterval
                            cachePolicy:(BQHTTPClientRequestCachePolicy)cachePolicy
                                  cache:(void (^)(id responseObject))cache
                                success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    URLString = URLString.length?URLString:@"";
    NSString *cacheKey = URLString;
    
    //***** 打印请求参数 ***********
#if DEBUG
    
    NSMutableString * logUrl = [NSMutableString stringWithString: [[NSURL URLWithString:URLString relativeToURL:[NSURL URLWithString:BQHTTPClientURLString]] absoluteString]];
    if([parameters isKindOfClass:[NSDictionary class]])
    {
        if(type == BQHTTPClientRequestTypeGET)
        {
            [logUrl appendFormat:@"?"];
            
            [parameters enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                
                NSMutableDictionary *tempdic = (NSMutableDictionary * )parameters;
                if([key isEqualToString:tempdic.allKeys.lastObject])
                {
                    [logUrl appendFormat:@"%@=%@",[self stringByURLDecode:key], [self stringByURLDecode:obj]];
                }else
                {
                    [logUrl appendFormat:@"%@=%@&", [self stringByURLDecode:key], [self stringByURLDecode:obj]];
                }
            }];
        }
        else
        {
            [logUrl appendFormat:@" -d "];
            [parameters enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                
                NSMutableDictionary *tempdic = (NSMutableDictionary * )parameters;
                if([key isEqualToString:tempdic.allKeys.lastObject])
                {
                    [logUrl appendFormat:@"%@=%@",[self stringByURLDecode:key], [self stringByURLDecode:obj]];
                }else
                {
                    [logUrl appendFormat:@"%@=%@&", [self stringByURLDecode:key], [self stringByURLDecode:obj]];
                }
            }];
        }
    }else
    {
        NSLog(@"参数为:%@",parameters);
    }
    
    NSLog(@"%@",[NSString stringWithFormat:@"请求地址为:%@",logUrl]);
    
 #endif
    //***********************
    if (parameters) {
        if (![NSJSONSerialization isValidJSONObject:parameters]) return nil;//参数不是json类型
        NSData *data = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
        NSString *paramStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        cacheKey = [cacheKey stringByAppendingString:paramStr];
    }
    
   
    id object = [_dataCache objectForKey:cacheKey];
    
    
    switch (cachePolicy) {
        case BQHTTPClientReturnCacheDataThenLoad: {//先返回缓存，同时请求
            if (object) {
                NSLog(@"缓存结果:%@",object);
                cache(object);
            }
            break;
        }
        case BQHTTPClientReloadIgnoringLocalCacheData: {//忽略本地缓存直接请求
            //不做处理，直接请求
            break;
        }
       
        case BQHTTPClientReturnCacheDataElseLoad: {//有缓存就返回缓存，没有就请求
            if (object) {//有缓存
                NSLog(@"缓存结果:%@",object);
                cache(object);
                return nil;
            }
            break;
        }
        case BQHTTPClientReturnCacheDataDontLoad: {//有缓存就返回缓存,从不请求（用于没有网络）
            if (object) {//有缓存
                cache(object);
            }
            return nil;//退出从不请求
        }
        default: {
            break;
        }
    }
    return [self requestMethod:type urlString:URLString parameters:parameters timeoutInterval:timeoutInterval cache:_dataCache cachePolicy:cachePolicy cacheKey:cacheKey success:success failure:failure];
    
}

+ (NSURLSessionDataTask *)requestMethod:(BQHTTPClientRequestType)type
                              urlString:(NSString *)URLString
                             parameters:(id)parameters
                        timeoutInterval:(NSTimeInterval)timeoutInterval
                                  cache:(YYCache *)cache
                            cachePolicy:(BQHTTPClientRequestCachePolicy)cachePolicy
                               cacheKey:(NSString *)cacheKey
                                success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    
    YYReachability *reach = [YYReachability reachability];
    YYReachabilityStatus reachStatus = reach.status;
    if(!reachStatus || reachStatus == YYReachabilityStatusNone)
    {
//        [BQProgressHUD showError:kServiceErrorMessage];
        failure(nil,nil);
        return nil;
    }
    
    
    BQHTTPClient *manager = [BQHTTPClient sharedClient];
    /*
     ************* 设置请求头,不要删掉就可以 *************
     */
    if([Utility getHttpHead].allKeys.count){
    
        [[Utility getHttpHead] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [manager.requestSerializer setValue:obj forHTTPHeaderField:key];
        }];
        [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    }else{
    
        [manager.requestSerializer clearAuthorizationHeader];
        [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    }
    
    /********************/
 
    
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = timeoutInterval;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript",@"text/plain", nil];
    AFSecurityPolicy * policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    policy.allowInvalidCertificates = YES;
    policy.validatesDomainName = NO;
    manager.securityPolicy = policy;
    switch (type) {
        case BQHTTPClientRequestTypeGET:{
            
            return [manager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) { } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([responseObject isKindOfClass:[NSData class]]) {
                    responseObject = [NSJSONSerialization stringWithJSONObject:responseObject];
                }
                [cache setObject:responseObject forKey:cacheKey];//YYCache 已经做了responseObject为空处理
                NSLog(@"网络请求结果:%@",responseObject);
            
                success(task,responseObject);
               
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failure(task, error);
                NSLog(@"%@",error);
                [BQHTTPClient dealWithError:error];

            }];
            
            
            break;
        }
        case BQHTTPClientRequestTypePOST:{
          
            return [manager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) { } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                if ([responseObject isKindOfClass:[NSData class]]) {
                    responseObject = [NSJSONSerialization objectWithJSONData:responseObject];
                }
                [cache setObject:responseObject forKey:cacheKey];//YYCache 已经做了responseObject为空处理
                NSLog(@"网络请求结果:%@",responseObject);

                success(task,responseObject);
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failure(task, error);
                
//                [BQProgressHUD showError:kTimeOutMessage];
                NSLog(@"%@",error);
                [BQHTTPClient dealWithError:error];
            }];
            
            break;
        }
        case BQHTTPClientRequestTypePUT:{
            
            return [manager PUT:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                if ([responseObject isKindOfClass:[NSData class]]) {
                        responseObject = [NSJSONSerialization objectWithJSONData:responseObject];
                }
                [cache setObject:responseObject forKey:cacheKey];//YYCache 已经做了responseObject为空处理
                NSLog(@"网络请求结果:%@",responseObject);
                
                success(task,responseObject);
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                failure(task, error);
                NSLog(@"%@",error);
                [BQHTTPClient dealWithError:error];
            }];
        }
        default:
            break;
    }
    
}


+ (NSURLSessionDataTask *)DELET:(NSString *)URLString
                     parameters:(id)parameters
                timeoutInterval:(NSTimeInterval)timeoutInterval
                        success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                        failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    BQHTTPClient *manager = [BQHTTPClient sharedClient];
    /*
     ************* 设置请求头,不要删掉就可以 *************
     */
    [[Utility getHttpHead] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [manager.requestSerializer setValue:obj forHTTPHeaderField:key];
    }];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    /********************/
    
    
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = timeoutInterval;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript",@"text/plain", nil];
    AFSecurityPolicy * policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    policy.allowInvalidCertificates = YES;
    policy.validatesDomainName = NO;
    manager.securityPolicy = policy;
    

    return [manager DELETE:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        
        success(task,responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
        failure(task, error);
        [BQHTTPClient dealWithError:error];
    }];



}



+ (NSURLSessionDataTask *)upLoad:(NSData *)fileDate filePath:(NSString *)filePath parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                        progress:(void(^)(float progress))progress
                           failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    BQHTTPClient *manager = [BQHTTPClient sharedClient];
    /*
     ************* 设置请求头,不要删掉就可以 *************
     */
    [[Utility getHttpHead] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [manager.requestSerializer setValue:obj forHTTPHeaderField:key];
    }];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    /********************/
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 30;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript",@"text/plain", nil];
    
  
    return [manager POST:filePath parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        if(fileDate)
        {
              [formData appendPartWithFileData:fileDate name:@"avator" fileName:@"file1.png" mimeType:@"image/png"];
        }
        
      
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"%f",1.0*uploadProgress.completedUnitCount/uploadProgress.totalUnitCount);
        progress(1.0*uploadProgress.completedUnitCount/uploadProgress.totalUnitCount);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);

        success(task,responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
        failure(task, error);
        [BQHTTPClient dealWithError:error];
    }];



}



+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                parameterArray:(NSArray *)array
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    manager.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithObjects:@"GET", @"HEAD",@"DELETE", nil];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 30;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript",@"text/plain", nil];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:array options:NSUTF8StringEncoding error:nil];
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:URLString]];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:bodyData];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    if(USER_TOKEN)
    {
        NSString *token = [NSString stringWithFormat:@"Bearer %@",USER_TOKEN];
        [dic setObject:token forKey:@"authorization"];
    }
    [dic setObject:@"application/json" forKey:@"content-type"];
    [dic setObject:@"no-cache" forKey:@"cache-control"];
    
    [req setAllHTTPHeaderFields:dic];
    
    [[manager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error) {
            
            NSLog(@"%@",responseObject);
            NSLog(@"上传数组成功");
            success(nil,responseObject);

        } else {
            
            NSLog(@"%@",error);
            failure(nil,error);
            [BQHTTPClient dealWithError:error];
        }

    }] resume];

    
    return nil;

}

+ (NSURLSessionDataTask *)PUT:(NSString *)URLString
                parameterArray:(NSArray *)array
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    manager.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithObjects:@"GET", @"HEAD",@"DELETE", nil];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 30;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript",@"text/plain", nil];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:array options:NSUTF8StringEncoding error:nil];
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:URLString]];
    [req setHTTPMethod:@"PUT"];
    [req setHTTPBody:bodyData];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    if(USER_TOKEN)
    {
        NSString *token = [NSString stringWithFormat:@"Bearer %@",USER_TOKEN];
        [dic setObject:token forKey:@"authorization"];
    }
    [dic setObject:@"application/json" forKey:@"content-type"];
    [dic setObject:@"no-cache" forKey:@"cache-control"];
    
    [req setAllHTTPHeaderFields:dic];
    
    [[manager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error) {
            
            NSLog(@"%@",responseObject);
            NSLog(@"上传数组成功");
            success(nil,responseObject);
            
        } else {
            
            NSLog(@"%@",error);
            failure(nil,error);
            [BQHTTPClient dealWithError:error];
        }
        
    }] resume];
    
    
    return nil;
    
}



/// URLString 应该是全url 上传单个文件
+ (NSURLSessionUploadTask *)upload:(NSString *)URLString filePath:(NSString *)filePath parameters:(id)parameters{
    NSURL *URL = [NSURL URLWithString:URLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
    NSURLSessionUploadTask *uploadTask = [[BQHTTPClient client] uploadTaskWithRequest:request fromFile:fileUrl progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"Success: %@ %@", response, responseObject);
        }
    }];
    [uploadTask resume];
    return uploadTask;
}
+ (instancetype)sharedClient{
    static BQHTTPClient *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [BQHTTPClient client];
        
    });
    return sharedClient;
}
+ (instancetype)client{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
   return [[BQHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:BQHTTPClientURLString] sessionConfiguration:configuration];
    
}

+ (NSString *)stringByURLDecode:(NSString *)urlStr {
    
    if(![urlStr isKindOfClass:[NSString  class]])
    {
        return @"";
    }

    if ([self respondsToSelector:@selector(stringByRemovingPercentEncoding)]) {
        return [urlStr stringByRemovingPercentEncoding];
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        CFStringEncoding en = CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding);
        NSString *decoded = [urlStr stringByReplacingOccurrencesOfString:@"+"
                                                            withString:@" "];
        decoded = (__bridge_transfer NSString *)
        CFURLCreateStringByReplacingPercentEscapesUsingEncoding(
                                                                NULL,
                                                                (__bridge CFStringRef)decoded,
                                                                CFSTR(""),
                                                                en);
        return decoded;
#pragma clang diagnostic pop
    }
}



#pragma mark - 清空缓存
+(void)clearCache
{
    [[[YYCache alloc] initWithName:BQHTTPClientRequestCache] removeAllObjectsWithProgressBlock:nil endBlock:^(BOOL error) {
        if (!error) {
            NSLog(@"清除成功");
        }
    }];

}

+ (void)netWorkMonitoring
{
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态发生改变的时候调用这个block
        YYReachability *reach = [YYReachability reachability];
        [ModelLocator sharedInstance].reachabilityStatus = reach.status;
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WIFI状态");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                YYReachability *reach = [YYReachability reachability];
                YYReachabilityWWANStatus wwanStatus = reach.wwanStatus;
                [ModelLocator sharedInstance].reachabilityWWANStatus = wwanStatus;
                switch (wwanStatus) {
                    case YYReachabilityWWANStatusNone:
                    {
                        NSLog(@"蜂窝网络");
                        
                        break;
                    }
                    case YYReachabilityWWANStatus2G:
                    {
                        NSLog(@"2G");
                        break;
                    }
                    case YYReachabilityWWANStatus3G:
                    {
                        NSLog(@"3G");
                        break;
                    }
                    case YYReachabilityWWANStatus4G:
                    {
                        NSLog(@"4G");
                        break;
                    }
                    default:
                        break;
                }
                
                break;
            }
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"没有网络");
                [BQProgressHUD showError:@"您当前未连接wifi"];
                break;
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络");
                break;
            default:
                break;
        }
    }];
    // 开始监控
    [mgr startMonitoring];
}


+(void)dealWithError:(NSError *)error
{
    if(error.code == 401)
    {
        BaseViewController * vc = [[BaseViewController alloc]init];
        [vc Logout];
        [BQPopupView showAlertWithTitle:@"登录信息过期" detail:@"请重新登录" otherButtonTitles:@[@"是",@"否"] withBlock:^(NSInteger index) {
            if(index == 0){
                
//                YLLoginViewController * vc = [[YLLoginViewController alloc]init];
//                BaseNavigationViewController * nav = [[BaseNavigationViewController alloc]initWithRootViewController:vc];
//                [YL_AppDelegate.window.rootViewController presentViewController:nav animated:YES completion:nil];
            
            }
        }];
    }
   

}



@end
