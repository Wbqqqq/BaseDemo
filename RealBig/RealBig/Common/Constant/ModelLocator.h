//
//  ModelLocator.h
//  spjk
//
//  Created by 汪炳权 on 14-8-20.
//  Copyright (c) 2014年 汪炳权. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYKit/YYKit.h>
@interface ModelLocator : NSObject

@property(nonatomic,strong) NSString *userID;
@property(nonatomic,strong) NSString *userName;
@property(nonatomic,strong) NSString *yglb;
@property(nonatomic,strong) NSString *uuid;
@property(nonatomic,assign) BOOL forcedUpdate; //是否强制更新
@property(nonatomic,strong) NSString *token;
@property(nonatomic,assign) BOOL isLogin;  //是否为登陆状态
@property(nonatomic,strong) NSString *step;


@property(nonatomic,assign) YYReachabilityStatus   reachabilityStatus;
@property(nonatomic,assign) YYReachabilityWWANStatus  reachabilityWWANStatus;

+ (ModelLocator*)sharedInstance;

@end
