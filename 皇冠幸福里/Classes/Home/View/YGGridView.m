//
//  YGGridView.m
//  CASAMIEL
//
//  Created by YGLEE on 2018/4/19.
//  Copyright © 2018年 YGLEE. All rights reserved.
//

#import "YGGridView.h"
#import "YGProduct.h"
#import "YGHomeFrame.h"

@interface YGGridButton : UIButton

@end

@implementation YGGridButton
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = imageW * 0.92;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleY = CGRectGetMaxY(self.imageView.frame);
    CGFloat titleW = self.width;
    CGFloat titleH = self.height - self.imageView.height + 20;
    return CGRectMake(titleX, titleY, titleW, titleH);
}
@end



@implementation YGGridView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        for (int i = 0; i < gridMaxCount; i++) {
            YGGridButton *gridBtn = [YGGridButton buttonWithType:UIButtonTypeCustom];
            gridBtn.tag = i;
            [self addSubview:gridBtn];
        }
    }
    return self;
}

- (void)setProducts:(NSArray *)products
{
    _products = products;
    NSArray *randomProducts = [NSArray randomArrayWithArray:products];
    
    for (int i = 0; i < gridMaxCount; i++) {
        YGGridButton *gridBtn = self.subviews[i];
        YGProduct *product = randomProducts[i];
        [gridBtn setTitle:product.productName forState:UIControlStateNormal];
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:product.productImg]]];
        [gridBtn setImage:image forState:UIControlStateNormal];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat gridBtnW = (kScreenW - (gridMaxCol + 1) * gridColmargin) / gridMaxCol;
    CGFloat gridBtnH = gridBtnW + gridColmargin;
    for (int i = 0; i < gridMaxCount; i++) {
        YGGridButton *gridBtn = self.subviews[i];
        [gridBtn addTarget:self action:@selector(clickGridBtn:) forControlEvents:UIControlEventTouchDown];
        int col = i % gridMaxCol;
        int row = i / gridMaxCol;
        CGFloat gridBtnY;
        if (row == 0) {
            gridBtnY = gridRowMargin + (gridColmargin + gridBtnH) * row;
        } else {
            gridBtnY = gridColmargin + (gridColmargin + gridBtnH) * row;
        }
        CGFloat gridBtnX = gridColmargin + (gridColmargin + gridBtnW) * col;
        gridBtn.frame = CGRectMake(gridBtnX, gridBtnY, gridBtnW, gridBtnH);
    }
}

- (void)clickGridBtn:(YGGridButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(gridView:didClickGridBtn:)]) {
        [self.delegate gridView:self didClickGridBtn:btn];
    }
}
@end
