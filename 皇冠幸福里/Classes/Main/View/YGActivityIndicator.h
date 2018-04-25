//
//  YGActivityIndicator.h
//  皇冠幸福里
//
//  Created by LiYugang on 2018/4/25.
//  Copyright © 2018年 LiYugang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YGActivityIndicator : UIView
@property (nonatomic, assign) BOOL hidesWhenStopped;
- (void)startAnimating;
- (void)stopAnimating;
@end
