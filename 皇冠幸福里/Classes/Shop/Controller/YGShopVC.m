//
//  YGShopVC.m
//  皇冠幸福里
//
//  Created by LiYugang on 2018/4/24.
//  Copyright © 2018年 LiYugang. All rights reserved.
//

#import "YGShopVC.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

@interface YGShopVC () <AMapLocationManagerDelegate, MAMapViewDelegate, AMapSearchDelegate>
@property (nonatomic, strong) AMapLocationManager *locMgr;
@property (nonatomic, strong) AMapSearchAPI *mapSearch;
@property (nonatomic, strong) MAPointAnnotation *pointAnnotaiton;
@property (nonatomic, weak) MAMapView *AMapView;
@end

@implementation YGShopVC

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

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupAppearance];
}

- (void)setupAppearance
{
    self.navigationItem.title = @"附近门店";
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setImage:[UIImage imageNamed:@"icon_search_store"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchShop) forControlEvents:UIControlEventTouchUpInside];
    [searchBtn sizeToFit];
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    self.navigationItem.rightBarButtonItems = @[searchItem];
}

- (void)setupAMapView
{
    MAMapView *AMapView = [[MAMapView alloc] init];
    AMapView.scrollEnabled = NO;
    AMapView.delegate = self;
    [self.view addSubview:AMapView];
    self.AMapView = AMapView;
}

- (void)setupShopListView
{
    UITableView *shopListView = [[UITableView alloc] init];
}

- (void)searchShop
{
    NSLog(@"-searchClick--");
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self.AMapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.equalTo(self.view).multipliedBy(0.5);
    }];
}
@end
