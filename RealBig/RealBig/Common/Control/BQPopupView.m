//
//  BQPopupView.m
//  YueLan
//
//  Created by 汪炳权 on 2017/5/24.
//  Copyright © 2017年 汪炳权. All rights reserved.
//

#import "BQPopupView.h"

@implementation BQPopupView

+(void)showActionSheetWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle  otherButtonTitles:(NSArray *)otherButtonTitles withBlock:(BQPopupItemHandler)block
{
    [MMPopupWindow sharedWindow].touchWildToHide = YES;
    MMPopupItemHandler handler = ^(NSInteger index){
        
        if(block) block(index);
        
    };
  
    NSMutableArray * items = [NSMutableArray new];
    for (NSString * title in otherButtonTitles) {
        [items addObject:MMItemMake(title, MMItemTypeNormal, handler)];
    }
    
    MMSheetView *sheetView = [[MMSheetView alloc] initWithTitle:title items:items];
    sheetView.attachedView.mm_dimBackgroundBlurEffectStyle = UIBlurEffectStyleDark;
    sheetView.attachedView.mm_dimBackgroundBlurEnabled = NO;
    sheetView.type = MMPopupTypeSheet;
    [sheetView show];

}


+(void)showAlertWithTitle:(NSString *)title detail:(NSString *)detail otherButtonTitles:(NSArray *)otherButtonTitles withBlock:(BQPopupItemHandler)block
{
    
    [MMPopupWindow sharedWindow].touchWildToHide = NO;
    MMPopupItemHandler handler = ^(NSInteger index){
        
        if(block) block(index);
        
    };
    
    NSMutableArray * items = [NSMutableArray new];
    for (NSString * title in otherButtonTitles) {
        [items addObject:MMItemMake(title, MMItemTypeNormal, handler)];
    }
    
    
    MMAlertView *alertView = [[MMAlertView alloc] initWithTitle:title detail:detail items:items];
    
    alertView.attachedView.mm_dimBackgroundBlurEffectStyle = UIBlurEffectStyleDark;
    alertView.type = MMPopupTypeAlert;
    [alertView show];
    
}


@end
