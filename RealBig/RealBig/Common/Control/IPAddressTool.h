//
//  IPAddressTool.h
//  最惠夺宝
//
//  Created by wbq on 16/11/3.
//  Copyright © 2016年 wbq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IPAddressTool : NSObject

+ (NSString *)getIPAddress:(BOOL)preferIPv4;

+ (BOOL)isValidatIP:(NSString *)ipAddress;

+ (NSDictionary *)getIPAddresses;

@end
