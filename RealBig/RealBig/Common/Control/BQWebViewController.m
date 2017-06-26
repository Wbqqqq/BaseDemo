//
//  BQWebViewController.m
//  YueLan
//
//  Created by 汪炳权 on 2017/6/5.
//  Copyright © 2017年 汪炳权. All rights reserved.
//

#import "BQWebViewController.h"
#import <WebKit/WebKit.h>

@interface BQWebViewController ()<WKNavigationDelegate>
@property(nonatomic,strong)WKWebView * webView;
@property(nonatomic,strong)UIActivityIndicatorView * indicatorView;
@property(nonatomic,strong)NSString * urlStr;
@end

@implementation BQWebViewController

- (instancetype)initWithUrl:(NSString *)url {
    self = [super init];
    if (self) {
        self.urlStr = url;
    }
    return self;
}

-(void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"title"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    self.webView.navigationDelegate = self;
    self.view.backgroundColor = BgViewColor;
    self.webView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.webView];
    
    self.indicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.indicatorView.frame = CGRectMake(SCREEN_WIDTH / 2.0 - 15,((SCREEN_HEIGHT-64)/ 2.0) - 15, 30, 30);
    self.indicatorView.hidesWhenStopped = YES;
    [self.view addSubview:self.indicatorView];
    [self.indicatorView startAnimating];

    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]]];
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    
    
   
}

#pragma mark - WKWebViewDelegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [self.indicatorView stopAnimating];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
  
    if ([keyPath isEqualToString:@"title"])
    {
        self.title = self.webView.title;
    }
   
}



@end
