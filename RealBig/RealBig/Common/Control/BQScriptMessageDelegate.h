//
//  BQScriptMessageDelegate.h
//  YueLan
//
//  Created by 汪炳权 on 2017/5/18.
//  Copyright © 2017年 汪炳权. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
@interface BQScriptMessageDelegate : NSObject<WKScriptMessageHandler>

@property (nonatomic, weak) id<WKScriptMessageHandler> scriptDelegate;

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate;

@end
