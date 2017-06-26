//
//  BQThirdShareView.m
//  YueLan
//
//  Created by wbq on 2017/6/10.
//  Copyright © 2017年 汪炳权. All rights reserved.
//

#import "BQThirdShareView.h"
#import "AppDelegate.h"
@interface BQThirdShareView ()
@property(nonatomic,strong)UIButton * bottomToolBar;
@property(nonatomic,strong)NSMutableArray <UIButton *>* btnArr;

@end

@implementation BQThirdShareView

+(void)showWithTitle:(NSString *)title andText:(NSString *)text andImageUrl:(NSString *)thumimageUrl andUrl:(NSString *)url
{
    BQThirdShareView * view = [[BQThirdShareView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    view.title = title;
    view.text = text;
    view.thumimageUrl = thumimageUrl;
    view.webUrl = url;
    [YL_AppDelegate.window addSubview:view];
    [view startAnimation];
}

+(void)shoWImage:(UIImage *)image
{
    BQThirdShareView * view = [[BQThirdShareView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    view.shareImage = image;
    [YL_AppDelegate.window addSubview:view];
    [view startAnimation];

}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self overAnimation];
}


-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.01];
    }
    return self;
}



-(void)startAnimation
{
    self.bottomToolBar = [[UIButton alloc]initWithFrame:CGRectMake(0, 0,5, 5)];
    self.bottomToolBar.centerX = self.width/2;
    self.bottomToolBar.top = self.height - 5;
    self.bottomToolBar.backgroundColor = RGBCOLOR(230, 230, 230);
    [self addSubview:self.bottomToolBar];
    

    CGFloat margin = 35.0 * Width_Scale;
    
    CGFloat btnW = (SCREEN_WIDTH - 5 * margin)/4;
    CGFloat btnH = btnW;
    self.btnArr = [NSMutableArray new];
    
    for (int i = 0; i < 4; i++) {
        
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0,0, btnW, btnH)];
        btn.centerX = self.bottomToolBar.width/2;
        btn.top = self.bottomToolBar.height;
        switch (i) {
            case 0:
            {
                [btn setBackgroundImage:[UIImage imageNamed:@"share_wechat"] forState:UIControlStateNormal];
            }
                break;
            case 1:
            {
                [btn setBackgroundImage:[UIImage imageNamed:@"share_pyq"] forState:UIControlStateNormal];
            }
                break;
            case 2:
            {
                [btn setBackgroundImage:[UIImage imageNamed:@"share_zone"] forState:UIControlStateNormal];
            }
                break;
            case 3:
            {
                [btn setBackgroundImage:[UIImage imageNamed:@"share_sina"] forState:UIControlStateNormal];
            }
                break;
                
            default:
                break;
        }
        
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomToolBar addSubview:btn];
        [self.btnArr addObject:btn];
    }
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        self.bottomToolBar.frame = CGRectMake(0, self.height - 90, SCREEN_WIDTH, 90);
        
    } completion:^(BOOL finished) {
        
        

        
        
        
    }];
    
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        
        for (int i = 0 ; i < self.btnArr.count; i++) {
            
            self.btnArr[i].left = margin + i * (btnW + margin);
            self.btnArr[i].top  = (self.bottomToolBar.height - btnH)/2;
            
        }
        
        
        
    } completion:^(BOOL finished) {
        
    }];
    
    

}


-(void)overAnimation
{
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.alpha = 0;
        self.bottomToolBar.top = self.height;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
    }];
}


-(void)btnClick:(UIButton *)btn
{
    
    UMSocialPlatformType type = UMSocialPlatformType_WechatSession;
    switch (btn.tag) {
        case 0:
        {
            type = UMSocialPlatformType_WechatSession;
        }
            break;
        case 1:
        {
            type = UMSocialPlatformType_WechatTimeLine;
        }
            break;
        case 2:
        {
            type = UMSocialPlatformType_Qzone;
        }
            break;
        case 3:
        {
            type = UMSocialPlatformType_Sina;
            
//            [BQPopupView showAlertWithTitle:@"敬请期待" detail:@"即将上线，敬请期待" otherButtonTitles:@[@"确认"] withBlock:nil];
//            return;
            
            
        }
            break;
            
        default:
            break;
    }
    
    if(self.shareImage){
    
        [self shareImageToPlatformType:type];
    }else
    {
        [self shareWebPageToPlatformType:type];
    
    }
    
    [self overAnimation];

}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    // 创建分享预览图
    [BQProgressHUD show];
    
    UIImage *image = [[UIImage alloc] initWithData:[self synchronousDownLoadFromUrl:self.thumimageUrl]];
    //创建网页内容对象
    
    if (platformType == UMSocialPlatformType_Sina){
    
         UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
         messageObject.text = [NSString stringWithFormat:@"%@ %@",self.title,self.webUrl];
         shareObject.shareImage = image;
         shareObject.thumbImage = [UIImage imageNamed:@"app_icon"];
        
         //分享消息对象设置分享内容对象
         messageObject.shareObject = shareObject;
    
    }else{
    
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:self.title descr:self.text thumImage:image];
        //设置网页地址
        shareObject.webpageUrl = self.webUrl;
    
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
    }
    
    [BQProgressHUD dismiss];
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
            [BQProgressHUD showError:@"分享失败"];
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
            [BQProgressHUD showSuccess:@"分享成功"];
        }
    }];
    

}


- (void)shareImageToPlatformType:(UMSocialPlatformType)platformType
{
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //如果有缩略图，则设置缩略图
    shareObject.thumbImage = [UIImage imageNamed:@"app_icon"];
    
    [shareObject setShareImage:self.shareImage];
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {
        if (error) {
            [BQProgressHUD showError:@"分享失败"];
            NSLog(@"分享失败 ：%@",error);
        }else{
            [BQProgressHUD showSuccess:@"分享成功"];
            NSLog(@"分享成功 :  %@",data);
        }
    }];

}

//同步下载
-(NSData *)synchronousDownLoadFromUrl:(NSString *)url
{
    NSURL *netUrl = [[NSURL alloc]initWithString:url];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:netUrl];
    NSError *err = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error: &err];
    if(err){
        return nil;
    }
    return data;
}



@end
