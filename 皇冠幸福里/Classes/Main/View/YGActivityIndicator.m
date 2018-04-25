//
//  YGActivityIndicator.m
//  皇冠幸福里
//
//  Created by LiYugang on 2018/4/25.
//  Copyright © 2018年 LiYugang. All rights reserved.
//

#import "YGActivityIndicator.h"

@interface YGActivityIndicator ()
@property (nonatomic, strong) UIImageView *activityIndicator;
@end

@implementation YGActivityIndicator

#pragma mark - 懒加载
- (UIImageView *)activityIndicator
{
    if (_activityIndicator == nil) {
        _activityIndicator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading"]];
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:_activityIndicator];
    }
    return _activityIndicator;
}

// 模拟官方 重写setter方法 控件隐藏时暂停动画
- (void)setHidesWhenStopped:(BOOL)hidesWhenStopped
{
    _hidesWhenStopped = hidesWhenStopped;
    if (hidesWhenStopped) {
        self.activityIndicator.hidden = YES;
        [self stopAnimating];
    } else {
        self.activityIndicator.hidden = NO;
        [self startAnimating];
    }
}

// 开始动画
- (void)startAnimating
{
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    anim.fromValue = [NSNumber numberWithFloat:.0f];
    anim.toValue = [NSNumber numberWithFloat:M_PI * 2];
    anim.duration = 1.f;
    anim.autoreverses = NO;
    anim.fillMode = kCAFillModeForwards;
    anim.repeatCount = MAXFLOAT;
    [self.activityIndicator.layer addAnimation:anim forKey:nil];
    self.activityIndicator.hidden = NO;
}

// 动画结束
- (void)stopAnimating
{
    [self.activityIndicator.layer removeAllAnimations];
    self.activityIndicator.hidden = YES;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.activityIndicator.frame = self.bounds;
}

@end
