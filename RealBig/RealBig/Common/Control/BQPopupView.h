//
//  BQPopupView.h
//  YueLan
//
//  Created by 汪炳权 on 2017/5/24.
//  Copyright © 2017年 汪炳权. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MMPopupView/MMAlertView.h>
#import <MMPopupView/MMSheetView.h>
typedef void(^BQPopupItemHandler)(NSInteger index);
@interface BQPopupView : NSObject


/**
 ActionSheet

 @param title titel
 @param cancelButtonTitle 退出按键
 @param otherButtonTitles 其他按键
 @param block block
 */
+(void)showActionSheetWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle  otherButtonTitles:(NSArray *)otherButtonTitles withBlock:(BQPopupItemHandler)block;



/**
 Alert

 @param title titel
 @param detail message
 @param otherButtonTitles 其他按键
 @param block block
 */
+(void)showAlertWithTitle:(NSString *)title detail:(NSString *)detail otherButtonTitles:(NSArray *)otherButtonTitles withBlock:(BQPopupItemHandler)block;


@end
