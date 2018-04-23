//
//  NSArray+RandomObj.m
//  CASAMIEL
//
//  Created by YGLEE on 2018/4/19.
//  Copyright © 2018年 YGLEE. All rights reserved.
//

#import "NSArray+RandomObj.h"

@implementation NSArray (RandomObj)

/**
 * 在原来的array中随机生成一个具有4个对象的新数组
 */
+ (NSMutableArray *)randomArrayWithArray:(NSArray *)array
{
    NSMutableArray *newArr = [NSMutableArray array];
    while (newArr.count != array.count) {
        //生成随机数
        int x =arc4random() % array.count;
        id obj = array[x];
        if (![newArr containsObject:obj]) {
            [newArr addObject:obj];
        }
    }
    return newArr;
}
@end
