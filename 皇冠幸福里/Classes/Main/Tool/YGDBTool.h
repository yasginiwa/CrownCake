//
//  YGDBTool.h
//  皇冠幸福里
//
//  Created by YGLEE on 2018/5/1.
//  Copyright © 2018年 LiYugang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YGHomeFrame;

@interface YGDBTool : NSObject
+ (instancetype)sharedDBTool;
- (void)addHomeFrame:(YGHomeFrame *)homeFrame;
- (NSMutableArray *)getAllHomeFrame;
@end
