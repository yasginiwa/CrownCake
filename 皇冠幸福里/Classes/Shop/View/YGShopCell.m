//
//  YGShopCell.m
//  皇冠幸福里
//
//  Created by LiYugang on 2018/5/17.
//  Copyright © 2018年 LiYugang. All rights reserved.
//

#import "YGShopCell.h"
#import "YGShop.h"

@interface YGShopCell ()
// 店铺名称
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
// 店铺地址
@property (nonatomic, weak) IBOutlet UILabel *addressLabel;
// 到店铺距离
@property (nonatomic, weak) IBOutlet UIButton *distanceBtn;
// 到店铺所需时间
@property (nonatomic, weak) IBOutlet UIButton *timeBtn;
// 到店铺导航按钮
@property (nonatomic, weak) IBOutlet UIButton *routeBtn;
// 店铺封面图片
@property (nonatomic, weak) IBOutlet UIImageView *iconView;
@end

@implementation YGShopCell

//+ (instancetype)cellWithTableView:(UITableView *)tableView
//{
//    static NSString *ID = @"shop";
//    YGShopCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    if (cell == nil) {
//        cell = [[YGShopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
//    }
//    return cell;
//}



- (void)setShop:(YGShop *)shop
{
    _shop = shop;
    self.nameLabel.text = shop.name;
    self.addressLabel.text = shop.address;
    [self.distanceBtn setTitle:shop.distance forState:UIControlStateNormal];
    [self.timeBtn setTitle:shop.time forState:UIControlStateNormal];
    [self.routeBtn setTitle:shop.route forState:UIControlStateNormal];
    self.iconView.image = [UIImage imageNamed:shop.icon];
}

@end
