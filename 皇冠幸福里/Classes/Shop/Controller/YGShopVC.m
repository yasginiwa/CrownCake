//
//  YGShopVC.m
//  皇冠幸福里
//
//  Created by LiYugang on 2018/4/24.
//  Copyright © 2018年 LiYugang. All rights reserved.
//

#import "YGShopVC.h"
#import "YGShopCell.h"
#import "YGShopMapView.h"

@interface YGShopVC () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) YGShopMapView *shopMapView;
@property (nonatomic, weak) UITableView *shopListView;
@property (nonatomic, strong) NSMutableArray *shops;
@end

@implementation YGShopVC

#pragma mark - 懒加载
- (NSMutableArray *)shops
{
    if (_shops == nil) {
        _shops = [NSMutableArray array];
    }
    return _shops;
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupAppearance];
    
    [self setupShopMap];
    
    [self setupShopListView];
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

- (void)setupShopMap
{
    YGShopMapView *shopMapView = [[YGShopMapView alloc] init];
    [self.view addSubview:shopMapView];
    [self.shops addObjectsFromArray:shopMapView.shops];
    self.shopMapView = shopMapView;
}

- (void)setupShopListView
{
    UITableView *shopListView = [[UITableView alloc] init];
    shopListView.delegate = self;
    [self.view addSubview:shopListView];
    self.shopListView = shopListView;
}

- (void)searchShop
{
    NSLog(@"-searchClick--");
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self.shopMapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.equalTo(self.view).multipliedBy(0.5);
    }];
    
    [self.shopListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.shopMapView.mas_bottom);
    }];
}

#pragma mark - UITableViewDelegate UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.shops.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YGShopCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"YGShopCell" owner:nil options:nil] lastObject];
    cell.shop = self.shops[indexPath.row];
    return cell;
}
@end
