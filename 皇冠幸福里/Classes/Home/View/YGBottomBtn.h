//
//  YGBottomBtn.h
//  CASAMIEL
//
//  Created by LiYugang on 2018/4/23.
//  Copyright © 2018年 YGLEE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YGBottomBtn : UIButton
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *image;
- (void)addTarget:(id)target action:(SEL)action;
@end
