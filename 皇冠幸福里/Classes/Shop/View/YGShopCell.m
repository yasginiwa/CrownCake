//
//  YGShopCell.m
//  皇冠幸福里
//
//  Created by LiYugang on 2018/5/17.
//  Copyright © 2018年 LiYugang. All rights reserved.
//

#import "YGShopCell.h"

@interface YGShopCell ()
// 店铺名称
@property (nonatomic, strong) UILabel *nameLabel;
// 店铺地址
@property (nonatomic, strong) UILabel *addressLabel;
// 到店铺距离
@property (nonatomic, strong) UIButton *distanceBtn;
// 到店铺所需时间
@property (nonatomic, strong) UIButton *timeBtn;
// 到店铺导航按钮
@property (nonatomic, strong) UIButton *routeBtn;
// 店铺封面图片
@property (nonatomic, strong) UIImageView *iconView;
@end

@implementation YGShopCell

+ (instancetype)initWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"shop";
    YGShopCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[YGShopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = [UIFont systemFontOfSize:18];
        [self.contentView addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        UILabel *addressLabel = [[UILabel alloc] init];
        addressLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:addressLabel];
        self.addressLabel = addressLabel;
        
        UIButton *distanceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [distanceBtn setBackgroundImage:[UIImage imageNamed:@"icon_bg"] forState:UIControlStateNormal];
        distanceBtn.titleLabel.font = [UIFont systemFontOfSize:8];
        [self.contentView addSubview:distanceBtn];
        self.distanceBtn = distanceBtn;
        
        UIButton *timeBtn = [[UIButton buttonWithType:UIButtonTypeCustom];
        timeBtn.titleLabel.font = [UIFont systemFontOfSize:8];
                             timeBtn.userInteractionEnabled = NO;
        [self.contentView addSubview:timeBtn];
        self.timeBtn = timeBtn;
        
        UIButton *routeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [routeBtn setImage:[UIImage imageNamed:@"road_icon"] forState:UIControlStateNormal];
    }
    return self;
}

@end
