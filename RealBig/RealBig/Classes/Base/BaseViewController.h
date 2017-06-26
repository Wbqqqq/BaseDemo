//
//  BaseViewController.h
//  一元夺宝
//
//  Created by wbq on 16/8/15.
//  Copyright © 2016年 wbq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController


/**
 *  创建
 */
- (instancetype)initWithTitle:(NSString *)title;

/**
 *  是否登录
 *
 *  @return 没有登录返回NO
 */
- (BOOL)isLogin;


/**
 * 增加消失按钮
 */
-(void)addDissmissLeftBarItem;


/**
 *  退出登录
 */
-(void)Logout;






@end
