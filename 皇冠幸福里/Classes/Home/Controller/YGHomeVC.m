//
//  YGHomeVC.m
//  皇冠幸福里
//
//  Created by LiYugang on 2018/4/24.
//  Copyright © 2018年 LiYugang. All rights reserved.
//

#import "YGHomeVC.h"
#import "YGHomeCell.h"
#import "YGHomeFrame.h"
#import "YGProductsRequest.h"
#import "YGProduct.h"
#import "YGHomeProduct.h"
#import "YGLoadingView.h"

#define YGStarProductRequestFinishNote @"YGStarProductRequestFinishNote"

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
    
    [self setTitleView];
    
    [self buildHomeFrames];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setLoadingView];
    
    [self addObserver];
}

- (void)setTitleView
{
    // 设置HomeVC的navigationBar
    UIImageView *titleView = [[UIImageView alloc] init];
    titleView.frame = CGRectMake(0, 0, 120, 38);
    titleView.image = [UIImage imageNamed:@"logo"];
    self.navigationItem.titleView = titleView;
}

- (void)setLoadingView
{
    YGLoadingView *loadingView = [[YGLoadingView alloc] init];
    [self.view addSubview:loadingView];
    self.loadingView.frame = self.view.bounds;
    NSLog(@"%@", NSStringFromCGRect(loadingView.frame));
}

- (void)addObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeLoadingView:) name:YGStarProductRequestFinishNote object:nil];
}

- (void)removeLoadingView:(NSNotification *)note
{
    [self.loadingView removeFromSuperview];
    YGHomeFrame *starFrame = note.userInfo[@"starProduct"];
    [self.homeFrames addObject:starFrame];
    [self.tableView reloadData];
}

- (void)buildHomeFrames
{
    YGHomeFrame *homeFrame = [[YGHomeFrame alloc] init];
    YGHomeProduct *starProduct = [[YGHomeProduct alloc] init];
    
    NSDictionary *starParam = @{@"groupId" : @"1"};
    [YGProductsRequest getProductWithParams:starParam success:^(id result) {
        NSArray *adsProducts = [YGProduct mj_objectArrayWithKeyValuesArray:result];
        NSMutableArray *adsImages = [NSMutableArray array];
        for (YGProduct *product in adsProducts) {
            [adsImages addObject:product.productImg];
        }
        starProduct.adsImages = adsImages;
        homeFrame.homeProduct = starProduct;
        NSDictionary *userInfo = @{@"starProduct" : homeFrame};
        [[NSNotificationCenter defaultCenter] postNotificationName:YGStarProductRequestFinishNote object:nil userInfo:userInfo];
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}


#pragma mark - Table view data source, delegate
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
