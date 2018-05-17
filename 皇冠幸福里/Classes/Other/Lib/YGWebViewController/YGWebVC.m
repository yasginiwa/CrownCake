//
//  YGWebVC.m
//  YGProgressWebView
//
//  Created by LiYugang on 2018/5/17.
//  Copyright © 2018年 LiYugang. All rights reserved.
//

#import "YGWebVC.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"

@interface YGWebVC () <NJKWebViewProgressDelegate, UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) NJKWebViewProgress *progressProxy;
@property (nonatomic, strong) NJKWebViewProgressView *progressView;
@end

@implementation YGWebVC

#pragma mark - 懒加载
-(UIWebView *)webView
{
    if (_webView == nil) {
        _webView = [[UIWebView alloc] init];
        _webView.scalesPageToFit = YES;
        _webView.delegate = self.progressProxy;
        [self.view addSubview:_webView];
    }
    return _webView;
}

- (NJKWebViewProgress *)progressProxy
{
    if (_progressProxy == nil) {
        _progressProxy = [[NJKWebViewProgress alloc] init];
        _progressProxy.progressDelegate = self;
        _progressProxy.webViewProxyDelegate = self;
    }
    return _progressProxy;
}

- (NJKWebViewProgressView *)progressView
{
    if (_progressView == nil) {
        CGFloat progressBarHeight = 2.f;
        CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
        CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, navigationBarBounds.size.width, progressBarHeight);
        _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
        _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    }
    return _progressView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:self.progressView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupAppearance];
    
    [self loadUrl];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.progressView removeFromSuperview];
}

#pragma mark - NJKWebViewProgressDelegate
- (void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    self.progressView.progress = .0f;
    [self.progressView setProgress:progress animated:YES];
}

- (void)setupAppearance
{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"back_icon"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    self.hidesBottomBarWhenPushed = YES;
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadUrl
{
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.url]];
    [self.webView loadRequest:req];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.webView.frame = self.view.bounds;
}

- (void)dealloc
{
    NSLog(@"--webVc--dealloc--");
}
@end
