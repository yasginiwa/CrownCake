//
//  YGMapView.m
//  皇冠幸福里
//
//  Created by LiYugang on 2018/4/24.
//  Copyright © 2018年 LiYugang. All rights reserved.
//

#import "YGMapView.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

@interface YGMapView () <AMapLocationManagerDelegate, MAMapViewDelegate, AMapSearchDelegate>
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapLocationManager *locMgr;
@property (nonatomic, strong) AMapSearchAPI *mapSearch;
@property (nonatomic, strong) MAPointAnnotation *pointAnnotaiton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *nearbyView;
@property (nonatomic, strong) UILabel *nearbyLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@end


@implementation YGMapView
#pragma mark - 懒加载
- (MAMapView *)mapView
{
    if (_mapView == nil) {
        _mapView = [[MAMapView alloc] init];
        _mapView.delegate = self;
        [self addSubview:_mapView];
    }
    return _mapView;
}

- (AMapLocationManager *)locMgr
{
    if (_locMgr == nil) {
        _locMgr = [[AMapLocationManager alloc] init];
        _locMgr.delegate = self;
        
        //设置不允许系统暂停定位
        [_locMgr setPausesLocationUpdatesAutomatically:NO];
        
        //设置允许在后台定位
        [_locMgr setAllowsBackgroundLocationUpdates:YES];
        
        //设置允许连续定位逆地理
        [_locMgr setLocatingWithReGeocode:YES];
        
        [_locMgr setDesiredAccuracy:kCLLocationAccuracyBestForNavigation];
    }
    return _locMgr;
}

- (AMapSearchAPI *)mapSearch
{
    if (_mapSearch == nil) {
        _mapSearch = [[AMapSearchAPI alloc] init];
        _mapSearch.delegate = self;
    }
    return _mapSearch;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.backgroundColor = [UIColor orangeColor];
        _titleLabel.layer.cornerRadius = 20;
        _titleLabel.clipsToBounds = YES;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UIImageView *)nearbyView
{
    if (_nearbyView == nil) {
        _nearbyView = [[UIImageView alloc] init];
        _nearbyView.image = [UIImage imageNamed:@"site_icon"];
        [self addSubview:_nearbyView];
    }
    return _nearbyView;
}

- (UILabel *)nearbyLabel
{
    if (_nearbyLabel == nil) {
        _nearbyLabel = [[UILabel alloc] init];
        _nearbyLabel.font = [UIFont systemFontOfSize:16];
        _nearbyLabel.textColor = [UIColor blackColor];
        _nearbyLabel.textAlignment = NSTextAlignmentLeft;
        _nearbyLabel.text = @"xxxasdasd";
        [self addSubview:_nearbyLabel];
    }
    return _nearbyLabel;
}

- (UILabel *)addressLabel
{
    if (_addressLabel == nil) {
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.font = [UIFont systemFontOfSize:15];
        _addressLabel.textColor = [UIColor grayColor];
        _addressLabel.textAlignment = NSTextAlignmentLeft;
        _addressLabel.text = @"xxx";
        [self addSubview:_addressLabel];
    }
    return _addressLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self locationOnAMap];
        [self seachNearbyShopOnAMap];
    }
    return self;
}

- (void)setMapTitle:(NSString *)mapTitle
{
    _mapTitle = mapTitle;
    self.titleLabel.text = mapTitle;
}

/**
 * 开始定位
 */
- (void)locationOnAMap
{
    [self.locMgr startUpdatingLocation];
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
}

/**
 * 搜索附近的皇冠蛋糕店
 */
- (void)seachNearbyShopOnAMap
{
    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
    
    request.keywords            = @"皇冠蛋糕";
    request.city                = @"武汉";
    request.types               = @"糕饼店";
    request.requireExtension    = YES;
    
    /*  搜索SDK 3.2.0 中新增加的功能，只搜索本城市的POI。*/
    request.cityLimit           = YES;
    request.requireSubPOIs      = YES;
    
    [self.mapSearch AMapPOIKeywordsSearch:request];
}

# pragma mark - POI搜索回调
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if (response.pois.count == 0)
    {
        return;
    }
    
    //解析response获取POI信息，具体解析见 Demo
//    NSLog(@"%@", response.pois);
//    for (AMapPOI *poi in response.pois) {
//        NSMutableArray *poiArray = [NSMutableArray array];
//        [poiArray addObject:poi];
//        NSLog(@"%d", poiArray.count);
//    }

    AMapPOI *shopPoi = [response.pois firstObject];
    self.nearbyLabel.text = shopPoi.name;
    self.addressLabel.text = shopPoi.address;
        NSLog(@"%@", response.pois);
}

#pragma mark - AMapLocationManager Delegate

- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%s, amapLocationManager = %@, error = %@", __func__, [manager class], error);
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode
{
    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f; reGeocode:%@}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy, reGeocode.formattedAddress);
    
    //获取到定位信息，更新annotation
    if (self.pointAnnotaiton == nil)
    {
        self.pointAnnotaiton = [[MAPointAnnotation alloc] init];
        [self.pointAnnotaiton setCoordinate:location.coordinate];
        
        [self.mapView addAnnotation:self.pointAnnotaiton];
    }
    
    [self.pointAnnotaiton setCoordinate:location.coordinate];
    
    [self.mapView setCenterCoordinate:location.coordinate];
    [self.mapView setZoomLevel:15.1 animated:NO];
}

#pragma mark - MAMapView Delegate

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        
        MAPinAnnotationView *annotationView = (MAPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
        }
        
        annotationView.canShowCallout   = NO;
        annotationView.animatesDrop     = NO;
        annotationView.draggable        = NO;
        annotationView.image            = [UIImage imageNamed:@"icon_location.png"];
        
        return annotationView;
    }
    return nil;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(-20);
        make.top.equalTo(self).offset(10);
        make.width.equalTo(@(130));
        make.height.equalTo(@(40));
    }];
    
    [self.nearbyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self).offset(55);
        make.width.equalTo(@(13));
        make.height.equalTo(@(20));
    }];
    
    [self.nearbyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nearbyView.mas_right).offset(10);
        make.right.equalTo(self);
        make.centerY.equalTo(self.nearbyView);
        make.height.equalTo(@(20));
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nearbyLabel.mas_left);
        make.right.equalTo(self);
        make.top.equalTo(self).offset(75);
        make.height.equalTo(@(20));
    }];
    
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(100);
        make.right.left.bottom.equalTo(self);
    }];
}

@end
