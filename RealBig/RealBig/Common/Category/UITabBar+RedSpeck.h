//
//  UITabBar+RedSpeck.h
//  jianyue
//
//  Created by admin on 2017/4/27.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (RedSpeck)
- (void)showBadgeOnItmIndex:(int)index tabbarNum:(int)tabbarNum;
- (void)hideBadgeOnItemIndex:(int)index;
@end
