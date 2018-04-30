//
//  YGBottomBtn.m
//  CASAMIEL
//
//  Created by LiYugang on 2018/4/23.
//  Copyright © 2018年 YGLEE. All rights reserved.
//

#import "YGBottomBtn.h"

@implementation YGBottomBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitle:self.text forState:UIControlStateNormal];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted
{
    
}

//- (CGRect)titleRectForContentRect:(CGRect)contentRect
//{
//    CGFloat titleX;
//    CGFloat titleY;
//    CGFloat titleW;
//    CGFloat titleH;
//    if (self.text.length && self.image) {
//        titleX = 0;
//        titleY = 0;
//        titleW = self.width * 0.6;
//        titleH = self.height;
//        return CGRectMake(titleX, titleY, titleW, titleH);
//    } else {
//        return CGRectZero;
//    }
//
//}
//
//- (CGRect)imageRectForContentRect:(CGRect)contentRect
//{
//    CGFloat imageX;
//    CGFloat imageY;
//    CGFloat imageW;
//    CGFloat imageH;
//
//    if (self.text.length && self.image) {
//        imageX = self.width * 0.6;
//        imageY = 0;
//        imageW = self.width * 0.4;
//        imageH = self.height;
//    } else {
//        imageX = 0;
//        imageY = 0;
//        imageW = self.width * 0.7;
//        imageH = self.height;
//    }
//    return CGRectMake(imageX, imageY, imageW, imageH);
//}

- (void)setImage:(NSString *)image
{
    _image = image;
    [self setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
}

- (void)setText:(NSString *)text
{
    _text = text;
    [self setTitle:text forState:UIControlStateNormal];
}
@end
