//
//  UITableView+YLMJRefresh.m
//  YueLan
//
//  Created by Mu7Wind on 2017/6/13.
//  Copyright © 2017年 汪炳权. All rights reserved.
//

#import "UITableView+YLMJRefresh.h"


static const void *YLRefreshBlock = @"RefreshBlock";

@implementation UITableView (YLMJRefresh)

- (ClickBlock)refreshBlock{
    return objc_getAssociatedObject(self, &YLRefreshBlock);
}

- (void)setRefreshBlock:(RefreshBlock)refreshBlock{
    
    objc_setAssociatedObject(self, &YLRefreshBlock, refreshBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setCustomFooterWithRefreshingBlock:(RefreshBlock)refreshBlock{

    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    self.refreshBlock = refreshBlock;
    
    // 设置文字
    [footer setTitle:@"上拉加载更多" forState:MJRefreshStateIdle];
    [footer setTitle:@"努力加载中..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"加载完毕" forState:MJRefreshStateNoMoreData];
    
    // 设置字体
    footer.stateLabel.font = [UIFont systemFontOfSize:14];
    
    footer.stateLabel.textColor = UIColorFromHex(0xcccccc);
    
    // 设置footer
    self.mj_footer = footer;
    
    
    
}

- (void)setCustomFooterWithNoMoreStr:(NSString *)str andCount:(NSInteger)count RefreshingBlock:(RefreshBlock)refreshBlock{

    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    self.refreshBlock = refreshBlock;
    
    // 设置文字
    [footer setTitle:@"上拉加载更多" forState:MJRefreshStateIdle];
    [footer setTitle:@"努力加载中..." forState:MJRefreshStateRefreshing];
    
    if (count >= 50) {
        
        [footer setTitle:str forState:MJRefreshStateNoMoreData];
    }else{
    
        [footer setTitle:@"加载完毕" forState:MJRefreshStateNoMoreData];
    }
    
    
    
    // 设置字体
    footer.stateLabel.font = [UIFont systemFontOfSize:14];
    
    footer.stateLabel.textColor = UIColorFromHex(0xcccccc);
    
    // 设置footer
    self.mj_footer = footer;
}

- (void)loadMoreData{

    self.refreshBlock();
}

@end
