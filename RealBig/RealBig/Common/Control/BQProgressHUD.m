//
//  YPProgressHUD.m
//  Wuxianda
//
//  Created by BQq on 16/5/21.
//  Copyright © 2016年 michaelhuyp. All rights reserved.
//

#import "BQProgressHUD.h"
#import "SVProgressHUD.h"

@implementation BQProgressHUD : NSObject

+(void)initialize
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setCornerRadius:8.0];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];
    [SVProgressHUD setBackgroundColor:[BQBlackColor colorWithAlphaComponent:0.5]];
    [SVProgressHUD setForegroundColor:BQWhiteColor];
    [SVProgressHUD setErrorImage:[UIImage imageNamed:@"BQProgressHUD.bundle/SVPError"]];
    [SVProgressHUD setSuccessImage:[UIImage imageNamed:@"BQProgressHUD.bundle/SVPSuccess"]];
}

+ (void)show
{
    [SVProgressHUD show];
}

+ (void)showWithMessage:(NSString *)message
{
    [SVProgressHUD showWithStatus:message];
}

+ (void)showInfo:(NSString *)info
{
    [SVProgressHUD setMinimumDismissTimeInterval:0.5f];
    [SVProgressHUD showInfoWithStatus:info];
}

+ (void)dismiss
{
    [SVProgressHUD dismiss];
}

+ (void)showError:(NSString *)errorInfo
{
    [SVProgressHUD setMinimumDismissTimeInterval:0.5f];
    [SVProgressHUD showErrorWithStatus:errorInfo];
}

+ (void)showSuccess:(NSString *)info
{
    [SVProgressHUD setMinimumDismissTimeInterval:0.5f];
    [SVProgressHUD showSuccessWithStatus:info];
}


+(void)showProgress:(float)progress status:(NSString *)status
{
    [SVProgressHUD showProgress:progress status:status];
}

+ (void)setMaxSupportedWindowLevel:(UIWindowLevel)windowLevel {
    
    [SVProgressHUD setMaxSupportedWindowLevel:windowLevel];
    
}

@end
