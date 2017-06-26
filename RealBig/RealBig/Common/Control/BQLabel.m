//
//  BQLabel.m
//  一元夺宝
//
//  Created by wbq on 16/8/19.
//  Copyright © 2016年 wbq. All rights reserved.
//

#import "BQLabel.h"

@implementation BQLabel

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        //YYLabel需要初始化
        self.attributedText =  [[NSAttributedString alloc]initWithString:@""];
    }
    return self;

}



- (void)setFontColor:(UIColor *)color string:(NSString *)string
{
    NSRange range = [self.text rangeOfString:string];
    
    [self setFontColor:color range:range];
}

- (void)setFontColor:(UIColor *)color range:(NSRange)range
{
    NSMutableAttributedString *attributed = [self attributedString];

    [attributed setColor:color range:range];
    
    self.attributedText = attributed;
}

- (void)setFont:(UIFont *)font range:(NSRange)range
{
    NSMutableAttributedString *attributed = [self attributedString];
    
    [attributed setFont:font range:range];
    
    self.attributedText = attributed;

}

- (void)setFont:(UIFont *)font string:(NSString *)string
{
    
    NSRange range = [self.text rangeOfString:string];
    
    [self setFont:font range:range];

}

- (NSMutableAttributedString *)attributedString
{
    return [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
}

@end
