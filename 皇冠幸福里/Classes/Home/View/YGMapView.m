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
@property (nonatomic, strong) AMapLocationManager *locMgr;
@property (nonatomic, strong) AMapSearchAPI *mapSearch;
@property (nonatomic, strong) MAPointAnnotation *pointAnnotaiton;
@property (nonatomic, weak) MAMapView *AMapView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIImageView *nearbyView;
@property (nonatomic, weak) UILabel *nearbyLabel;
@property (nonatomic, weak) UILabel *addressLabel;
@end


@implementation YGMapView
#pragma mark - 懒加载
- (AMapLocationManager *)locMgr
{
    if (_locMgr == nil) {
        _locMgr = [[AMapLocationManager alloc] init];
        _locMgr.delegate = self;
        
        //设置不允许系统暂停定位
        [_locMgr setPausesLocationUpdatesAutomatically:NO];
        
        //设置允许在后台定位
        [_locMgr setAllowsBackgroundLocationUpdates:NO];
        
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

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        MAMapView *AMapView = [[MAMapView alloc] init];
        AMapView.delegate = self;
        [self addSubview:AMapView];
        self.AMapView = AMapView;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:18];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.backgroundColor = [UIColor orangeColor];
        titleLabel.layer.cornerRadius = 20;
        titleLabel.clipsToBounds = YES;
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UIImageView *nearbyView = [[UIImageView alloc] init];
        nearbyView.image = [UIImage imageNamed:@"site_icon"];
        [self addSubview:nearbyView];
        self.nearbyView = nearbyView;
        
        UILabel *nearbyLabel = [[UILabel alloc] init];
        nearbyLabel.font = [UIFont systemFontOfSize:15];
        nearbyLabel.textColor = [UIColor blackColor];
        nearbyLabel.textAlignment = NSTextAlignmentLeft;
        nearbyLabel.text = @"定位中...";
        [self addSubview:nearbyLabel];
        self.nearbyLabel = nearbyLabel;
        
        UILabel *addressLabel = [[UILabel alloc] init];
        addressLabel.font = [UIFont systemFontOfSize:13];
        addressLabel.textColor = [UIColor grayColor];
        addressLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:addressLabel];
        self.addressLabel = addressLabel;
        
        [self locationOnAMap];
    }
    return self;
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
        make.width.mas_equalTo(13);
        make.height.mas_equalTo(20);
    }];
    
    [self.nearbyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(28);
        make.right.equalTo(self);
        make.centerY.equalTo(self.nearbyView);
        make.height.mas_equalTo(20);
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nearbyLabel.mas_left);
        make.right.equalTo(self);
        make.top.equalTo(self).offset(75);
        make.height.equalTo(@(20));
    }];
    
    [self.AMapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(100);
        make.right.left.bottom.equalTo(self);
    }];
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
    self.AMapView.showsUserLocation = YES;
    self.AMapView.userTrackingMode = MAUserTrackingModeFollow;
}

/**
 * 搜索附近的皇冠蛋糕店
 */
- (void)seachNearbyShopOnAMap:(MAPointAnnotation *)annotation
{
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    
    request.location = [AMapGeoPoint locationWithLatitude:annotation.coordinate.latitude longitude:annotation.coordinate.longitude];
    NSLog(@"%f-%f", self.pointAnnotaiton.coordinate.latitude, self.pointAnnotaiton.coordinate.longitude);
    request.keywords = @"皇冠蛋糕";
    
    /* 按照距离排序. */
    request.sortrule            = 0;
    request.requireExtension    = YES;
    
    [self.mapSearch AMapPOIAroundSearch:request];
}

# pragma mark - POI搜索回调
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if (response.pois.count == 0)
    {
        return;
    }
    
    //解析response获取POI信息
    AMapPOI *shopPoi = [response.pois firstObject];
    self.nearbyLabel.text = shopPoi.name;
    self.addressLabel.text = [NSString stringWithFormat:@"%@%@%@", shopPoi.city, shopPoi.district, shopPoi.address];
    
    // 添加大头针标记
    MAPointAnnotation *nearbyAnno = [[MAPointAnnotation alloc] init];
    nearbyAnno.title = shopPoi.name;
    nearbyAnno.subtitle = [NSString stringWithFormat:@"%@%@%@", shopPoi.city, shopPoi.district, shopPoi.address];
    nearbyAnno.coordinate = CLLocationCoordinate2DMake(shopPoi.enterLocation.latitude, shopPoi.enterLocation.longitude);
    [self.AMapView addAnnotation:nearbyAnno];
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

//        [self.mapView addAnnotation:self.pointAnnotaiton];
    }

    [self.pointAnnotaiton setCoordinate:location.coordinate];

    [self.AMapView setCenterCoordinate:location.coordinate];
    [self.AMapView setZoomLevel:14.1 animated:NO];
    
    [self seachNearbyShopOnAMap:self.pointAnnotaiton];
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
        
        annotationView.canShowCallout   = YES;
        annotationView.animatesDrop     = NO;
        annotationView.draggable        = NO;
        annotationView.image            = [UIImage imageNamed:@"logo_anno"];
        
        return annotationView;
    }
    return nil;
}
@end
