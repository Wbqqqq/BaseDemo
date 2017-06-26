//
//  UIImageView+BQAdd.m
//  最惠夺宝
//
//  Created by wbq on 16/12/23.
//  Copyright © 2016年 wbq. All rights reserved.
//

#import "UIImageView+BQAdd.h"

@implementation UIImageView (BQAdd)
//http://cdn.dknb.nbtv.cn/attachment/app-image/1704/100955592cf744c6979999cab46f00232eb9f5b4.gif

- (void)bq_setImageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholder
{
    if ([[NSURL URLWithString:url].scheme isEqualToString:@"https"])
    {
        @weakify(self);
        [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder options:SDWebImageAllowInvalidSSLCertificates completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            @strongify(self);
            if(image == nil && cacheType == SDImageCacheTypeNone)
            {
                [UIView animateWithDuration:0.35 delay:0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                    self.image = image;
                } completion:nil];
                
            }
        }];
    }else
    {
        @weakify(self);
        [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder options:SDWebImageRetryFailed];
    }
}


-(void)bq_setImageWithURL:(NSString *)url
{
    if ([[NSURL URLWithString:url].scheme isEqualToString:@"https"])
    {
        @weakify(self);
        [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil options:SDWebImageAllowInvalidSSLCertificates completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            @strongify(self);
            if(image == nil && cacheType == SDImageCacheTypeNone)
            {
                [UIView animateWithDuration:0.35 delay:0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                        self.image = image;
                } completion:nil];
            
            }
        }];
    }else
    {
        [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil options:SDWebImageRetryFailed];
    }
}



@end
