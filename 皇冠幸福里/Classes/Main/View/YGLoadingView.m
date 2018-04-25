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
    
    self.logoView.x = kScreenW - self.logoView.size.height;
    self.logoView.centerY = kScreenH * 0.5;
    
    self.waitingIndicator.x = CGRectGetMaxX(self.logoView.frame) + 10;
    self.waitingIndicator.centerY = kScreenH * 0.5;    
}

@end
