//
//  YGTabBar.m
//  皇冠幸福里
//
//  Created by LiYugang on 2018/4/24.
//  Copyright © 2018年 LiYugang. All rights reserved.
//

#import "YGTabBar.h"

@interface YGPayButton : UIButton

@end

@implementation YGPayButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:10];
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = imageW;
    CGFloat imageX = (self.width - imageW) * 0.5;
    CGFloat imageY = 0;
    
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleY = self.height * 0.67;
    CGFloat titleW = self.width;
    CGFloat titleH = self.height * 0.3;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

- (void)setHighlighted:(BOOL)highlighted
{
    
}

@end


@implementation YGTabBar

+ (void)initialize
{
    [[UITabBar appearance] setBarStyle:UIBarStyleBlack];
}

#pragma mark - lazy load
- (YGPayButton *)payButton
{
    if (_payButton == nil) {
        _payButton = [YGPayButton buttonWithType:UIButtonTypeCustom];
        [_payButton setImage:[UIImage imageNamed:@"centerBtn"] forState:UIControlStateNormal];
        [_payButton setTitle:@"付款码" forState:UIControlStateNormal];
    }
    return _payButton;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundImage = [UIImage imageNamed:@"background"];
        [self addSubview:self.payButton];
        [self.payButton addTarget:self action:@selector(payClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    self.payButton.frame = CGRectMake(0, -24, 54, 80);
    self.payButton.centerX = self.centerX;
    
    int index = 0;
    CGFloat itemW = self.width / 5;
    for (UIView *sub in self.subviews) {
        if ([sub isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            sub.frame = CGRectMake(index * itemW, 0, itemW, self.height);
            index++;
            if (index == 2) {
                index++;
            }
        }
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (self.isHidden == NO) {
        CGPoint newPoint = [self convertPoint:point toView:self.payButton];
        if ([self.payButton pointInside:newPoint withEvent:event]) {
            return self.payButton;
        }else {
            return [super hitTest:point withEvent:event];
        }
    }
    else {
        return [super hitTest:point withEvent:event];
    }
}

- (void)payClick
{
    NSLog(@"--payClick--");
}


@end
