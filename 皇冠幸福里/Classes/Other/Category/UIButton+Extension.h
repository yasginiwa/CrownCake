//
//  UIButton+Extension.h
//  CASAMIEL
//
//  Created by YGLEE on 2018/4/15.
//  Copyright © 2018年 YGLEE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)

/**
 * 快速创建一个自定义Button
 */
+ (UIButton *)customButtomWithType:(UIButtonType)tyep frame:(CGRect)frame text:(NSString *)text tColor:(UIColor *)tColor font:(UIFont *)font NImg:(NSString *)NImg SImg:(NSString *)SImg BNImg:(NSString *)BNImg BSImg:(NSString *)BSImg color:(UIColor*)color;
@end
