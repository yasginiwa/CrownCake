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
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
//        self.titleLabel.backgroundColor = [UIColor redColor];
//        self.backgroundColor = [UIColor blueColor];
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

#define maxCol 2
#define maxCount 4
#define margin 20

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
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:product.productImg]]];
        [gridBtn setImage:image forState:UIControlStateNormal];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat gridBtnW = (kScreenW - (maxCol + 1) *margin) / maxCol;
    CGFloat gridBtnH = gridBtnW;
    for (int i = 0; i < maxCount; i++) {
        YGGridButton *gridBtn = self.subviews[i];
        [gridBtn addTarget:self action:@selector(clickGridBtn:) forControlEvents:UIControlEventTouchDown];
        int col = i % maxCol;
        int row = i / maxCol;
        CGFloat gridBtnX = margin + (margin + gridBtnW) * col;
        CGFloat gridBtnY = margin + (margin + gridBtnH) * row;
        gridBtn.frame = CGRectMake(gridBtnX, gridBtnY, gridBtnW, gridBtnH);
        NSLog(@"%@", NSStringFromCGRect(gridBtn.frame));
    }
    YGGridButton *lastBtn = [self.subviews lastObject];
    self.viewHeight = CGRectGetMaxY(lastBtn.frame);
}

- (void)clickGridBtn:(YGGridButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(gridView:didClickGridBtn:)]) {
        [self.delegate gridView:self didClickGridBtn:btn];
    }
}
@end
