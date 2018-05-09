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
#import "MJRefresh.h"
#import "YGMainNavVC.h"
#import "YGMainWebVC.h"

@interface YGHomeVC ()<UIScrollViewDelegate>
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
    
    [self getHomeFrames];
    
    [self setloadingView];
    
    [self addRefreshHeader];
    
    [self addNote];
}

- (void)addRefreshHeader
{
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
}



- (void)loadNewData
{
    [self setloadingView];
    
    [self getHomeFrames];
}

- (void)setAppearance
{
    self.tableView.backgroundColor = YGColorWithRGBA(240, 240, 240, 1.0);
    self.tableView.allowsSelection = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
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
    [self.tableView addSubview:loadingView];
    loadingView.frame = self.tableView.bounds;
    [self.tableView bringSubviewToFront:loadingView];
    self.loadingView = loadingView;
}

- (void)getHomeFrames
{
//    self.homeFrames = [[YGDBTool sharedDBTool] getAllHomeFrame];
    [self.homeFrames removeAllObjects];
    [[YGHomeRequestTool sharedHomeRequest] startAllHomeRequest:^{
        self.homeFrames = [YGHomeRequestTool sharedHomeRequest].homeFrameArray;
        [self.loadingView removeFromSuperview];
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    }];
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

#pragma mark - 接收通知处理
- (void)addNote
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveGridBtnClick:) name:YGGridBtnDidClickNote object:nil];
}

- (void)receiveGridBtnClick:(NSNotification *)note
{
    NSDictionary *userInfo = note.userInfo;
    YGProduct *product = userInfo[@"currentStarProduct"];
    YGMainWebVC *webVc = [[YGMainWebVC alloc] init];
    webVc.title = product.productName;
    webVc.url = product.productDes;
    [self.navigationController pushViewController:webVc animated:YES];
}
@end
