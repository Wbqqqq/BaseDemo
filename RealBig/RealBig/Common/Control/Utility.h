//
//  Utility.h
//  一元夺宝
//
//  Created by wbq on 16/8/4.
//  Copyright © 2016年 wbq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NSDate+MJ.h"
#import "IPAddressTool.h"
// 电话号码运营商类型
typedef NS_ENUM(NSUInteger, PhoneNumberType) {
    HomeType,
    ChinaMobile = 10,
    ChinaUnicom,
    ChinaTelecom,
    phoneTrue
};

@interface Utility : NSObject


/**
 获取机型
 */
+(NSString *)deviceVersion;

/**
 获取设备id
 */
+(NSString *)getDeviceId;


/**
 设置购物车角标
 @param number 角标
 */
+(void)setShopCartNum:(NSInteger)number;


/**
 *  电话是否可用
 */
+ (BOOL)isPhoneNumberValid:(NSString *)phoneNumber;


/**
 *  电话是否可用
 */
+ (BOOL)checkEmail:(NSString *)email;
/**
 *  对象转json字符串
 */
+ (NSString *)dataToJsonString:(id)object;

/**
 *  json字符串转字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

/**
 *  获取当前的控制器
 */
+(UIViewController * )getCurrentVC;


/**
 *  获取当前的时间
 */
+(NSString *)currentTime;

/**
 *  请求头
 */
+(NSDictionary *)getHttpHead;


/**
 *  时间戳转化
 */
+ (NSString *)dateToTimeString:(NSString*)dateStr;




@end
