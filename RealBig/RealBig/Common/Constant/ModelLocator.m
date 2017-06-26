//
//  ModelLocator.m
//  spjk
//
//  Created by 汪炳权 on 14-8-20.
//  Copyright (c) 2014年 汪炳权. All rights reserved.
//

#import "ModelLocator.h"

@implementation ModelLocator

static ModelLocator *sharedInstance = nil;

+ (ModelLocator*)sharedInstance {
    //这种写法更好
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[super allocWithZone:NULL] init];
            
    });
    return sharedInstance;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (id)init {
    if (self = [super init]) {
        
    }
    return self;
}





@end
