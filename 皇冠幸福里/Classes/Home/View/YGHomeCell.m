//
//  YGHomeCell.m
//  皇冠幸福里
//
//  Created by LiYugang on 2018/4/24.
//  Copyright © 2018年 LiYugang. All rights reserved.
//

#import "YGHomeCell.h"
#import "YGHomeFrame.h"
#import "YGBannerView.h"
#import "YGGridView.h"
#import "YGRowView.h"
#import "YGMapView.h"
#import "YGBottomBtn.h"
#import "XRCarouselView.h"
#import "YGHomeProduct.h"

@interface YGHomeCell ()
@property (nonatomic, weak) XRCarouselView *adsView;
@property (nonatomic, weak) YGBannerView *bannerView;
@property (nonatomic, weak) YGGridView *gridView;
@property (nonatomic, weak) YGRowView *rowView;
@property (nonatomic, weak) YGMapView *mapView;
@property (nonatomic, weak) YGBottomBtn *bottomBtn;
@end

@implementation YGHomeCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"home";
    YGHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[YGHomeCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        XRCarouselView *adsView = [[XRCarouselView alloc] init];
        [self.contentView addSubview:adsView];
        self.adsView = adsView;
        
        YGBannerView *bannerView = [[YGBannerView alloc] init];
        [self.contentView addSubview:bannerView];
        self.bannerView = bannerView;
        
        YGGridView *gridView = [[YGGridView alloc] init];
        [self.contentView addSubview:gridView];
        self.gridView = gridView;
        
        YGRowView *rowView = [[YGRowView alloc] init];
        [self.contentView addSubview:rowView];
        self.rowView = rowView;
        
        YGMapView *mapView = [[YGMapView alloc] init];
        [self.contentView addSubview:mapView];
        self.mapView = mapView;
        
        YGBottomBtn *bottomBtn = [YGBottomBtn buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:bottomBtn];
        self.bottomBtn = bottomBtn;
    }
    return self;
}

- (void)setHomeFrame:(YGHomeFrame *)homeFrame
{
    _homeFrame = homeFrame;
    
    [self setData];
    
    [self setHomeFrame];
}

- (void)setData
{
    YGHomeProduct *homeProduct = self.homeFrame.homeProduct;
    
    if (homeProduct.adsImages.count) {
        self.adsView.imageArray = homeProduct.adsImages;
    }
    
    if (homeProduct.bannerTitleEn.length) {
        self.bannerView.titleTextEn = homeProduct.bannerTitleEn;
        self.bannerView.titleTextChs = homeProduct.bannerTitleChs;
    }
    
    if (homeProduct.gridProducts.count) {
        self.gridView.products = homeProduct.gridProducts;
    }
    
    if (homeProduct.rowProducts.count) {
        self.rowView.products = homeProduct.rowProducts;
    }
    
    if (homeProduct.hasMap) {
        self.mapView = nil;
    }
    
    if (homeProduct.bottomBtnImage.length) {
        [self.bottomBtn setImage:[UIImage imageNamed:homeProduct.bottomBtnImage] forState:UIControlStateNormal];
    }
    
}

- (void)setHomeFrame
{
    self.adsView.frame = self.homeFrame.adsFrame;
    self.bannerView.frame = self.homeFrame.bannerFrame;
    self.gridView.frame = self.homeFrame.gridFrame;
    self.rowView.frame = self.homeFrame.rowFrame;
    self.mapView.frame = self.homeFrame.mapFrame;
    self.bottomBtn.frame = self.homeFrame.bottomBtnFrame;
}
@end
