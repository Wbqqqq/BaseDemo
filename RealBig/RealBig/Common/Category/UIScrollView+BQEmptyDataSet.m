//
//  UIScrollView+BQEmptyDataSet.m
//  YueLan
//
//  Created by 汪炳权 on 2017/5/24.
//  Copyright © 2017年 汪炳权. All rights reserved.
//

#import "UIScrollView+BQEmptyDataSet.h"
#import <objc/runtime.h>

static const void *EmptyDataClickBlock = @"EmptyDataClickBlock";
static const void *EmptyDataOffset = @"EmptyDataOffset";
static const void *EmptyDataText   = @"EmptyDataText";
static const void *EmptyDataImage  = @"EmptyDataImage";
static const void *IsLoading       = @"IsLoading";
static const void *EmptyDataCustomView = @"EmptyDataCustomView";
static const void *ShowNoNetImage = @"showNoNetImage";

@implementation UIScrollView (BQEmptyDataSet)

- (ClickBlock)clickBlock{
    return objc_getAssociatedObject(self, &EmptyDataClickBlock);
}

- (void)setClickBlock:(ClickBlock)clickBlock{
    
    objc_setAssociatedObject(self, &EmptyDataClickBlock, clickBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


-(BOOL)showNoNetImage
{
    NSNumber *number = objc_getAssociatedObject(self, &ShowNoNetImage);
    return number.boolValue;
}

-(void)setShowNoNetImage:(BOOL)showNoNetImage
{
    NSNumber *number = [NSNumber numberWithDouble:showNoNetImage];
    objc_setAssociatedObject(self, &ShowNoNetImage, number, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGFloat)emptyDataOffset{
    
    NSNumber *number = objc_getAssociatedObject(self, &EmptyDataOffset);
    return number.floatValue;
}

- (void)setEmptyDataOffset:(CGFloat)emptyDataOffset
{
    NSNumber *number = [NSNumber numberWithDouble:emptyDataOffset];
    objc_setAssociatedObject(self, &EmptyDataOffset, number, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


- (NSString *)emptyDataImage{
    return objc_getAssociatedObject(self, &EmptyDataImage);
}

- (void)setEmptyDataImage:(NSString *)emptyDataImage
{
    objc_setAssociatedObject(self, &EmptyDataImage, emptyDataImage, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)emptyDataText{
    return objc_getAssociatedObject(self, &EmptyDataText);
}

- (void)setEmptyDataText:(NSString *)emptyDataText{
    objc_setAssociatedObject(self, &EmptyDataText, emptyDataText, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


-(BOOL)isLoading
{
    NSNumber *number = objc_getAssociatedObject(self, &IsLoading);
    return number.boolValue;
}

-(void)setIsLoading:(BOOL)isLoading
{
    NSNumber *number = [NSNumber numberWithBool:isLoading];
    objc_setAssociatedObject(self, &IsLoading, number, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self reloadEmptyDataSet];
}


-(UIView *)emptyDataCustomView
{
    return objc_getAssociatedObject(self, &EmptyDataCustomView);
}

-(void)setEmptyDataCustomView:(UIView *)emptyDataCustomView
{
    objc_setAssociatedObject(self, &EmptyDataCustomView, emptyDataCustomView, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


-(void)setupEmptyDataText:(NSString *)text verticalOffset:(CGFloat)offset emptyImage:(NSString *)image showNoNetImage:(BOOL)show enableTap:(BOOL)enable tapBlock:(ClickBlock)clickBlock
{
    self.emptyDataImage = image;
    self.emptyDataText = text;
    self.emptyDataOffset = offset;
    self.showNoNetImage = show;
    self.clickBlock = clickBlock;
    
    self.emptyDataSetSource = self;
    self.emptyDataSetDelegate = self;
    [self reloadEmptyDataSet];

//     @weakify(self);
//    [[YLNotificationCenter rac_addObserverForName:THEMECHANGE object:nil] subscribeNext:^(NSNotification * _Nullable x) {
//        @strongify(self);
//        
//        self.emptyDataImage = [UIImage imageNamed:@"empty_data_dark"];
//        
//        [self reloadEmptyDataSet];
//    }];
}

-(void)setupEmotyCustomView:(UIView *)view verticalOffset:(CGFloat)offset tapBlock:(ClickBlock)clickBlock
{


}

#pragma DZNEmptyDataSetDelegate

- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView {
    
    BQEmptyDataCustomView * view = [[BQEmptyDataCustomView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    view.backgroundColor = [UIColor clearColor];
    view.centerY = self.center.y + self.emptyDataOffset;
    view.userInteractionEnabled = YES;
    view.emptyDataOffset = self.emptyDataOffset;
    
    if([ModelLocator sharedInstance].reachabilityStatus == YYReachabilityWWANStatusNone && self.showNoNetImage)
    {
//        UIImageView * iv = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"error_data"]];
        
        UIImageView * iv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
        //        iv.image = [UIImage imageNamed:self.emptyDataImage];
//        iv.dk_imagePicker = DKImagePickerWithNames(@"error_data",@"error_data_dark");
        
        iv.centerX = view.centerX;
        iv.top = view.top - 30;
        [view addSubview:iv];
        
        UILabel * lb = [[UILabel alloc]initWithFrame:CGRectZero];
        lb.top = iv.bottom + 30;
        lb.textAlignment = NSTextAlignmentCenter;
        lb.font = [UIFont fontWithName:CUSTOMFONTNAME size:20];
        lb.text = @"您目前网络不佳，请设置网络～";
        lb.textColor = UIColorFromHex(0xbbbbbb);
        [lb sizeToFit];
        lb.centerX = view.centerX;
        [view addSubview:lb];
        return view;
    }
    
    if(self.isLoading){
        
        [view addLoadingView];
        return view;
    }
    else{
      
        UIImageView * iv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
//        iv.dk_imagePicker = DKImagePickerWithNames(self.emptyDataImage,[NSString stringWithFormat:@"%@_dark",self.emptyDataImage]);

        
        iv.centerX = view.centerX;
        iv.top = view.top - 30;
        [view addSubview:iv];
            
        UILabel * lb = [[UILabel alloc]initWithFrame:CGRectZero];
        lb.top = iv.bottom + 30;
        lb.textAlignment = NSTextAlignmentCenter;
        lb.font = [UIFont fontWithName:CUSTOMFONTNAME size:20];
        lb.text = self.emptyDataText;
        lb.textColor = UIColorFromHex(0xbbbbbb);
        [lb sizeToFit];
        lb.centerX = view.centerX;
        [view addSubview:lb];
        return view;
    }
}

// 是否 允许点击,默认是YES
- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView{
    
    return YES;
}

//是否允许滚动，默认NO
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}

// 垂直偏移量
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    return self.emptyDataOffset;
}


-(void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    if(self.isLoading) return;
    
    
    if(self.clickBlock)
    {
        self.clickBlock();
    }
}


@end



@implementation BQEmptyDataCustomView

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
       
    }
    return self;
}

-(void)addLoadingView
{
    [self removeAllSubviews];
    NSMutableArray * ivArr = [NSMutableArray new];
    for (int index = 0; index < 34; index ++) {
        
        NSBundle *bundle = [NSBundle mainBundle];
        
        NSString *path = [bundle pathForResource:[NSString stringWithFormat:@"loading_%d.png",index] ofType:nil];
        
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        
        [ivArr addObject:image];
        
    }
    
    YYAnimatedImageView * iv = [[YYAnimatedImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    

    iv.center = self.center;
    
    iv.top =  iv.top - 35 * Width_Scale + self.emptyDataOffset*1.8;
    
    NSLog(@"top is %f",iv.top);
    
    iv.animationImages = ivArr;
    
    iv.animationDuration = 34 * 0.05;
    //动画重复次数 （0为重复播放）
    iv.animationRepeatCount = 0;
    //开始播放动画
    [iv startAnimating];
    
    [self addSubview:iv];
    
    
    UILabel * lb = [[UILabel alloc]initWithFrame:CGRectZero];
    lb.top = iv.bottom ;
    lb.textAlignment = NSTextAlignmentCenter;
    lb.font = [UIFont fontWithName:CUSTOMFONTNAME size:20];
    lb.text = @"努力加载ing~";
    lb.textColor = UIColorFromHex(0xfdae66);
    [lb sizeToFit];
    lb.centerX = self.centerX;
    [self addSubview:lb];

}

-(void)setFailureViewWithTapBlock:(TapBlock)block
{
    [self removeAllSubviews];
    
    UIImageView * iv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    
//    if ([self.dk_manager.themeVersion isEqualToString:DKThemeVersionNormal]) {
//        
//        iv.image =[UIImage imageNamed:@"error_data"];
//    }else{
//    
//        iv.image = [UIImage imageNamed:@"error_data_dark"];
//    }
//    iv.dk_imagePicker = DKImagePickerWithNames(@"error_data",@"error_data_dark");
    
    iv.centerX = self.width/2;
    iv.centerY = self.height/2 - 30;
    [self addSubview:iv];
    
    UILabel * lb = [[UILabel alloc]initWithFrame:CGRectZero];
    lb.top = iv.bottom + 30;
    lb.textAlignment = NSTextAlignmentCenter;
    lb.font = [UIFont fontWithName:CUSTOMFONTNAME size:20];
    lb.text = @"您目前网络不佳，请设置网络～";
    lb.textColor = UIColorFromHex(0xbbbbbb);
    [lb sizeToFit];
    lb.centerX = self.centerX;
    [self addSubview:lb];
    
    
    @weakify(self);
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
        @strongify(self);
        [self addLoadingView];
        if(block) block();
    }];
    [self addGestureRecognizer:tap];
}

@end


