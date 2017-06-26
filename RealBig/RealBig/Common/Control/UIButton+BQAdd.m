//
//  UIButton+BQAdd.m
//  最惠夺宝
//
//  Created by wbq on 16/12/23.
//  Copyright © 2016年 wbq. All rights reserved.
//

#import "UIButton+BQAdd.h"

@implementation UIButton (BQAdd)

- (void)bq_setImageWithURL:(NSURL *)url forState:(UIControlState)state
{
    if ([url.scheme isEqualToString:@"https"])
    {
        [self sd_setImageWithURL:url forState:state placeholderImage:nil options:SDWebImageAllowInvalidSSLCertificates];
    }else
    {
        [self sd_setImageWithURL:url forState:state placeholderImage:nil];
    }
}

- (void)bq_setImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder
{
    if ([url.scheme isEqualToString:@"https"])
    {
        [self sd_setImageWithURL:url forState:state placeholderImage:placeholder options:SDWebImageAllowInvalidSSLCertificates];
    }else
    {
        [self sd_setImageWithURL:url forState:state placeholderImage:placeholder];
    }


}



@end
