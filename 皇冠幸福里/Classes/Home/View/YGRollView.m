//
//  YGRollView.m
//  皇冠幸福里
//
//  Created by YGLEE on 2018/4/25.
//  Copyright © 2018年 LiYugang. All rights reserved.
//

#import "YGRollView.h"

@implementation YGRollView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.imageArray = self.images;
    }
    return self;
}

- (CGFloat)viewHeight
{
    return 200;
}
@end
