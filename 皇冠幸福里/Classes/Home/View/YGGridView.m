//
//  YGGridView.m
//  CASAMIEL
//
//  Created by YGLEE on 2018/4/19.
//  Copyright © 2018年 YGLEE. All rights reserved.
//

#import "YGGridView.h"
#import "YGProduct.h"

@interface YGGridButton : UIButton

@end

@implementation YGGridButton
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleY = CGRectGetMaxY(self.imageView.frame);
    CGFloat titleW = self.width;
    CGFloat titleH = self.height * 0.3;
    return CGRectMake(titleX, titleY, titleW, titleH);
}
@end

#define maxCol 2
#define maxCount 4
#define margin 30

@implementation YGGridView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        for (int i = 0; i < maxCount; i++) {
            YGGridButton *gridBtn = [YGGridButton buttonWithType:UIButtonTypeCustom];
            gridBtn.tag = i;
            [self addSubview:gridBtn];
        }
    }
    return self;
}

- (void)setProducts:(NSArray *)products
{
    NSArray *randomProducts = [NSArray randomArrayWithArray:products];
    
    for (int i = 0; i < maxCount; i++) {
        YGGridButton *gridBtn = self.subviews[i];
        YGProduct *product = randomProducts[i];
        [gridBtn setTitle:product.productName forState:UIControlStateNormal];
        [gridBtn setImage:[UIImage imageNamed:@"placeh"] forState:UIControlStateNormal];
        gridBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat gridBtnW = (kScreenW - (maxCol + 1) *margin) / maxCol;
    CGFloat gridBtnH = gridBtnW + 30;
    for (int i = 0; i < maxCount; i++) {
        YGGridButton *gridBtn = self.subviews[i];
        [gridBtn addTarget:self action:@selector(clickGridBtn:) forControlEvents:UIControlEventTouchDown];
        int col = i % maxCol;
        int row = i / maxCol;
        CGFloat gridBtnX = margin + (margin + gridBtnW) * col;
        CGFloat gridBtnY = margin + (margin + gridBtnH) * row;
        gridBtn.frame = CGRectMake(gridBtnX, gridBtnY, gridBtnW, gridBtnH);
    }
}

- (CGFloat)gridHeight
{
    YGGridButton *lastGridBtn = [self.subviews lastObject];
    return CGRectGetMaxY(lastGridBtn.frame) + margin;
}

- (void)clickGridBtn:(YGGridButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(gridView:didClickGridBtn:)]) {
        [self.delegate gridView:self didClickGridBtn:btn];
    }
}
@end
