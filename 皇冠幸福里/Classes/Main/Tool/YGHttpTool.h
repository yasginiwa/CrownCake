//
//  YGHttpTool.h
//  CASAMIEL
//
//  Created by LiYugang on 2018/4/13.
//  Copyright © 2018年 YGLEE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YGHttpTool : NSObject
+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void(^)(id result))success failure:(void(^)(NSError *error))failure;
+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void(^)(id result))success failure:(void(^)(NSError *error))failure;
@end
