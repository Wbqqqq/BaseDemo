//
//  NSJSONSerialization+WBQJSON.m
//  WBQHttpClient
//
//  Created by lichangwen on 15/12/29.
//  Copyright © 2015年 汪炳权. All rights reserved.
//

#import "NSJSONSerialization+BQJSON.h"

@implementation NSJSONSerialization (BQJSON)
+ (nullable NSString *)stringWithJSONObject:(nonnull id)JSONObject
{
    if (![NSJSONSerialization isValidJSONObject:JSONObject]){
        NSLog(@"The JSONObject is not JSON Object");
        return nil;
    }
    NSData *data = [NSJSONSerialization dataWithJSONObject:JSONObject options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
}
+ (nullable id)objectWithJSONString:(nonnull NSString *)JSONString
{
    NSData *data = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    return [self objectWithJSONData:data options:NSJSONReadingMutableContainers];
}
+ (nullable id)objectWithJSONData:(nonnull NSData *)JSONData
{
    return [self objectWithJSONData:JSONData options:NSJSONReadingMutableContainers];
}
+ (nullable id)objectWithJSONData:(nonnull NSData *)JSONData options:(NSJSONReadingOptions)option
{
    NSError *error;
    id JSONObject = [NSJSONSerialization JSONObjectWithData:JSONData options:option error:&error];
    
    return JSONObject;
}
@end
