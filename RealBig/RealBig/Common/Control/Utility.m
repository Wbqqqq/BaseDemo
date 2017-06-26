//
//  Utility.m
//  一元夺宝
//
//  Created by wbq on 16/8/4.
//  Copyright © 2016年 wbq. All rights reserved.
//

#import "Utility.h"
#import "sys/utsname.h"
#import <AdSupport/AdSupport.h>
#import "Base64.h"
#import "DesUtil.h"
@implementation Utility


+(NSDictionary *)getHttpHead
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    if(USER_TOKEN)
    {
        NSString *token = [NSString stringWithFormat:@"Bearer %@",USER_TOKEN];
        [dic setObject:token forKey:@"Authorization"];
    }
//    [dic setObject:@"application/json" forKey:@"content-type"];
//    [dic setObject:@"no-cache" forKey:@"cache-control"];

    return dic;
    
}


+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}




+ (NSString *)dataToJsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (!jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    }
    
    return jsonString;
}

+(void)setShopCartNum:(NSInteger)number
{
//   UIViewController * vc = [BaseTabBarController SharedTabBarController].viewControllers[3];
//   if(number == 0)
//   {
//      vc.tabBarItem.badgeValue = nil;
//   }
//   else
//   {
//      vc.tabBarItem.badgeValue = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%ld",(long)number]];
//   }
}


+ (NSString *)dateToTimeString:(NSString*)dateStr
{
    
    dateStr = [dateStr stringByReplacingOccurrencesOfString:@"T" withString:@" "];

    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate * created_at = [fmt dateFromString:dateStr];
    fmt.locale = [NSLocale localeWithLocaleIdentifier:@"en_us"];
    
    if ([created_at isThisYear]) { // 今年
        
        if ([created_at isToday]) { // 今天
            
            // 计算跟当前时间差距
            NSDateComponents *cmp = [created_at deltaWithNow];
            // 计算跟当前时间差距
            if (cmp.hour >= 1) {
                
                fmt.dateFormat = @"今天HH:mm";
                return  [fmt stringFromDate:created_at];
                
            }else if (cmp.minute > 1){
                return [NSString stringWithFormat:@"%ld分钟前 ",cmp.minute];
            }else{
                return @"刚刚";
            }
            
        }
        
        else if ([created_at isYesterday]){ // 昨天
            fmt.dateFormat = @"昨天HH:mm";
            return  [fmt stringFromDate:created_at];
            
        }else{ // 前天
            fmt.dateFormat = @"MM月dd日";
            return  [fmt stringFromDate:created_at];
        }
        
    }else{ // 不是今年
        
        fmt.dateFormat = @"yyyy年MM月dd日";
        
        return [fmt stringFromDate:created_at];
        
    }
    
    return dateStr;
}


/**
 *   获得现在的时间
 */
+ (NSString *)currentTime
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    //现在时间
    
    NSDate *datenow = [NSDate date];
    
    NSString *nowtimeStr = [formatter stringFromDate:datenow];
    
    return nowtimeStr;
}


/**
 *  检验手机号是否有效(国内)
 *
 *  @param phoneNumber 手机号码
 *
 *  @return 是否有效
 */
+ (BOOL)isPhoneNumberValid:(NSString *)phoneNumber
{
    NSString *preprocessedPhoneNumber = [phoneNumber stringByTrim];
    if ([preprocessedPhoneNumber hasPrefix:@"86"]) {
        preprocessedPhoneNumber = [preprocessedPhoneNumber substringFromIndex:2];
    }
    PhoneNumberType result = [self operatorType:preprocessedPhoneNumber];
    
    switch (result) {
        case phoneTrue:
        case ChinaMobile:
        case ChinaUnicom:
        case ChinaTelecom:
            return YES;
            break;
        default:
            return NO;
            break;
    }
    
    return NO;
}


/**
 *  获取电话号码运营商类型
 *
 *  @param phoneNumber 号码
 *
 *  @return 运营商类型
 */
+ (PhoneNumberType)operatorType:(NSString *)phoneNumber
{
    NSString * MOBILE = @"^1(3[0-9]|5[0-9]|8[0-9]|7[0-46-8])\\d{8}$";
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278]|70)\\d)\\d{7}$";
    NSString * CT = @"^1((33|53|8[019])[0-9]|349)\\d{7}$";
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    if ([regextestcu evaluateWithObject:phoneNumber]) {
        NSLog(@"联通的手机号");
        return ChinaUnicom;
    }
    
    if ([regextestcm evaluateWithObject:phoneNumber]) {
        NSLog(@"移动的手机号");
        return ChinaMobile;
    }
    
    if ([regextestct evaluateWithObject:phoneNumber]) {
        NSLog(@"电信的手机号");
        return ChinaTelecom;
    }
    
    if ([regextestphs evaluateWithObject:phoneNumber]) {
        NSLog(@"固定电话");
        return HomeType;
    }
    
    if ([regextestmobile evaluateWithObject:phoneNumber]) {
        NSLog(@"手机号码正确");
        return phoneTrue;
    }
    
    return NO;
}


+ (BOOL)checkEmail:(NSString *)email{
    
    //^(\\w)+(\\.\\w+)*@(\\w)+((\\.\\w{2,3}){1,3})$
    
    NSString *regex = @"^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [emailTest evaluateWithObject:email];
    
}


+(UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

+ (NSString *)getDeviceId
{
    NSString * currentDeviceUUIDStr = @"";
    NSUUID * currentDeviceUUID  = [UIDevice currentDevice].identifierForVendor;
    currentDeviceUUIDStr = currentDeviceUUID.UUIDString;
    currentDeviceUUIDStr = [currentDeviceUUIDStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
    currentDeviceUUIDStr = [currentDeviceUUIDStr lowercaseString];

    return currentDeviceUUIDStr;
}

+ (NSString*)deviceVersion
{
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    //CLog(@"%@",deviceString);
    
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    
    //CLog(@"NOTE: Unknown device type: %@", deviceString);
    
    return deviceString;
}

@end
