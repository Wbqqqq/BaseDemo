//
//  BQLabel.h
//  一元夺宝
//
//  Created by wbq on 16/8/19.
//  Copyright © 2016年 wbq. All rights reserved.
//

#import <YYKit/YYKit.h>

@interface BQLabel : YYLabel


- (void)setFontColor:(UIColor *)color range:(NSRange)range;
- (void)setFontColor:(UIColor *)color string:(NSString *)string;

- (void)setFont:(UIFont *)font range:(NSRange)range;
- (void)setFont:(UIFont *)font string:(NSString *)string;


@end
