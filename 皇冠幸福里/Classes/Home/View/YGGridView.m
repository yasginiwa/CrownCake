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
#import "YGGridButton.h"

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
    NSArray *firstProducts = [products subarrayWithRange:NSMakeRange(0, gridMaxCount)];
    
    for (int i = 0; i < gridMaxCount; i++) {
        YGGridButton *gridBtn = self.subviews[i];
        YGProduct *product = firstProducts[i];
        [gridBtn setTitle:product.productName forState:UIControlStateNormal];
        [gridBtn setButtonImageWithUrl:product.productImg placeHolder:@"logo_banner_gray"];
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
    self.products;
    NSDictionary *userInfo = @{@"index" : @(btn.tag)};
    [[NSNotificationCenter defaultCenter] postNotificationName:YGGridBtnDidClickNote object:nil userInfo:userInfo];
}
@end
