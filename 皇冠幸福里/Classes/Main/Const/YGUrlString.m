//
//  YGUrlString.m
//  CASAMIEL
//
//  Created by LiYugang on 2018/4/18.
//  Copyright © 2018年 YGLEE. All rights reserved.
//

#import "YGUrlString.h"

@implementation YGUrlString

NSString *baseUrl = @"https://api.casamiel.cn";
/** 登录 */
NSString *const LoginURL = @"/api/v1/Login/Login";
/** 注册会员申请虚拟卡 */
NSString *const RegIcselfregistURL = @"/api/v1/Login/RegIcselfregist";
/** 注册会员并绑卡 */
NSString *const RegBindCardURL = @"/api/v1/Login/RegBindCard";
/** 获取验证码 */
NSString *const CheckCodeURL = @"/api/v1/Login/GetCheckCode";
/** 自动登录 */
NSString *const RefreshTokenURL = @"/api/v1/Login/refreshtoken";
/** 登出 */
NSString *const LoginOutURL = @"/api/v1/Login/Logout";
/** 自动登录 */
NSString *const RefreshUserTokenURL = @"/api/v1/Login/RefreshUserToken";
/** 获取会员信息 */
NSString *const GetMemberInfoURL = @"/api/v1/Account/GetMemberInfo";
/** 修改会员信息 */
NSString *const ModifyMemberInfoURL = @"/api/v1/Account/ModifyMemberInfo";

/** 获取会员卡信息 */
NSString *const GetMyCardURL = @"/api/v1/Card/GetMyCard";
/** 解绑会员卡 */
NSString *const MemberUnicregistURL = @"/api/v1/Card/MemberUnicregist";
/** 绑定会员卡 */
NSString *const MemberBindCardURL = @"/api/v1/Card/MemberBindCard";
/** 申请新会员卡 */
NSString *const MemberIcselfregistURL = @"/api/v1/Card/MemberIcselfregist";
/** 获取优惠券信息 */
NSString *const GetTicticketURL = @"/api/v1/Card/GetTicticket";
/** 获取付款码信息 */
NSString *const GetconsumecodeURL = @"/api/v1/Card/Getconsumecode";
/** 检验付款码信息 */
NSString *const CheckconsumecodeURL = @"/api/v1/Card/Checkconsumecode";
/** 查询会员卡消费和充值记录 */
NSString *const GetICRecordURL = @"/api/v1/Card/GetICRecord";

#pragma  mark - 首页
/** 首页信息 */
NSString *const GetProductsURL = @"/api/V1/SystemBase/GetProducts";
@end
