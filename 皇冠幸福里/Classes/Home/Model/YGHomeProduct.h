//
//  YGHomeProduct.h
//  皇冠幸福里
//
//  Created by LiYugang on 2018/4/24.
//  Copyright © 2018年 LiYugang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YGProduct;

@interface YGHomeProduct : NSObject <NSCoding>
@property (nonatomic, strong) NSArray *adsImages;
@property (nonatomic, copy) NSString *bannerTextEn;
@property (nonatomic, copy) NSString *bannerTextChs;
@property (nonatomic, strong) NSArray *rollImages;
@property (nonatomic, strong) NSArray *gridProducts;
@property (nonatomic, strong) NSArray *rowProducts;
@property (nonatomic, copy) NSString *mapTitle;
@property (nonatomic, copy) NSString *bottomBtnImage;
@property (nonatomic, copy) NSString *bottomBtnText;
@end
