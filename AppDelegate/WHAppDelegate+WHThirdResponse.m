//
//  WHAppDelegate+WHThirdResponse.m
//  BinFengExpressOwner
//
//  Created by 邓伟浩 on 2018/10/21.
//  Copyright © 2018年 BinFeng. All rights reserved.
//

#import "WHAppDelegate+WHThirdResponse.h"
#import <AlipaySDK/AlipaySDK.h>


@implementation WHAppDelegate (WHThirdResponse)

#pragma mark - —————— 注册第三方服务 ——————
- (void)setUpWXShareService { // 微信
    [WXApi registerApp:kWXAppKey];
}

- (void)setUpQQService { // QQ
    self.tencentOAuth = [[TencentOAuth alloc] initWithAppId:kQQAppID andDelegate:self];
}

- (void)setUpSinaWeiBoService { // 新浪微博
    [WeiboSDK enableDebugMode:NO];
    [WeiboSDK registerApp:kSinaAppKey];
}

#pragma mark - —————— WeiboSDKDelegate ——————
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request {
    
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response {
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class]) {
        WBSendMessageToWeiboResponse *sendMessageToWeiboResponse = (WBSendMessageToWeiboResponse *)response;
        NSString *accessToken = [sendMessageToWeiboResponse.authResponse accessToken];
        if (accessToken) {
            self.wbtoken = accessToken;
        }
        if (response.statusCode == WeiboSDKResponseStatusCodeSuccess) {
//            [WHView showAlertwithTitle:nil message:@"分享成功" okAction:nil cancelAction:nil];
        } else if (response.statusCode == WeiboSDKResponseStatusCodeUserCancel) {
//            [WHView showAlertwithTitle:nil message:@"取消分享" okAction:nil cancelAction:nil];
        } else {
//            [WHView showAlertwithTitle:nil message:@"分享失败" okAction:nil cancelAction:nil];
        }
    }
    else if ([response isKindOfClass:WBAuthorizeResponse.class]) {
        if (response.statusCode == 0) {
            // 新浪微博授权成功
//            [WHView showAlertwithTitle:nil message:@"授权成功" okAction:nil cancelAction:nil];
        } else {
            // 新浪微博授权失败
//            [WHView showAlertwithTitle:nil message:@"授权失败" okAction:nil cancelAction:nil];
        }
    }
}

#pragma mark - —————— QQApiInterfaceDelegate | WXApiDelegate ——————
- (void)onReq:(QQBaseReq *)req {
    DLog(@"——————req—————— %@", req);
}

- (void)onResp:(NSObject *)resp {
    DLog(@"——————resp—————— %@", resp);
    // SendMessageToQQResp应答帮助类
    if ([resp.class isSubclassOfClass:[SendMessageToQQResp class]]) {  //QQ分享回应
        SendMessageToQQResp *msgToQQ = (SendMessageToQQResp *)resp;
        NSLog(@"code %@  errorDescription %@  infoType %@", msgToQQ.result, msgToQQ.errorDescription, msgToQQ.extendInfo);
        
        SendMessageToQQResp * tmpResp = (SendMessageToQQResp *)resp;
        if (tmpResp.type == ESENDMESSAGETOQQRESPTYPE && tmpResp.result.integerValue == 0) { // 分享成功
//            [WHView showAlertwithTitle:nil message:@"分享成功" okAction:nil cancelAction:nil];
        } else if (tmpResp.type == ESENDMESSAGETOQQRESPTYPE && tmpResp.result.integerValue == -4) { // 取消分享
//            [WHView showAlertwithTitle:nil message:@"取消分享" okAction:nil cancelAction:nil];
        } else {
//            [WHView showAlertwithTitle:nil message:@"分享失败" okAction:nil cancelAction:nil];
        }
    }
    /** 微信 App 分享功能调整
     * https://open.weixin.qq.com/cgi-bin/announce?spm=a311a.9588098.0.0&action=getannouncement&key=11534138374cE6li&version=
     */
//    if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
//        SendMessageToWXResp *msgToWX = (SendMessageToWXResp *)resp;
//        if (msgToWX.errCode == 0) {
//            [WHView showAlertwithTitle:nil message:@"分享成功" okAction:nil cancelAction:nil];
//        } else {
//            [WHView showAlertwithTitle:nil message:@"分享失败" okAction:nil cancelAction:nil];
//        }
//    }
    
    if ([resp isKindOfClass:[PayResp class]]) {
        PayResp *payResp = (PayResp *)resp;
        NSString *payResult = [NSString stringWithFormat:@"errcode: %d", payResp.errCode];
        
        // 支付返回结果，实际支付结果需要去微信服务器端查询
        switch (payResp.errCode) {
            case 0:
                payResult = @"支付成功";
                break;
            case -1:
                payResult = @"支付结果：失败！";
                break;
            case -2:
                payResult = @"用户已经退出支付！";
                break;
            default:
                payResult = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", payResp.errCode, payResp.errStr];
        }
//        [WHView showAlertwithTitle:nil message:payResult okAction:nil cancelAction:nil];
    }
    
}

- (void)isOnlineResponse:(NSDictionary *)response {
    
}


#pragma mark - —————— TencentSessionDelegate ——————
/** 登录成功 */
- (void)tencentDidLogin {
    if (self.tencentOAuth.accessToken && 0 != [self.tencentOAuth.accessToken length]) {
        // 记录登录用户的OpenID、Token以及过期时间
        [self.tencentOAuth getUserInfo];
    } else {
        // 登录不成功 没有获取accesstoken
    }
}

- (void)getUserInfoResponse:(APIResponse *)response {
    DLog(@"response:%@", response.jsonResponse);
}

/** 非网络错误导致登录失败 */
- (void)tencentDidNotLogin:(BOOL)cancelled {
    if (cancelled) { //用户取消登录
        DLog(@"用户取消登录");
    } else { // 登录失败
        DLog(@"登录失败");
    }
}

/** 网络错误导致登录失败 */
- (void)tencentDidNotNetWork {
//    无网络连接，请设置网络
}

#pragma mark - —————— Handle openURL ——————

- (void)gridResult:(NSDictionary *)resultDic {
    NSNumber *resultStatus = resultDic[@"resultStatus"];
    if (resultStatus.intValue == 9000) {
//        [WHView showAlertwithTitle:nil message:@"支付成功" okAction:nil cancelAction:nil];
    } else {
//        [WHView showAlertwithTitle:nil message:@"支付失败" okAction:nil cancelAction:nil];
    }
    
}

- (BOOL)handleOpenURL:(NSURL *)url {
    if ([url.absoluteString hasPrefix:NSStringFormat(@"tencent%@", kQQAppID)]) {
        [QQApiInterface handleOpenURL:url delegate:self];
        return [TencentOAuth HandleOpenURL:url];
    }
    
    if ([url.absoluteString hasPrefix:NSStringFormat(@"wb%@", kSinaAppKey)]) {
        return [WeiboSDK handleOpenURL:url delegate:self];
    }
    
    if ([url.host isEqualToString:@"platformId=wechat"] || [url.host isEqualToString:@"pay"] || [url.scheme isEqualToString:kWXAppKey]) {
        return [WXApi handleOpenURL:url delegate:self];
    }
    
    if ([url.host isEqualToString:@"safepay"]) { // 处理支付宝支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            DLog(@"result2 = %@", resultDic);
            [self gridResult:resultDic];
        }];
    }
    return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
    return [self handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [self handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation {
    return [self handleOpenURL:url];
}


@end
