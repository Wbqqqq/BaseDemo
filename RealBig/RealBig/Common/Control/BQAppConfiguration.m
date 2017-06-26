//
//  BQAppConfiguration.m
//  Ty
//
//  Created by wbq on 17/4/7.
//  Copyright © 2017年 汪炳权. All rights reserved.
//

#import "BQAppConfiguration.h"
#import "YYFPSLabel.h"
//#import "BaiduMobStat.h"
//#import <ShareSDK/ShareSDK.h>
//#import <ShareSDKConnector/ShareSDKConnector.h>
#import "WXApi.h"
#import "WeiboSDK.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "UMMobClick/MobClick.h"
#import <Bugly/Bugly.h>

@implementation BQAppConfiguration

+(void)configureWithOption:(NSDictionary *)launchingOption
{
    /********************************************************************/
//    
//    if(USER_TOKEN)
//    {
//        //设置登陆状态
//        [ModelLocator sharedInstance].isLogin = YES;
//    }
    
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
    
    [MMPopupWindow sharedWindow].touchWildToHide = YES;
    [MMAlertViewConfig globalConfig].defaultTextOK = @"确认";
    
    
    //提交上次残留下来的用户行为
//    [[YLActRecordTool sharedTool] upLoadTheLastBehaviorLogTasks];
    
  
    //检查app的更新情况
//    [BQAppConfiguration checkForAppUpdate];
    
    //网页的UserAgent修改
//    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
//    NSString *oldAgent = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
//    NSString *newAgent = [oldAgent stringByAppendingString:@" dknbios"];
//    NSDictionary *dictionnary = [[NSDictionary alloc] initWithObjectsAndKeys:newAgent, @"UserAgent", nil,nil];
//    [USER_DEFAULT registerDefaults:dictionnary];
//    /********************************************************************/
//    
//    /********************************************************************/
//    //百度统计
//    BaiduMobStat* statTracker = [BaiduMobStat defaultStat];
//    // 此处(startWithAppId之前)可以设置初始化的可选参数，具体有哪些参数，可详见BaiduMobStat.h文件，例如：
//    statTracker.shortAppVersion  = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
//    statTracker.enableDebugOn = YES;
//    [statTracker startWithAppId:BAIDUKEY];
//    /********************************************************************/
//    
//    /********************************************************************/
//    //极光推送
//    [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
//                                                      UIUserNotificationTypeSound |
//                                                      UIUserNotificationTypeAlert)
//                                          categories:nil];
//    [JPUSHService setupWithOption:launchingOption appKey:JPUSHKEY
//                          channel:JPUSHCHANNEL apsForProduction:JPUSHISPRODUCTION];
//    /********************************************************************/
//
//    /********************************************************************/
   
    
    /* 打开调试日志 */
//    [[UMSocialManager defaultManager] openLog:YES];
//    
//    /* 设置友盟appkey */
//    [[UMSocialManager defaultManager] setUmSocialAppkey:UMSocialAppKey];
//
//
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WeChatAppID appSecret:WeChatAppSecret redirectURL:@"http://mobile.umeng.com/social"];
//  
//    /* 设置分享到QQ互联的appID
//     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
//     */
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQAppID/*设置QQ平台的appID*/  appSecret:QQAppSecret redirectURL:@"http://mobile.umeng.com/social"];
//    /* 设置新浪的appKey和appSecret */
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:SinaAPPID  appSecret:SinaAppSecret redirectURL:@"http://www.baidu.com"];
//    
//    
//    [MobClick setLogEnabled:YES];
//    UMConfigInstance.appKey = UMSocialAppKey;
//    UMConfigInstance.channelId = @"App Store";
//    [MobClick startWithConfigure:UMConfigInstance];
//    [MobClick setAppVersion:[UIApplication sharedApplication].appVersion];
//    
//    //Bugly
//    [Bugly startWithAppId:BuglyAPPID];
    
    
#if defined(DEBUG) || defined(_DEBUG)
    [YYFPSLabel show];
#endif
    
    
     /********************************************************************/
   
}







@end
