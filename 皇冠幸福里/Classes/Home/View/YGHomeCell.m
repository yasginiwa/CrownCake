//
//  YGHomeCell.m
//  皇冠幸福里
//
//  Created by LiYugang on 2018/4/27.
//  Copyright © 2018年 LiYugang. All rights reserved.
//

#import "YGHomeCell.h"
#import "YGHomeFrame.h"
#import "XRCarouselView.h"
#import "YGBannerView.h"
#import "YGGridView.h"
#import "YGRowView.h"
#import "YGMapView.h"
#import "YGBottomBtn.h"
#import "YGHomeProduct.h"

@interface YGHomeCell ()
@property (nonatomic, weak) XRCarouselView *adsView;
@property (nonatomic, weak) YGBannerView *bannerView;
@property (nonatomic, weak) XRCarouselView *rollView;
@property (nonatomic, weak) YGGridView *gridView;
@property (nonatomic, weak) YGRowView *rowView;
@property (nonatomic, weak) YGBottomBtn *bottomBtn;
@property (nonatomic, weak) YGMapView *mapView;
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
        
        XRCarouselView *rollView = [[XRCarouselView alloc] init];
        [self.contentView addSubview:rollView];
        self.rollView = rollView;
        
        YGGridView *gridView = [[YGGridView alloc] init];
        [self.contentView addSubview:gridView];
        self.gridView = gridView;
        
        YGRowView *rowView = [[YGRowView alloc] init];
        [self.contentView addSubview:rollView];
        self.rowView = rowView;
        
        YGBottomBtn *bottomBtn = [YGBottomBtn buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:bottomBtn];
        self.bottomBtn = bottomBtn;
        
        YGMapView *mapView = [[YGMapView alloc] init];
        [self.contentView addSubview:mapView];
        self.mapView = mapView;
    }
    return self;
}

- (void)setHomeFrame:(YGHomeFrame *)homeFrame
{
    _homeFrame = homeFrame;
    
    [self setFrames];
    
    [self setData];
}

- (void)setFrames
{
    self.adsView.frame = self.homeFrame.adsFrame;
    
    self.bannerView.frame = self.homeFrame.bannerFrame;
    
    self.rollView.frame = self.homeFrame.rollFrame;
    
    self.gridView.frame = self.homeFrame.gridFrame;
    
    self.rowView.frame = self.homeFrame.rowFrame;
    
    self.bottomBtn.frame = self.homeFrame.bottomBtnFrame;
    
    self.mapView.frame = self.homeFrame.mapFrame;
}

- (void)setData
{
    YGHomeProduct *homeProduct = self.homeFrame.homeProduct;

    self.adsView.imageArray = homeProduct.adsImages;

    self.bannerView.textEn = homeProduct.bannerTextEn;
    self.bannerView.textChs = homeProduct.bannerTextChs;

    self.rollView.imageArray = homeProduct.rollImages;

    self.gridView.products = homeProduct.gridProducts;
    
    self.rowView.products = homeProduct.rowProducts;

    self.bottomBtn.image = homeProduct.bottomBtnImage;
    self.bottomBtn.text = homeProduct.bottomBtnText;
}
@end
