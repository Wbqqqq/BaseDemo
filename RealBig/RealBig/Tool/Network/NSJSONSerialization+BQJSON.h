//
//  NSJSONSerialization+WBQJSON.h
//  WBQHttpClient
//
//  Created by lichangwen on 15/12/29.
//  Copyright © 2015年 汪炳权. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSJSONSerialization (BQJSON)
+ (nullable NSString *)stringWithJSONObject:(nonnull id)JSONObject;
+ (nullable id)objectWithJSONString:(nonnull NSString *)JSONString;
+ (nullable id)objectWithJSONData:(nonnull NSData *)JSONData;
@end
