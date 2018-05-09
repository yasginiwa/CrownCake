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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
