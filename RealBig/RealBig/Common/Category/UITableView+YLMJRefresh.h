//
//  UITableView+YLMJRefresh.h
//  YueLan
//
//  Created by Mu7Wind on 2017/6/13.
//  Copyright © 2017年 汪炳权. All rights reserved.
//

typedef void(^RefreshBlock)();

#import <UIKit/UIKit.h>

@interface UITableView (YLMJRefresh)

@property (nonatomic) RefreshBlock refreshBlock;

- (void)setCustomFooterWithRefreshingBlock:(RefreshBlock)refreshBlock;

- (void)setCustomFooterWithNoMoreStr:(NSString *)str andCount:(NSInteger)count RefreshingBlock:(RefreshBlock)refreshBlock;

@end
