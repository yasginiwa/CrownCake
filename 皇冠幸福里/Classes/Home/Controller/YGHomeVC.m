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
#import "YGDBTool.h"

@interface YGHomeVC ()
@property (nonatomic, strong) NSMutableArray *homeFrames;
@property (nonatomic, weak) UIView *loadingView;
@end

@implementation YGHomeVC

#pragma mark - 懒加载
- (NSMutableArray *)homeFrames
{
    if (_homeFrames == nil) {
        _homeFrames = [NSMutableArray array];
    }
    return _homeFrames;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setAppearance];
    
    [self setTitleView];
    
    [self setloadingView];
    
    [self getHomeFrames];
    
//    [[YGHomeRequestTool sharedHomeRequest] startAllHomeRequest:^{
//        [self.loadingView removeFromSuperview];
//        self.homeFrames = [YGHomeRequestTool sharedHomeRequest].homeFrameArray;
//        [self.tableView reloadData];
//    }];
}

- (void)setAppearance
{
    self.tableView.backgroundColor = YGColorWithRGBA(240, 240, 240, 1.0);
    self.tableView.allowsSelection = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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

- (void)getHomeFrames
{
    self.homeFrames = [[YGDBTool sharedDBTool] getAllHomeFrame];

    if (self.homeFrames.count == 0) {
        [[YGHomeRequestTool sharedHomeRequest] startAllHomeRequest:^{
            self.homeFrames = [YGHomeRequestTool sharedHomeRequest].homeFrameArray;
            [self.loadingView removeFromSuperview];
            [self.tableView reloadData];
        }];
    }
    
    [self.loadingView removeFromSuperview];
    [self.tableView reloadData];
}

#pragma mark - 实现tableView dataSource Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.homeFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YGHomeCell *cell = [YGHomeCell cellWithTableView:tableView];
    cell.homeFrame = self.homeFrames[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YGHomeFrame *homeFrame = self.homeFrames[indexPath.row];
    return homeFrame.cellHeight;
}
@end
