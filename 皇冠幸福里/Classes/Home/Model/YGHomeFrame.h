//
//  YGHomeFrame.h
//  皇冠幸福里
//
//  Created by LiYugang on 2018/4/24.
//  Copyright © 2018年 LiYugang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YGHomeProduct, YGGridView, YGRowView;

@interface YGHomeFrame : NSObject
@property (nonatomic, strong) YGHomeProduct *homeProduct;
@property (nonatomic, weak) YGGridView *gridView;
@property (nonatomic, weak) YGRowView *rowView;
@property (nonatomic, assign) CGRect adsFrame;
@property (nonatomic, assign) CGRect bannerFrame;
@property (nonatomic, assign) CGRect gridFrame;
@property (nonatomic, assign) CGRect rowFrame;
@property (nonatomic, assign) CGRect rollFrame;
@property (nonatomic, assign) CGRect mapFrame;
@property (nonatomic, assign) CGRect bottomBtnFrame;
@property (nonatomic, assign) CGFloat cellHeight;
@end
