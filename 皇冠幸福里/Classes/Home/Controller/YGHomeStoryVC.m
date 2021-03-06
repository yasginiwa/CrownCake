//
//  YGHomeStoryVC.m
//  皇冠幸福里
//
//  Created by LiYugang on 2018/5/10.
//  Copyright © 2018年 LiYugang. All rights reserved.
//

#import "YGHomeStoryVC.h"
#import "YGLoadingView.h"
#import "MJRefresh.h"
#import "YGRowView.h"
#import "YGHomeProduct.h"
#import "YGHomeFrame.h"
#import "YGWebVC.h"
#import "YGProduct.h"
#import "YGMainNavVC.h"

@interface YGStoryCell : UITableViewCell
@property (nonatomic, weak) YGRowView *rowView;
@property (nonatomic, strong) NSArray *storyProducts;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end

@implementation YGStoryCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"story";
    YGStoryCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[YGStoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        YGRowView *rowView = [[YGRowView alloc] initWithType:rowTypeDetail];
        rowView.frame = CGRectMake(0, 0, kScreenW, 1050);
        [self.contentView addSubview:rowView];
        self.rowView = rowView;
    }
    return self;
}

- (void)setStoryProducts:(NSArray *)storyProducts
{
    _storyProducts = storyProducts;
    self.rowView.products = storyProducts;
}

@end

@interface YGHomeStoryVC ()

@end

@implementation YGHomeStoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setAppearance];
    
    [self addNote];
}

- (void)addNote
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiceRowViewClick:) name:YGRowDetailBtnDidClickNote object:nil];
}

- (void)setAppearance
{
    self.tableView.allowsSelection = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.navigationItem.title = @"皇冠故事";
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"back_icon"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
}

- (void)receiceRowViewClick:(NSNotification *)note
{
    NSDictionary *userInfo = note.userInfo;
    NSUInteger index = [userInfo[@"index"] integerValue];
    YGProduct *storyProduct = self.products[0][index];
    YGWebVC *webVc = [[YGWebVC alloc] init];
    webVc.url = storyProduct.productDes;
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - tableViewDelegate dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.products.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 1050;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YGStoryCell *cell = [YGStoryCell cellWithTableView:tableView];
    cell.storyProducts = self.products[indexPath.row];
    return cell;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
