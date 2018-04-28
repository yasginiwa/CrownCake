//
//  YGHomeFrame.m
//  皇冠幸福里
//
//  Created by LiYugang on 2018/4/24.
//  Copyright © 2018年 LiYugang. All rights reserved.
//

#import "YGHomeFrame.h"
#import "YGHomeProduct.h"

@implementation YGHomeFrame
- (void)setHomeProduct:(YGHomeProduct *)homeProduct
{
    _homeProduct = homeProduct;
    
    // 计算广告轮播的Frame
    if (homeProduct.adsImages.count) {
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
    if (homeProduct.bannerTextEn.length) {
        CGFloat bannerX = 0;
        CGFloat bannerY = CGRectGetMaxY(self.adsFrame) + kHomeCellMargin;
        CGFloat bannerW = kScreenW;
        CGFloat bannerH = 110;
        self.bannerFrame = CGRectMake(bannerX, bannerY, bannerW, bannerH);
    } else {
        self.bannerFrame = CGRectZero;
    }
    
    if (homeProduct.rollImages.count) {
        CGFloat rollX = 0;
        CGFloat rollY = CGRectGetMaxY(self.bannerFrame) + kHomeCellMargin;
        CGFloat rollW = kScreenW;
        CGFloat rollH = 200;
        self.rollFrame = CGRectMake(rollX, rollY, rollW, rollH);
    } else {
        self.rollFrame = CGRectZero;
    }
    
    // 计算网格产品展示的frame
    if (homeProduct.gridProducts.count) {
        CGFloat gridX = 0;
        CGFloat gridY = CGRectGetMaxY(self.bannerFrame);
        CGFloat gridW = kScreenW;
        CGFloat gridBtnW = (kScreenW - (gridMaxCol + 1) * gridRowMargin) / gridMaxCol;
        CGFloat gridBtnH = gridBtnW + gridColmargin;
        CGFloat gridH = (gridMaxCount / gridMaxCol) * (gridBtnH + gridRowMargin) + gridColmargin;
        self.gridFrame = CGRectMake(gridX, gridY, gridW, gridH);
    } else {
        self.gridFrame = CGRectZero;
    }
    
    // 计算横排产品展示的frame
    if (homeProduct.rowProducts.count) {
        CGFloat rowX = 0;
        CGFloat rowY = CGRectGetMaxY(self.gridFrame);
        CGFloat rowW = kScreenW;
        CGFloat rowH = 0;
        self.rowFrame = CGRectMake(rowX, rowY, rowW, rowH);
    } else {
        self.rowFrame = CGRectZero;
    }
    
    // 计算map 地图的frame
    if (homeProduct.hasMap) {
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
    if (homeProduct.bottomBtnImage.length) {
        CGFloat bottomBtnX = 0;
        CGFloat bottomBtnY;
        if (homeProduct.gridProducts.count) {
            bottomBtnY = CGRectGetMaxY(self.gridFrame);
        } else {
            bottomBtnY = CGRectGetMaxY(self.rowFrame);
        }
        CGFloat bottomBtnW = kScreenW;
        CGFloat bottomBtnH = 50;
        self.bottomBtnFrame = CGRectMake(bottomBtnX, bottomBtnY, bottomBtnW, bottomBtnH);
        self.cellHeight = CGRectGetMaxY(self.bottomBtnFrame);
    } else {
        self.bottomBtnFrame = CGRectZero;
    }
}
@end
