//
//  YGMainWebVC.m
//  皇冠幸福里
//
//  Created by LiYugang on 2018/5/9.
//  Copyright © 2018年 LiYugang. All rights reserved.
//

#import "YGMainWebVC.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"

@interface YGMainWebVC ()<UIWebViewDelegate, NJKWebViewProgressDelegate>

@end


@implementation YGMainWebVC
{
    UIWebView *_webView;
    NJKWebViewProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _progressProxy = [[NJKWebViewProgress alloc] init];
    _webView.delegate = _progressProxy;
    _webView.frame = CGRectMake(0, 0, kScreenW, kScreenH);

    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    CGFloat progressBarHeight = 2.f;
    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, navigationBarBounds.size.width, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
    [self loadUrl];
    
    NSLog(@"%@", self.view.subviews);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:_progressView];
    [self.view addSubview:_webView];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Remove progress view
    // because UINavigationBar is shared with other ViewControllers
    [_progressView removeFromSuperview];
}


-(void)loadUrl
{
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_url]];
    [_webView loadRequest:req];
}

#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
    self.title = self.barTitle;
}
@end
