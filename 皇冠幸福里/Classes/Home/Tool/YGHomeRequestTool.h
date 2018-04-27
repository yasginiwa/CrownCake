//
//  YGHomeRequestTool.h
//  皇冠幸福里
//
//  Created by LiYugang on 2018/4/27.
//  Copyright © 2018年 LiYugang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YGHomeRequestTool : NSObject
@property (nonatomic, strong) NSMutableArray *homeFrameArray;
+ (instancetype)sharedHomeRequest;
- (void)startAllHomeRequest:(void(^)(void))refreshUI;
@end
