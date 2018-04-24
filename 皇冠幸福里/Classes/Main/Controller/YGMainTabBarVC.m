//
//  YGMainTabBarVC.m
//  皇冠幸福里
//
//  Created by LiYugang on 2018/4/24.
//  Copyright © 2018年 LiYugang. All rights reserved.
//

#import "YGMainTabBarVC.h"
#import "YGTabBar.h"
#import "YGMainNavVC.h"

@interface YGMainTabBarVC ()

@end

@implementation YGMainTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *array = @[
                       @{@"class"    :@"YGHomeVC",
                         @"imageName":@"home",
                         @"selectImg":@"home_sel",
                         @"title"    :@"首页"},
                       @{@"class"    :@"YGDiscoveryVC",
                         @"imageName":@"discovery",
                         @"selectImg":@"discovery_sel",
                         @"title"    :@"发现"},
                       @{@"class"    :@"YGShopVC",
                         @"imageName":@"shop",
                         @"selectImg":@"shop_sel",
                         @"title"    :@"门店"},
                       @{@"class"    :@"YGProfileVC",
                         @"imageName":@"profile",
                         @"selectImg":@"profile_sel",
                         @"title"    :@"我的"}
                       ];
    [array enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIViewController *vc = [NSClassFromString(dic[@"class"]) new];
        YGMainNavVC *nav = [[YGMainNavVC alloc] initWithRootViewController:vc];
        UITabBarItem *item = nav.tabBarItem;
        item.title = dic[@"title"];
        //    不让tabbar底部有渲染的关键代码
        item.selectedImage = [[UIImage imageNamed:dic[@"selectImg"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.image = [[UIImage imageNamed:dic[@"imageName"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]} forState:UIControlStateSelected];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]} forState:UIControlStateNormal];
        
        [self addChildViewController:nav];
    }];
    
    [self setTabBar];
}

- (void)setTabBar
{
    YGTabBar *myTabBar = [[YGTabBar alloc] init];
    [self setValue:myTabBar forKey:@"tabBar"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
