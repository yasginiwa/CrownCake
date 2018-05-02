//
//  YGHomeRequestTool.m
//  皇冠幸福里
//
//  Created by LiYugang on 2018/4/27.
//  Copyright © 2018年 LiYugang. All rights reserved.
//

#import "YGHomeRequestTool.h"
#import "YGProductsRequest.h"
#import "YGProduct.h"
#import "YGHomeFrame.h"
#import "YGHomeProduct.h"
#import "YGDBTool.h"

@implementation YGHomeRequestTool

static id _instance;
static NSString *_path;

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+ (instancetype)sharedHomeRequest
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}



- (NSMutableArray *)homeFrameArray
{
    if (_homeFrameArray == nil) {
        _homeFrameArray = [NSMutableArray array];
    }
    return _homeFrameArray;
}

- (void)startAllHomeRequest:(void(^)(void))refreshUI
{
    dispatch_group_t requestGroup = dispatch_group_create();
    
    dispatch_group_enter(requestGroup);
    NSDictionary *adsParam = @{@"groupId" : @"1"};
    __block NSMutableArray *adsImagesArray = [NSMutableArray array];
    [YGProductsRequest getProductWithParams:adsParam success:^(id result) {
        NSArray *adsProducts = [YGProduct mj_objectArrayWithKeyValuesArray:result];
        for (YGProduct *product in adsProducts) {
            [adsImagesArray addObject:product.productImg];
        }
        dispatch_group_leave(requestGroup);
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    
    dispatch_group_enter(requestGroup);
    NSDictionary *starParam = @{@"groupId" : @"3"};
    __block NSArray *productArray;
    [YGProductsRequest getProductWithParams:starParam success:^(id result) {
        productArray = [YGProduct mj_objectArrayWithKeyValuesArray:result];
        dispatch_group_leave(requestGroup);
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    
    dispatch_group_enter(requestGroup);
    NSDictionary *storyParam = @{@"groupId" : @"2"};
    __block NSArray *storyArray;
    [YGProductsRequest getProductWithParams:storyParam success:^(id result) {
        storyArray = [YGProduct mj_objectArrayWithKeyValuesArray:result];
        dispatch_group_leave(requestGroup);
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    
    dispatch_group_notify(requestGroup, dispatch_get_main_queue(), ^{
        // 获取明星产品
        YGHomeFrame *starFrame = [[YGHomeFrame alloc] init];
        YGHomeProduct *starProduct = [[YGHomeProduct alloc] init];
        starProduct.bannerTextEn = @"Star Product";
        starProduct.bannerTextChs = @"明星产品";
        starProduct.bottomBtnImage = @"换一换";
        starProduct.adsImages = adsImagesArray;
        starProduct.gridProducts = productArray;
        starFrame.homeProduct = starProduct;
        [self.homeFrameArray addObject:starFrame];
        [[YGDBTool sharedDBTool] addHomeFrame:starFrame];
        
        // 获取故事产品
        YGHomeFrame *storyFrame = [[YGHomeFrame alloc] init];
        YGHomeProduct *storyProduct = [[YGHomeProduct alloc] init];
        storyProduct.bannerTextEn = @"CrownCake Story";
        storyProduct.bannerTextChs = @"皇冠故事";
        storyProduct.bottomBtnText = @"查看更多 >";
        storyProduct.rowProducts = storyArray;
        storyFrame.homeProduct = storyProduct;
        [self.homeFrameArray addObject:storyFrame];
        [[YGDBTool sharedDBTool] addHomeFrame:storyFrame];
      
        refreshUI();
    });
}


@end
