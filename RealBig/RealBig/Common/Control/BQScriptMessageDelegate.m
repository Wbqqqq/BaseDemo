//
//  BQScriptMessageDelegate.m
//  YueLan
//
//  Created by 汪炳权 on 2017/5/18.
//  Copyright © 2017年 汪炳权. All rights reserved.
//

#import "BQScriptMessageDelegate.h"

@implementation BQScriptMessageDelegate

-(void)dealloc
{
    NSLog(@"桥接释放");
}


- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate {
    self = [super init];
    if (self) {
        _scriptDelegate = scriptDelegate;
    }
    return self;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    [self.scriptDelegate userContentController:userContentController didReceiveScriptMessage:message];
}

@end
