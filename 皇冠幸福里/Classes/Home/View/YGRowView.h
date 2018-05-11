//
//  YGRowView.h
//  CASAMIEL
//
//  Created by YGLEE on 2018/4/19.
//  Copyright © 2018年 YGLEE. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    rowTypeSummary,
    rowTypeDetail
}rowType;

@interface YGRowView : UIView
@property (nonatomic, strong) NSArray *products;
@property (nonatomic, assign) rowType type;
- (instancetype)initWithType:(rowType)type;
@end
