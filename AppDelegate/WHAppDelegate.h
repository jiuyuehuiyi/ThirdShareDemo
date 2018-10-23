//
//  WHAppDelegate.h
//  BinFengExpressOwner
//
//  Created by 邓伟浩 on 2018/10/12.
//  Copyright © 2018年 邓伟浩. All rights reserved.
//

/**
 *
 * ━━━━━━神兽出没━━━━━━
 *       ┏━┓   ┏━┓
 *     ┏━┻━┻━━━┻━┻━┓
 *     ┃           ┃
 *     ┃     ━     ┃
 *     ┃  ┳┛   ┗┳  ┃
 *     ┃           ┃
 *     ┃     ┻     ┃
 *     ┃           ┃
 *     ┗━┓       ┏━┛Code is far away from bug with the animal protecting
 *       ┃       ┃    神兽保佑,代码无bug
 *       ┃       ┃
 *       ┃       ┗━━━━━━┓
 *       ┃              ┣━┓
 *       ┃              ┣━┛
 *       ┗━┳┳┳━━━━━━━┳┳┳┛
 *         ┣╋┫       ┣╋┫
 *         ┗┻┛       ┗┻┛
 *
 * ━━━━━━感觉萌萌哒━━━━━━
 *
 */

#import <UIKit/UIKit.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WeiboSDK.h"

@interface WHAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) TencentOAuth *tencentOAuth;

@property (nonatomic, strong) WeiboSDK *weibo;
@property (nonatomic, strong) NSString *wbtoken;

@end

