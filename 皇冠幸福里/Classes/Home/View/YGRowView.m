//
//  YGRowView.m
//  CASAMIEL
//
//  Created by YGLEE on 2018/4/19.
//  Copyright © 2018年 YGLEE. All rights reserved.
//

#import "YGRowView.h"
#import "YGProduct.h"

@protocol YGStoryViewDelegate <NSObject>
- (void)storyViewDidClickDetailButton:(UIButton *)button;
@end

@interface YGStoryView : UIView
@property (nonatomic, weak) id<YGStoryViewDelegate> delegate;
@property (nonatomic, weak) UIImageView *picView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *detailLabel;
@property (nonatomic, weak) UIButton *detailBtn;
@end

@implementation YGStoryView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIImageView *picView = [[UIImageView alloc] init];
        picView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:picView];
        self.picView = picView;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UILabel *detailLabel = [[UILabel alloc] init];
        detailLabel.font = [UIFont systemFontOfSize:15];
        detailLabel.textColor = [UIColor grayColor];
        [self addSubview:detailLabel];
        self.detailLabel = detailLabel;
        
        UIButton *detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        detailBtn.backgroundColor = [UIColor blackColor];
        [detailBtn setTitle:@"看看" forState:UIControlStateNormal];
        [detailBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        detailBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        detailBtn.layer.cornerRadius = 15.f;
        detailBtn.clipsToBounds = YES;
        [detailBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:detailBtn];
        self.detailBtn = detailBtn;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.picView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.width.equalTo(self);
        make.height.equalTo(self.mas_width).multipliedBy(0.32);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-120);
        make.top.equalTo(self).offset(150);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-120);
        make.top.equalTo(self).offset(175);
    }];
    
    [self.detailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20);
        make.top.equalTo(self).offset(155);
        make.width.equalTo(@(70));
        make.height.equalTo(@(30));
    }];
}

- (void)buttonClick:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(storyViewDidClickDetailButton:)]) {
        [self.delegate storyViewDidClickDetailButton:button];
    }
}

@end


@interface YGRowView ()
@property (nonatomic, weak) YGStoryView *storyView;
@end


@implementation YGRowView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        for (int i = 0; i < rowMaxCount; i++) {
            YGStoryView *storyView = [[YGStoryView alloc] init];
            storyView.detailBtn.tag = i;
            [self addSubview:storyView];
            self.storyView = storyView;
        }
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (int i = 0; i < rowMaxCount; i++) {
        YGStoryView *storyView = self.subviews[i];
        CGFloat storyX = 0;
        CGFloat storyW = kScreenW;
        CGFloat storyH = 210;
        CGFloat storyY = i * storyH;
        storyView.frame = CGRectMake(storyX, storyY, storyW, storyH);
    }
}

- (void)setProducts:(NSArray *)products
{
    _products = products;
    
    NSArray *rowProducts = [products subarrayWithRange:NSMakeRange(0, rowMaxCount)];
    
    for (int i = 0; i < rowMaxCount; i++) {
        YGProduct *rowProduct = rowProducts[i];
        YGStoryView *storyView = self.subviews[i];
        NSURL *imgUrl = [NSURL URLWithString:rowProduct.productImg];
        UIImage *phImg = [UIImage imageNamed:@"happiness_gray"];
        [storyView.picView sd_setImageWithURL:imgUrl placeholderImage:phImg];
        storyView.titleLabel.text = rowProduct.productName;
        storyView.detailLabel.text = rowProduct.summary;
    }
}
@end
