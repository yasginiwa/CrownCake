//
//  YGUrlString.h
//  CASAMIEL
//
//  Created by LiYugang on 2018/4/18.
//  Copyright © 2018年 YGLEE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YGUrlString : NSObject

#pragma mark - 项目中所有URL

extern NSString *baseUrl;
extern NSString *homeUrl;
/** 登录 */
UIKIT_EXTERN NSString *const LoginURL;
/** 注册会员申请虚拟卡 */
UIKIT_EXTERN NSString *const RegIcselfregistURL;
/** 注册会员并绑卡 */
UIKIT_EXTERN NSString *const RegBindCardURL;
/** 获取验证码 */
UIKIT_EXTERN NSString *const CheckCodeURL;
/** 自动登录 */
UIKIT_EXTERN NSString *const RefreshTokenURL;
/** 登出 */
UIKIT_EXTERN NSString *const LoginOutURL;
/** 自动登录 */
UIKIT_EXTERN NSString *const RefreshUserTokenURL;
/** 获取会员信息 */
UIKIT_EXTERN NSString *const GetMemberInfoURL;
/** 修改会员信息 */
UIKIT_EXTERN NSString *const ModifyMemberInfoURL;


/** 获取会员卡信息 */
UIKIT_EXTERN NSString *const GetMyCardURL;
/** 解绑会员卡 */
UIKIT_EXTERN NSString *const MemberUnicregistURL;
/** 绑定会员卡 */
UIKIT_EXTERN NSString *const MemberBindCardURL;
/** 申请新会员卡 */
UIKIT_EXTERN NSString *const MemberIcselfregistURL;

/** 获取优惠券信息 */
UIKIT_EXTERN NSString *const GetTicticketURL;
/** 获取付款码信息 */
UIKIT_EXTERN NSString *const GetconsumecodeURL;
/** 检验付款码信息 */
UIKIT_EXTERN NSString *const CheckconsumecodeURL;
/** 查询会员卡消费和充值记录 */
UIKIT_EXTERN NSString *const GetICRecordURL;

#pragma  mark - 首页
/** 首页信息 */
UIKIT_EXTERN NSString *const GetProductsURL;

@end
