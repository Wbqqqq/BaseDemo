//
//  BQWebViewController.h
//  YueLan
//
//  Created by 汪炳权 on 2017/6/5.
//  Copyright © 2017年 汪炳权. All rights reserved.
//

#import "BaseViewController.h"

typedef enum : NSUInteger {
    Normal,
    FeedBack,
} WebVcType;

@interface BQWebViewController : BaseViewController

@property(nonatomic,assign)WebVcType type;


- (instancetype)initWithUrl:(NSString *)url;

@end
