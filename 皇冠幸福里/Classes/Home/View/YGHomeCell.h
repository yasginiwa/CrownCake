//
//  YGHomeCell.h
//  皇冠幸福里
//
//  Created by LiYugang on 2018/4/27.
//  Copyright © 2018年 LiYugang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YGHomeFrame, YGHomeProduct;

@interface YGHomeCell : UITableViewCell
@property (nonatomic, strong) YGHomeFrame *homeFrame;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
