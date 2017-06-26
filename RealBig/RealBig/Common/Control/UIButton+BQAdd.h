//
//  UIButton+BQAdd.h
//  最惠夺宝
//
//  Created by wbq on 16/12/23.
//  Copyright © 2016年 wbq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+WebCache.h"
@interface UIButton (BQAdd)


- (void)bq_setImageWithURL:(NSURL *)url forState:(UIControlState)state;

- (void)bq_setImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder;

@end
