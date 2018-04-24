//
//  YGHomeProduct.h
//  皇冠幸福里
//
//  Created by LiYugang on 2018/4/24.
//  Copyright © 2018年 LiYugang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YGProduct;

@interface YGHomeProduct : NSObject
@property (nonatomic, strong) NSArray *adsImages;
@property (nonatomic, copy) NSString *bannerTitleEn;
@property (nonatomic, copy) NSString *bannerTitleChs;
@property (nonatomic, strong) NSArray *gridProducts;
@property (nonatomic, strong) NSArray *rowProducts;
@property (nonatomic, assign, getter=hasMap) BOOL map;
@property (nonatomic, copy) NSString *bottomBtnImage;
@end
