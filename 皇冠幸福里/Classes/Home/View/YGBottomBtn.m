//
//  YGBottomBtn.m
//  CASAMIEL
//
//  Created by LiYugang on 2018/4/23.
//  Copyright © 2018年 YGLEE. All rights reserved.
//

#import "YGBottomBtn.h"

@implementation YGBottomBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitle:self.text forState:UIControlStateNormal];
        
        self.imageView.contentMode = UIViewContentModeCenter;
        [self setImage:[UIImage imageNamed:self.image] forState:UIControlStateNormal];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted
{
    
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleY = 0;
    CGFloat titleW = self.width * 0.7;
    CGFloat titleH = self.height;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageX = self.width * 0.7;
    CGFloat imageY = 0;
    CGFloat imageW = self.width * 0.3;
    CGFloat imageH = self.height;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

@end
