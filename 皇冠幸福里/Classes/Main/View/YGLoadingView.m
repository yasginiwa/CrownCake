//
//  YGLoadingView.m
//  皇冠幸福里
//
//  Created by LiYugang on 2018/4/25.
//  Copyright © 2018年 LiYugang. All rights reserved.
//

#import "YGLoadingView.h"
#import "YGActivityIndicator.h"

@interface YGLoadingView ()
@property (nonatomic, weak) UIImageView *logoView;
@property (nonatomic, weak) YGActivityIndicator *waitingIndicator;
@end


@implementation YGLoadingView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = YGColorWithRGBA(240, 240, 240, 1.0);
        
        UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loadingBg"]];
        [self addSubview:logoView];
        self.logoView = logoView;
        
        YGActivityIndicator *waitingIndicator = [[YGActivityIndicator alloc] init];
        [waitingIndicator startAnimating];
        [self addSubview:waitingIndicator];
        self.waitingIndicator = waitingIndicator;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat padding = 8;
    CGFloat delta = self.logoView.width + self.waitingIndicator.width + padding;
    
    self.logoView.x = (kScreenW - delta) * 0.5;
    self.logoView.centerY = kScreenH * 0.5 + 15;
    NSLog(@"%@", NSStringFromCGRect(self.logoView.frame));
    
    self.waitingIndicator.x = CGRectGetMaxX(self.logoView.frame) + padding;
    self.waitingIndicator.centerY = kScreenH * 0.5;
    self.waitingIndicator.width = 30;
    self.waitingIndicator.height = 30;
}

@end
