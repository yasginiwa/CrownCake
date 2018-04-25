//
//  YGHomeVC.m
//  皇冠幸福里
//
//  Created by LiYugang on 2018/4/24.
//  Copyright © 2018年 LiYugang. All rights reserved.
//

#import "YGHomeVC.h"
#import "YGHomeFrame.h"
#import "YGProductsRequest.h"
#import "YGProduct.h"
#import "YGHomeProduct.h"
#import "YGLoadingView.h"
#import "YGBannerView.h"

#define YGAdsroductRequestFinishNote @"YGAdsProductRequestFinishNote"
#define YGStarProductRequestFinishNote @"YGStarProductRequestFinishNote"

@interface YGHomeVC ()
@property (nonatomic, weak) UIView *loadingView;
@end

@implementation YGHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setTitleView];
//
//    [self buildHomeFrames];
    YGBannerView *bannerView = [[YGBannerView alloc] init];
    bannerView.textEn = @"Star Product";
    bannerView.textChs = @"明星产品";
    bannerView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:bannerView];
    
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//
//    [self setLoadingView];
//
//    [self addObserver];
//}

- (void)setTitleView
{
    // 设置HomeVC的navigationBar
    UIImageView *titleView = [[UIImageView alloc] init];
    titleView.frame = CGRectMake(0, 0, 120, 38);
    titleView.image = [UIImage imageNamed:@"logo"];
    self.navigationItem.titleView = titleView;
}
//
//- (void)setLoadingView
//{
//    YGLoadingView *loadingView = [[YGLoadingView alloc] init];
//    loadingView.frame = CGRectMake(0, 0, kScreenW, kScreenH);
//    [self.navigationController.view addSubview:loadingView];
//    [self.navigationController.view insertSubview:loadingView atIndex:1];
//    self.loadingView = loadingView;
//}
//
//- (void)addObserver
//{
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(adsRemoveLoadingView:) name:YGAdsroductRequestFinishNote object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(starRemoveLoadingView:) name:YGStarProductRequestFinishNote object:nil];
//}
//
//- (void)adsRemoveLoadingView:(NSNotification *)note
//{
//    [self.loadingView removeFromSuperview];
//    YGHomeFrame *adsFrame = note.userInfo[@"adsProduct"];
//    [self.homeFrames addObject:adsFrame];
//    [self.tableView reloadData];
//}
//
//- (void)starRemoveLoadingView:(NSNotification *)note
//{
//    [self.loadingView removeFromSuperview];
//    NSArray *starProducts = note.userInfo[@"starProducts"];
//    YGHomeFrame *starFrame = [[YGHomeFrame alloc] init];
//    YGHomeProduct *starHomeProduct = [[YGHomeProduct alloc] init];
//    starHomeProduct.gridProducts = starProducts;
//    starHomeProduct.bannerTitleEn = @"Star Product";
//    starHomeProduct.bannerTitleChs = @"明星产品";
//    starHomeProduct.bottomBtnImage = @"换一换";
//    starFrame.homeProduct = starHomeProduct;
//    [self.homeFrames addObject:starFrame];
//    [self.tableView reloadData];
//}

//- (void)buildHomeFrames
//{
//    YGHomeFrame *homeFrame = [[YGHomeFrame alloc] init];
//    YGHomeProduct *adsProduct = [[YGHomeProduct alloc] init];
//
//    // ads cell
//    NSDictionary *adsParam = @{@"groupId" : @"1"};
//    [YGProductsRequest getProductWithParams:adsParam success:^(id result) {
//        NSArray *adsProducts = [YGProduct mj_objectArrayWithKeyValuesArray:result];
//        NSMutableArray *adsImages = [NSMutableArray array];
//        for (YGProduct *product in adsProducts) {
//            [adsImages addObject:product.productImg];
//        }
//        adsProduct.adsImages = adsImages;
//        homeFrame.homeProduct = adsProduct;
//        NSDictionary *userInfo = @{@"adsProduct" : homeFrame};
//        [[NSNotificationCenter defaultCenter] postNotificationName:YGAdsroductRequestFinishNote object:nil userInfo:userInfo];
//    } failure:^(NSError *error) {
//        NSLog(@"%@", error);
//    }];
//
//    // star cell
//    NSDictionary *starParam = @{@"groupId" : @"3"};
//    [YGProductsRequest getProductWithParams:starParam success:^(id result) {
//        NSArray *starProducts = [YGProduct mj_objectArrayWithKeyValuesArray:result];
//        NSDictionary *userInfo = @{@"starProducts" : starProducts};
//        [[NSNotificationCenter defaultCenter] postNotificationName:YGStarProductRequestFinishNote object:nil userInfo:userInfo];
//    } failure:^(NSError *error) {
//        NSLog(@"%@", error);
//    }];
//}


#pragma mark - Table view data source, delegate
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return self.homeFrames.count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    YGHomeFrame *homeFrame = self.homeFrames[indexPath.row];
//    return homeFrame.cellHeight;
//}

@end
