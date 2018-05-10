//
//  YGRowView.h
//  CASAMIEL
//
//  Created by YGLEE on 2018/4/19.
//  Copyright © 2018年 YGLEE. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YGRowView;

@protocol YGRowViewDelegate <NSObject>
- (void)rowView:(YGRowView *)rowView didClickDetailButton:(UIButton *)button;
@end

@interface YGRowView : UIView
@property (nonatomic, strong) NSArray *products;
@property (nonatomic, weak) id<YGRowViewDelegate> delegate;
@end
