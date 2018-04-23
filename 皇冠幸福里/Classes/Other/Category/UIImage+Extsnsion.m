//
//  UIImage+Extsnsion.m
//  山寨微信
//
//  Created by LiYugang on 2018/1/17.
//  Copyright © 2018年 com.yglee. All rights reserved.
//

#import "UIImage+Extsnsion.h"

@implementation UIImage (Extsnsion)
+ (UIImage *)imageWithColor:(UIColor *)color
{
    UIImage *image = nil;
    
    CGSize imageSize = CGSizeMake(10, 44);
    
    UIGraphicsBeginImageContext(imageSize);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextFillRect(ctx, (CGRect){0, 0, imageSize});
    
    [color set];
    
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}
@end
