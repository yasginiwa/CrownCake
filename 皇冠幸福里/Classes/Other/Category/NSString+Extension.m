//
//  NSString+Extension.m
//  皇冠幸福里
//
//  Created by YGLEE on 2018/5/21.
//  Copyright © 2018年 LiYugang. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
+ (NSString *)stringWithDistance:(NSInteger)distance
{
    float a = distance / 1000;
    return [NSString stringWithFormat:@"%.2fKm", a];
}
@end
