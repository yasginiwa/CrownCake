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
@property (nonatomic, assign) CGFloat gridHeight;
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
        rollView.pagePosition = PositionHide;
        [self.contentView addSubview:rollView];
        self.rollView = rollView;
        
        YGGridView *gridView = [[YGGridView alloc] init];
        [self.contentView addSubview:gridView];
        self.gridView = gridView;
        
        YGRowView *rowView = [[YGRowView alloc] init];
        [self.contentView addSubview:rowView];
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

- (void)setFrame:(CGRect)frame{
    frame.size.height -= 10;
    [super setFrame:frame];
}

- (void)setHomeFrame:(YGHomeFrame *)homeFrame
{
    _homeFrame = homeFrame;
    
    [self setFrame];
    
    [self setData];
}

- (void)setFrame
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

    if (homeProduct.adsImages.count) {
        self.adsView.hidden = NO;
        self.adsView.imageArray = homeProduct.adsImages;
    } else {
        self.adsView.hidden = YES;
    }

    if (homeProduct.bannerTextEn || homeProduct.bannerTextChs) {
        self.bannerView.hidden = NO;
        self.bannerView.textEn = homeProduct.bannerTextEn;
        self.bannerView.textChs = homeProduct.bannerTextChs;
    } else {
        self.bannerView.hidden = YES;
    }

    if (homeProduct.rollImages.count) {
        self.rollView.hidden = NO;
        self.rollView.imageArray = homeProduct.rollImages;
    } else {
        self.rollView.hidden = YES;
    }

    if (homeProduct.gridProducts.count) {
        self.gridView.hidden = NO;
        self.gridView.products = homeProduct.gridProducts;
    } else {
        self.gridView.hidden = YES;
    }

    if (homeProduct.rowProducts.count) {
        self.rowView.hidden = NO;
        self.rowView.products = homeProduct.rowProducts;
    } else {
        self.rowView.hidden = YES;
    }
    
    if (homeProduct.mapTitle.length) {
        self.mapView.hidden = NO;
        self.mapView.mapTitle = homeProduct.mapTitle;
    } else {
        self.mapView.hidden = YES;
    }
    
    if (homeProduct.bottomBtnText.length) {
        self.bottomBtn.hidden = NO;
        self.bottomBtn.text = homeProduct.bottomBtnText;
        
    } else if (homeProduct.bottomBtnImage.length){
        self.bottomBtn.image = homeProduct.bottomBtnImage;
        
    } else {
        self.bottomBtn.hidden = YES;
    }
}
@end
