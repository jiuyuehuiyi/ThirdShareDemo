//
//  WHAppDelegate+WHThirdResponse.h
//  BinFengExpressOwner
//
//  Created by 邓伟浩 on 2018/10/21.
//  Copyright © 2018年 BinFeng. All rights reserved.
//

#import "WHAppDelegate.h"
#import "WXApi.h"

@interface WHAppDelegate (WHThirdResponse)<WXApiDelegate, QQApiInterfaceDelegate, TencentSessionDelegate, WeiboSDKDelegate>

- (void)setUpWXShareService; // 微信
- (void)setUpQQService; // QQ
- (void)setUpSinaWeiBoService; // 新浪微博

@end
