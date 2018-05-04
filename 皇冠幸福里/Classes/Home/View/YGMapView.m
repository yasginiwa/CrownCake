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

@interface YGMapView () <AMapLocationManagerDelegate, MAMapViewDelegate>
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapLocationManager *locMgr;
@property (nonatomic, strong) MAPointAnnotation *pointAnnotaiton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *nearestShopBtn;
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

- (UIButton *)nearestShopBtn
{
    if (_nearestShopBtn == nil) {
        _nearestShopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nearestShopBtn setImage:[UIImage imageNamed:@"site_icon"] forState:UIControlStateNormal];
    }
    return _nearestShopBtn;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.locMgr startUpdatingLocation];
        self.mapView.showsUserLocation = YES;
        self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    }
    return self;
}

- (void)setMapTitle:(NSString *)mapTitle
{
    _mapTitle = mapTitle;
    self.titleLabel.text = mapTitle;
}

//- (void)getCurrentLocation
//{
//    //获取一次用户的当前位置，方便添加地理围栏
//    __weak typeof(self) weakSelf = self;
//    [self.locMgr requestLocationWithReGeocode:NO completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
//        [weakSelf addCircleReionForCoordinate:location.coordinate];
//    }];
//}

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
        make.top.equalTo(self).offset(30);
        make.width.equalTo(@(130));
        make.height.equalTo(@(40));
    }];
    
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(120);
        make.right.left.bottom.equalTo(self);
    }];
}

@end
