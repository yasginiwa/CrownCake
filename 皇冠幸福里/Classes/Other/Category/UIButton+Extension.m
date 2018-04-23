//
//  UIButton+Extension.m
//  CASAMIEL
//
//  Created by YGLEE on 2018/4/15.
//  Copyright © 2018年 YGLEE. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)
+ (UIButton *)customButtomWithType:(UIButtonType)type frame:(CGRect)frame text:(NSString *)text tColor:(UIColor *)tColor font:(UIFont *)font NImg:(NSString *)NImg SImg:(NSString *)SImg BNImg:(NSString *)BNImg BSImg:(NSString *)BSImg color:(UIColor *)color
{
    UIButton *button = [UIButton  buttonWithType:type];
    button.frame = frame;
    [button setTitle:text forState:UIControlStateNormal];
    [button setTitleColor:tColor forState:UIControlStateNormal];
    button.titleLabel.font = font;
    [button setImage:[UIImage imageNamed:NImg] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:SImg] forState:UIControlStateSelected];
    [button setBackgroundImage:[UIImage imageNamed:BNImg] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:BSImg] forState:UIControlStateSelected];
    [button setBackgroundColor:color];
    return button;
}
@end
