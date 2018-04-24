//
//  YGProductsRequest.h
//  CASAMIEL
//
//  Created by YGLEE on 2018/4/20.
//  Copyright © 2018年 YGLEE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YGHttpTool.h"

@interface YGProductsRequest : NSObject
+ (void)getProductWithParams:(NSDictionary *)params success:(void(^)(id result))success failure:(void(^)(NSError *error))failure;
@end
