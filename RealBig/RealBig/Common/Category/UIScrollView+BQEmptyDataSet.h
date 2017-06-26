//
//  UIScrollView+BQEmptyDataSet.h
//  YueLan
//
//  Created by 汪炳权 on 2017/5/24.
//  Copyright © 2017年 汪炳权. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

typedef void(^ClickBlock)();

@interface UIScrollView (BQEmptyDataSet)<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic)         ClickBlock clickBlock; 
@property (nonatomic, assign) CGFloat   emptyDataOffset;     // 垂直偏移量
@property (nonatomic, strong) NSString *emptyDataText;       // 空数据显示内容
@property (nonatomic, strong) NSString  *emptyDataImage;      // 空数据的图片
@property (nonatomic, assign) BOOL      isLoading;
@property (nonatomic, strong) UIView   *emptyDataCustomView;     //自定义布局
@property (nonatomic, assign) BOOL     showNoNetImage;       //是否显示没网图片

- (void)setupEmptyDataText:(NSString *)text verticalOffset:(CGFloat)offset emptyImage:(NSString *)image showNoNetImage:(BOOL)show enableTap:(BOOL)enable tapBlock:(ClickBlock)clickBlock;

- (void)setupEmotyCustomView:(UIView *)view verticalOffset:(CGFloat)offset tapBlock:(ClickBlock)clickBlock;


@end


typedef void(^TapBlock)();
@interface BQEmptyDataCustomView: UIView

@property (nonatomic, assign) CGFloat emptyDataOffset;

-(void)addLoadingView;

-(void)setFailureViewWithTapBlock:(TapBlock)block;

@end
