//
//  YPProgressHUD.h
//  Wuxianda
//
//  Created by wbq on 16/5/21.
//  Copyright © 2016年 michaelhuyp. All rights reserved.
//  HUD工具类

#import <Foundation/Foundation.h>

@interface BQProgressHUD : NSObject

+ (void)show;

+ (void)showWithMessage:(NSString *)message;

+ (void)dismiss;

+ (void)showError:(NSString *)errorInfo;

+ (void)showSuccess:(NSString *)info;

+ (void)showProgress:(float)progress status:(NSString *)status;

+ (void)showInfo:(NSString *)info;

+ (void)setMaxSupportedWindowLevel:(UIWindowLevel)windowLevel;
@end
