//
//  YGHomeVC.m
//  皇冠幸福里
//
//  Created by LiYugang on 2018/4/24.
//  Copyright © 2018年 LiYugang. All rights reserved.
//

#import "YGHomeVC.h"
#import "YGHomeFrame.h"
#import "YGHomeRequestTool.h"
#import "YGProduct.h"
#import "YGHomeProduct.h"
#import "YGLoadingView.h"
#import "YGBannerView.h"
#import "YGHomeCell.h"

#define YGAdsroductRequestFinishNote @"YGAdsProductRequestFinishNote"
#define YGStarProductRequestFinishNote @"YGStarProductRequestFinishNote"

@interface YGHomeVC ()
@property (nonatomic, strong) NSArray *homeFrames;
@property (nonatomic, weak) UIView *loadingView;
@end

@implementation YGHomeVC

#pragma mark - 懒加载
- (NSArray *)homeFrames
{
    if (_homeFrames == nil) {
        _homeFrames = [NSMutableArray array];
    }
    return _homeFrames;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setTitleView];
    
    [self setloadingView];
    
    [[YGHomeRequestTool sharedHomeRequest] startAllHomeRequest:^{
        [self.loadingView removeFromSuperview];
        self.homeFrames = [YGHomeRequestTool sharedHomeRequest].homeFrameArray;
        [self.tableView reloadData];
    }];
}

- (void)setTitleView
{
    // 设置HomeVC的navigationBar
    UIImageView *titleView = [[UIImageView alloc] init];
    titleView.frame = CGRectMake(0, 0, 120, 38);
    titleView.image = [UIImage imageNamed:@"logo"];
    self.navigationItem.titleView = titleView;
}

- (void)setloadingView
{
    YGLoadingView *loadingView = [[YGLoadingView alloc] init];
    UIView *navView = self.navigationController.view;
    [navView addSubview:loadingView];
    loadingView.frame = navView.bounds;
    [self.navigationController.view insertSubview:loadingView atIndex:1];
    self.loadingView = loadingView;
}

#pragma mark - 实现tableView dataSource Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.homeFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YGHomeCell *cell = [YGHomeCell cellWithTableView:tableView];
    YGHomeFrame *homeFrame = self.homeFrames[indexPath.row];
    cell.homeFrame = homeFrame;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    YGHomeFrame *homeFrame = self.homeFrames[indexPath.row];
//    return homeFrame.cellHeight;
    return 600;
}
@end
