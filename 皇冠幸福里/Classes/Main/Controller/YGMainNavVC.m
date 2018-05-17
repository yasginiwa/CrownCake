//
//  YGMainNavVC.m
//  皇冠幸福里
//
//  Created by LiYugang on 2018/4/24.
//  Copyright © 2018年 LiYugang. All rights reserved.
//

#import "YGMainNavVC.h"

@interface YGMainNavVC ()

@end

@implementation YGMainNavVC

+ (void)initialize
{
    UINavigationBar *appearance = [UINavigationBar appearance];
    NSDictionary *titleAttrs = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:22]};
    [appearance setTitleTextAttributes:titleAttrs];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}
@end
