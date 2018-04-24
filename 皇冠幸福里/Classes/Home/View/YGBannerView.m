//
//  YGBannerView.m
//  CASAMIEL
//
//  Created by LiYugang on 2018/4/19.
//  Copyright © 2018年 YGLEE. All rights reserved.
//

#import "YGBannerView.h"

@interface YGBannerView ()
@property (nonatomic, weak) UIImageView *logoView;
@property (nonatomic, weak) UILabel *titleEnLabel;
@property (nonatomic, weak) UILabel *titleChsLabel;
@property (nonatomic, weak) UIView *titleChsView;
@property (nonatomic, weak) UIImageView *leftLine;
@property (nonatomic, weak) UIImageView *rightLine;
@end

@implementation YGBannerView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setLogo];
        [self setTitleEn];
        [self setTitleChs];
    }
    return self;
}

- (void)setTitleTextEn:(NSString *)titleTextEn
{
    self.titleEnLabel.text = titleTextEn;
    self.titleEnLabel.textAlignment = NSTextAlignmentCenter;
    self.titleEnLabel.font = [UIFont systemFontOfSize:18];
}

- (void)setTitleTextChs:(NSString *)titleTextChs
{
    self.titleChsLabel.text = titleTextChs;
    self.titleChsLabel.textAlignment = NSTextAlignmentCenter;
    self.titleChsLabel.font = [UIFont systemFontOfSize:15];
    self.titleChsLabel.textColor = [UIColor lightGrayColor];
}

- (void)setLogo
{
    UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xiaomifeng@3x"]];
    logoView.contentMode = UIViewContentModeCenter;
    [self addSubview:logoView];
    self.logoView = logoView;
}

- (void)setTitleEn
{
    UILabel *titleEnLabel = [[UILabel alloc] init];
    [self addSubview:titleEnLabel];
    self.titleEnLabel = titleEnLabel;
}

- (void)setTitleChs
{
    UIView *titleChsView = [[UIView alloc] init];
    
    UILabel *titleChsLabel = [[UILabel alloc] init];
    
    UIImageView *leftLine = [[UIImageView alloc] init];
    leftLine.image = [UIImage imageNamed:@"line2_left"];
    self.leftLine = leftLine;
    
    UIImageView *rightLine = [[UIImageView alloc] init];
    rightLine.image = [UIImage imageNamed:@"line2_right"];
    self.rightLine = rightLine;
    
    [titleChsView addSubview:titleChsLabel];
    [titleChsView addSubview:leftLine];
    [titleChsView addSubview:rightLine];
    [self addSubview:titleChsView];
    
    self.titleChsLabel = titleChsLabel;
    self.titleChsView = titleChsView;
    
    titleChsLabel.frame = titleChsView.bounds;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.logoView.y = 0;
    self.logoView.width = kScreenW;
    self.logoView.height = 44;
    self.logoView.centerX = kScreenW * 0.5;
    
    self.titleEnLabel.y = CGRectGetMaxY(self.logoView.frame);
    self.titleEnLabel.width = kScreenW;
    self.titleEnLabel.height = 30;
    self.titleEnLabel.centerX = kScreenW * 0.5;
    
    self.titleChsView.y = CGRectGetMaxY(self.titleEnLabel.frame);
    self.titleChsView.width = kScreenW;
    self.titleChsView.height = 30;
    self.titleChsView.centerX = kScreenW * 0.5;
    
    self.titleChsLabel.frame = self.titleChsView.bounds;
    
    self.leftLine.size = CGSizeMake(kScreenW * 0.5 * 0.5, 3);
    self.leftLine.centerX = kScreenW * 0.5 * 0.5;
    self.leftLine.centerY = self.titleChsLabel.centerY;
    
    self.rightLine.size = CGSizeMake(kScreenW * 0.5 * 0.5, 3);
    self.rightLine.centerX = kScreenW * 0.75;
    self.rightLine.centerY = self.titleChsLabel.centerY;
}

- (CGFloat)bannerHeight
{
    return self.logoView.height + self.titleEnLabel.height + self.titleChsView.height;
}
@end
