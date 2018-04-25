//
//  YGHomeFrame.m
//  皇冠幸福里
//
//  Created by LiYugang on 2018/4/24.
//  Copyright © 2018年 LiYugang. All rights reserved.
//

#import "YGHomeFrame.h"
#import "YGHomeProduct.h"
#import "YGGridView.h"
#import "YGRowView.h"

@implementation YGHomeFrame
- (void)setHomeProduct:(YGHomeProduct *)homeProduct
{
    _homeProduct = homeProduct;
    
    // 计算广告轮播的Frame
    if (self.homeProduct.adsImages.count) {
        CGFloat adsX = 0;
        CGFloat adsY = 0;
        CGFloat adsW = kScreenW;
        CGFloat adsH = 200;
        self.adsFrame = CGRectMake(adsX, adsY, adsW, adsH);
        self.cellHeight = CGRectGetMaxY(self.adsFrame);
    } else {
        self.adsFrame = CGRectZero;
    }
    
    // 计算banner的Frame
    if (self.homeProduct.bannerTitleEn.length) {
        CGFloat bannerX = 0;
        CGFloat bannerY = CGRectGetMaxY(self.adsFrame);
        CGFloat bannerW = kScreenW;
        CGFloat bannerH = 100;
        self.bannerFrame = CGRectMake(bannerX, bannerY, bannerW, bannerH);
    } else {
        self.bannerFrame = CGRectZero;
    }
    
    // 计算网格产品展示的frame
    if (self.homeProduct.gridProducts.count) {
        CGFloat gridX = 0;
        CGFloat gridY = CGRectGetMaxY(self.bannerFrame);
        CGFloat gridW = kScreenW;
        CGFloat gridH = 500;
        self.gridFrame = CGRectMake(gridX, gridY, gridW, gridH);
    } else {
        self.gridFrame = CGRectZero;
    }
    
    // 计算横排产品展示的frame
    if (self.homeProduct.rowProducts.count) {
        CGFloat rowX = 0;
        CGFloat rowY = CGRectGetMaxY(self.gridFrame);
        CGFloat rowW = kScreenW;
        CGFloat rowH = 500;
        self.rowFrame = CGRectMake(rowX, rowY, rowW, rowH);
    } else {
        self.rowFrame = CGRectZero;
    }
    
    // 计算map 地图的frame
    if (self.homeProduct.hasMap) {
        CGFloat mapX = 0;
        CGFloat mapY = CGRectGetMaxY(self.rowFrame);
        CGFloat mapW = kScreenW;
        CGFloat mapH = 300;
        self.mapFrame = CGRectMake(mapX, mapY, mapW, mapH);
        self.cellHeight = CGRectGetMaxY(self.mapFrame);
    } else {
        self.mapFrame = CGRectZero;
    }
    
    // 计算底部按钮的frame
    if (self.homeProduct.bottomBtnImage.length) {
        CGFloat bottomBtnX = 0;
        CGFloat bottomBtnY = CGRectGetMaxY(self.mapFrame);
        CGFloat bottomBtnW = kScreenW;
        CGFloat bottomBtnH = 50;
        self.bottomBtnFrame = CGRectMake(bottomBtnX, bottomBtnY, bottomBtnW, bottomBtnH);
        self.cellHeight = CGRectGetMaxY(self.bottomBtnFrame);
    } else {
        self.bottomBtnFrame = CGRectZero;
    }
}
@end
