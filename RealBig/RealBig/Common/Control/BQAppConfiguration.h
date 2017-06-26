//
//  BQAppConfiguration.h
//  Ty
//
//  Created by wbq on 17/4/7.
//  Copyright © 2017年 汪炳权. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BQAppConfiguration : NSObject

/**
 * 进行第三方配置
 */
+(void)configureWithOption:(NSDictionary *)launchingOption;

@end
