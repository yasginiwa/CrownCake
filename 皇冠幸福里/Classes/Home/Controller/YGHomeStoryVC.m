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
        YGRowView *rowView = [[YGRowView alloc] init];
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
}

- (void)setAppearance
{
    self.tableView.backgroundColor = YGColorWithRGBA(240, 240, 240, 1.0);
    self.tableView.allowsSelection = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.products.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 1000;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YGStoryCell *cell = [YGStoryCell cellWithTableView:tableView];
    cell.storyProducts = self.products[indexPath.row];
    return cell;
}
@end
