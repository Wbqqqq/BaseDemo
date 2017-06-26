//
//  BQThirdShareView.h
//  YueLan
//
//  Created by wbq on 2017/6/10.
//  Copyright © 2017年 汪炳权. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BQThirdShareView : UIView

+(void)showWithTitle:(NSString *)title andText:(NSString *)text andImageUrl:(NSString *)thumimageUrl andUrl:(NSString *)url;

+(void)shoWImage:(UIImage *)image;


@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *thumimageUrl;
@property (nonatomic, strong) NSString *webUrl;
@property (nonatomic, strong) UIImage  *shareImage;
@end
