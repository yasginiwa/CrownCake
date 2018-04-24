//
//  YGHttpTool.m
//  CASAMIEL
//
//  Created by LiYugang on 2018/4/13.
//  Copyright © 2018年 YGLEE. All rights reserved.
//

#import "YGHttpTool.h"
#import "AFNetworking.h"

@implementation YGHttpTool

#pragma mark - 单例
static id _instance;
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_instance == nil) {
            _instance = [super allocWithZone:zone];
        }
    });
    return _instance;
}

+ (instancetype)sharedHttpTool
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

#pragma mark - GET请求
+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id result))success failure:(void (^)(NSError *error))failure
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id result = responseObject;
        success(result);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

#pragma mark - POST请求
+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id result))success failure:(void (^)(NSError *))failure
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id rersult = responseObject;
        success(rersult);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}
@end
