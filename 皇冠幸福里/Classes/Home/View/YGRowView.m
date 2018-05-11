//
//  YGRowView.m
//  CASAMIEL
//
//  Created by YGLEE on 2018/4/19.
//  Copyright © 2018年 YGLEE. All rights reserved.
//

#import "YGRowView.h"
#import "YGProduct.h"

@interface YGStoryView : UIView
@property (nonatomic, weak) UIButton *detailBtn;
@property (nonatomic, weak) UIImageView *picView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *detailLabel;
@property (nonatomic, strong) YGProduct *product;
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
        detailBtn.backgroundColor = YGColorWithRGBA(124, 103, 82, 1.0);
        [detailBtn setTitle:@"看看" forState:UIControlStateNormal];
        [detailBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        detailBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        detailBtn.layer.cornerRadius = 14.f;
        detailBtn.clipsToBounds = YES;
        [self addSubview:detailBtn];
        self.detailBtn = detailBtn;
    }
    return self;
}

- (void)setProduct:(YGProduct *)product
{
    _product = product;
    
    NSURL *imgUrl = [NSURL URLWithString:product.productImg];
    UIImage *phImg = [UIImage imageNamed:@"logo_banner_gray"];
    [self.picView sd_setImageWithURL:imgUrl placeholderImage:phImg];
    self.titleLabel.text = product.productName;
    self.detailLabel.text = product.summary;
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
        make.width.equalTo(@(60));
        make.height.equalTo(@(30));
    }];
}

@end

@interface YGRowView ()
@property (nonatomic, weak) YGStoryView *storyView;
@property (nonatomic, assign) NSUInteger maxCount;
@end

@implementation YGRowView

- (instancetype)initWithType:(rowType)type
{
    if (self = [super init]) {
        if (type == rowTypeSummary) {
            self.maxCount = 3;
        } else if (type == rowTypeDetail) {
            self.maxCount = 5;
        }
        
        for (int i = 0; i < self.maxCount; i++) {
            YGStoryView *storyView = [[YGStoryView alloc] init];
            storyView.detailBtn.tag = i;
            [storyView.detailBtn addTarget:self action:@selector(detailBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:storyView];
            self.storyView = storyView;
        }
    }
    return self;
}

- (void)detailBtnClick:(UIButton *)button
{
    [[NSNotificationCenter defaultCenter] postNotificationName:YGRowDetailBtnDidClickNote object:nil userInfo:@{@"index" : @(button.tag)}];
    NSLog(@"--%lu--", button.tag);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (int i = 0; i < self.maxCount; i++) {
        YGStoryView *storyView = self.subviews[i];
        CGFloat storyX = 0;
        CGFloat storyW = kScreenW;
        CGFloat storyH = 210;
        CGFloat storyY = i * storyH;
        storyView.frame = CGRectMake(storyX, storyY, storyW, storyH);
    }
    self.height = [self.subviews lastObject].height;
}

- (void)setProducts:(NSArray *)products
{
    _products = products;
    
    for (int i = 0; i < self.maxCount; i++) {
        YGProduct *rowProduct = self.products[i];
        YGStoryView *storyView = self.subviews[i];
        storyView.product = rowProduct;
    }
}
@end
