//
//  BaseViewController.m
//  一元夺宝
//
//  Created by wbq on 16/8/15.
//  Copyright © 2016年 wbq. All rights reserved.
//

#import "BaseViewController.h"
#import "UMMobClick/MobClick.h"
#import "UIImage+BQAdd.h"
@interface BaseViewController ()
@property (nonatomic,strong)UIButton * leftButton;
@end

@implementation BaseViewController

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    NSLog(@"%@",self.title);
//    [Utility trackPageBegin:self.title];
    [MobClick beginLogPageView:self.title];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
//    [Utility trackPageEnd:self.title];
    [MobClick endLogPageView:self.title];
}



- (void)viewDidLoad {
    [super viewDidLoad];
   
    [UIApplication sharedApplication].applicationSupportsShakeToEdit = YES;

    [self becomeFirstResponder];


}


-(void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion
{
    [self creatDismissBtn:viewControllerToPresent];
    [super presentViewController:viewControllerToPresent animated:flag completion:completion];
}

- (void)creatDismissBtn:(id)viewController{
    
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 25, 25);
    [backBtn setImage:[UIImage imageNamed:@"dknavback"] forState:UIControlStateNormal];
    [backBtn setTintColor:[UIColor whiteColor]];
    
    
    [[backBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [viewController dismissViewControllerAnimated:YES completion:nil];
    }];
}


- (instancetype)initWithTitle:(NSString *)title {
    self = [super init];
    if (self) {
        self.title = title;
    }
    return self;
}


- (BOOL)isLogin
{
    if(!USER_TOKEN)
    {
//        YLLoginViewController * vc = [[YLLoginViewController alloc]init];
//        BaseNavigationViewController * nav = [[BaseNavigationViewController alloc]initWithRootViewController:vc];
//        [self presentViewController:nav animated:YES completion:nil];
        return NO;
    }
    return YES;
}


-(void)Logout
{
//    [USER_DEFAULT setObject:nil forKey:YLUSERINFO];
//    [USER_DEFAULT setObject:nil forKey:YLTOKEN];
//    [USER_DEFAULT synchronize];
//    [BQHTTPClient clearCache];
//   
//    [ModelLocator sharedInstance].isLogin = NO;
//    [[NSNotificationCenter defaultCenter] postNotificationName:USERLOGOUT object:nil];
}



-(void)addDissmissLeftBarItem
{
    UIButton *close = [[UIButton alloc] initWithFrame:CGRectMake(0, 0,  35, 20)];
    close.titleLabel.font = [UIFont systemFontOfSize:15];
    [close setTitle:@"关闭" forState:UIControlStateNormal];
    [close setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    @weakify(self);
    [[close rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:close];
}










@end
