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
