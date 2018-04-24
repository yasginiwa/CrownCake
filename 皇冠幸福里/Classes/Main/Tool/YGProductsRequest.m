//
//  YGProductsRequest.m
//  CASAMIEL
//
//  Created by YGLEE on 2018/4/20.
//  Copyright © 2018年 YGLEE. All rights reserved.
//

#import "YGProductsRequest.h"
#import "YGUrlString.h"

@implementation YGProductsRequest
+ (void)getProductWithParams:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@", baseUrl, GetProductsURL];
    [YGHttpTool get:url params:params success:^(id result) {
        success(result);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
@end
