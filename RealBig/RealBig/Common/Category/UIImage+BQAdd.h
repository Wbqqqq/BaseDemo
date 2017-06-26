//
//  UIImage+BQAdd.h
//  YueLan
//
//  Created by 汪炳权 on 2017/6/20.
//  Copyright © 2017年 汪炳权. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (BQAdd)

+(UIImage *)takeSnapshot:(UIView *)view scope:(CGRect)scope;


+(UIImage *)takeSnapshot:(UIView *)view;

@end
