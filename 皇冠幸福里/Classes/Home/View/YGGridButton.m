//
//  YGGridButton.m
//  皇冠幸福里
//
//  Created by LiYugang on 2018/5/9.
//  Copyright © 2018年 LiYugang. All rights reserved.
//

#import "YGGridButton.h"

static NSString *_path;

@implementation YGGridButton

+ (void)initialize
{
    _path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"YGGridBtn"];
    BOOL isDir = NO;
    BOOL isExsists = [[NSFileManager defaultManager] fileExistsAtPath:_path isDirectory:&isDir];
    if (!isExsists || !isDir) {
        [[NSFileManager defaultManager] createDirectoryAtPath:_path withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = imageW * 0.92;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleY = CGRectGetMaxY(self.imageView.frame);
    CGFloat titleW = self.width;
    CGFloat titleH = self.height - self.imageView.height + 20;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

- (void)setButtonImageWithUrl:(NSString *)urlStr placeHolder:(NSString *)placeHolder {
    
    NSURL *url = [NSURL URLWithString:urlStr];
    [self setImage:[UIImage imageNamed:placeHolder] forState:UIControlStateNormal];
    NSString *imageName = [urlStr stringByReplacingOccurrencesOfString:@"/" withString:@""];
    NSString *imagePath = [_path stringByAppendingPathComponent:imageName];
    
    NSData *data = [NSData dataWithContentsOfFile:imagePath];
    if (data) {
        UIImage *image = [UIImage imageWithData:data];
        [self setImage:image forState:UIControlStateNormal];
    } else {
        NSBlockOperation *downloadImage = [NSBlockOperation blockOperationWithBlock:^{
            NSData *downloadData = [NSData dataWithContentsOfURL:url];
            [downloadData writeToFile:imagePath atomically:YES];
            UIImage *downloadImage = [UIImage imageWithData:downloadData];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setImage:downloadImage forState:UIControlStateNormal];
            });
        }];
        
        NSOperationQueue *asynQueue = [[NSOperationQueue alloc] init];
        [asynQueue addOperation:downloadImage];
    }
}
@end
