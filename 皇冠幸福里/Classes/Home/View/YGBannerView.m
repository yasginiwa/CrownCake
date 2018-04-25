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
@property (nonatomic, weak) UILabel *enLabel;
@property (nonatomic, weak) UILabel *chsLabel;
@end

@implementation YGBannerView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 设置logoView
        UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"happiness"]];
        logoView.contentMode = UIViewContentModeCenter;
        [self addSubview:logoView];
        self.logoView = logoView;
        
        // 设置英文label
        UILabel *enLabel = [[UILabel alloc] init];
        enLabel.textAlignment = NSTextAlignmentCenter;
        enLabel.font = [UIFont systemFontOfSize:20];
        enLabel.textColor = [UIColor blackColor];
        [self addSubview:enLabel];
        self.enLabel = enLabel;
        
        // 设置中文label
        UILabel *chsLabel = [[UILabel alloc] init];
        chsLabel.textAlignment = NSTextAlignmentCenter;
        chsLabel.font = [UIFont systemFontOfSize:15];
        chsLabel.textColor = [UIColor grayColor];
        [self addSubview:chsLabel];
        self.chsLabel = chsLabel;
        
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // 设置logoView的frame
    self.logoView.x = 0;
    self.logoView.y = 0;
    self.logoView.width = kScreenW;
    self.logoView.height = 50;
    
    // 设置英文label的frame
    self.enLabel.x = 0;
    self.enLabel.y = CGRectGetMaxY(self.logoView.frame);
    self.enLabel.width = kScreenW;
    self.enLabel.height = 30;
    
    // 设置中文label的frame
    self.chsLabel.x = 0;
    self.chsLabel.y = CGRectGetMaxY(self.enLabel.frame);
    self.chsLabel.width = kScreenW;
    self.chsLabel.height = 30;
    
    self.viewHeight = CGRectGetMaxY(self.chsLabel.frame);
}

- (void)setTextEn:(NSString *)textEn
{
    _textEn = textEn;
    self.enLabel.text = textEn;
}

- (void)setTextChs:(NSString *)textChs
{
    _textChs = textChs;
    self.chsLabel.text = textChs;
}
@end
