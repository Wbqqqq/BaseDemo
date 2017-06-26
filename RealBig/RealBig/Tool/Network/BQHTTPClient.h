//
//  BQHTTPClient.h
//  BQHttpClient
//
//  Created by lichangwen on 15/12/28.
//  Copyright © 2015年 汪炳权. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>


typedef NS_ENUM(NSUInteger, BQHTTPClientRequestCachePolicy){
    BQHTTPClientReturnCacheDataThenLoad = 0,///< 有缓存就先返回缓存，同步请求数据
    BQHTTPClientReloadIgnoringLocalCacheData, ///< 忽略缓存，重新请求
    BQHTTPClientReturnCacheDataElseLoad,///< 有缓存就用缓存，没有缓存就重新请求(用于数据不变时)
    BQHTTPClientReturnCacheDataDontLoad,///< 有缓存就用缓存，没有缓存就不发请求，当做请求出错处理（用于离线模式）
};

extern  NSString * const BQHTTPClientRequestCache;///< 缓存的name

@interface BQHTTPClient : AFHTTPSessionManager

//单例模式
+ (instancetype)sharedClient;

/// 默认 BQHTTPClientReturnCacheDataThenLoad 的缓存方式 默认超时时间30s 可以设置。
+ (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
/// 可以自由设置超时时间，缓存方式。
+ (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
              timeoutInterval:(NSTimeInterval)timeoutInterval
                  cachePolicy:(BQHTTPClientRequestCachePolicy)cachePolicy
                        cache:(void (^)(id responseObject))cache
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/// 默认 BQHTTPClientReturnCacheDataThenLoad 的缓存方式 默认超时时间30s 可以设置。
+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
/// 可以自由设置超时时间，缓存方式。
+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
               timeoutInterval:(NSTimeInterval)timeoutInterval
                   cachePolicy:(BQHTTPClientRequestCachePolicy)cachePolicy
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

+ (NSURLSessionDataTask *)PUT:(NSString *)URLString
                   parameters:(id)parameters
              timeoutInterval:(NSTimeInterval)timeoutInterval
                  cachePolicy:(BQHTTPClientRequestCachePolicy)cachePolicy
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

//上传
+ (NSURLSessionDataTask *)upLoad:(NSData *)fileDate filePath:(NSString *)filePath parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                        progress:(void(^)(float progress))progress
                         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

//删除
+ (NSURLSessionDataTask *)DELET:(NSString *)URLString
                     parameters:(id)parameters
                timeoutInterval:(NSTimeInterval)timeoutInterval
                        success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                        failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

//部分项目上传数组有问题，修改上传方式
+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                parameterArray:(NSArray *)array
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

//增加数组PUT上传方式
+ (NSURLSessionDataTask *)PUT:(NSString *)URLString
               parameterArray:(NSArray *)array
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

//处理错误
+ (void)dealWithError:(NSError *)error;


//开始监听网络
+ (void)netWorkMonitoring;


//清楚缓存
+(void)clearCache;

@end
