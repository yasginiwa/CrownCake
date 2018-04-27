//
//  YGGridView.h
//  CASAMIEL
//
//  Created by YGLEE on 2018/4/19.
//  Copyright © 2018年 YGLEE. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YGGridView, YGGridButton;

@protocol YGGridViewDelegate <NSObject>
@optional
- (void)gridView:(YGGridView *)gridView didClickGridBtn:(YGGridButton *)gridBtn;
@end

@interface YGGridView : UIView
@property (nonatomic, weak) id<YGGridViewDelegate> delegate;
@property (nonatomic, strong) NSArray *products;
@end
