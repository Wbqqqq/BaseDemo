//
//  UIImageView+BQAdd.h
//  最惠夺宝
//
//  Created by wbq on 16/12/23.
//  Copyright © 2016年 wbq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (BQAdd)

- (void)bq_setImageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholder;

- (void)bq_setImageWithURL:(NSString *)url;

@end
