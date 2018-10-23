//
//  WHAppDelegate.m
//  BinFengExpressOwner
//
//  Created by 邓伟浩 on 2018/10/12.
//  Copyright © 2018年 邓伟浩. All rights reserved.
//

#import "WHAppDelegate.h"

#import "WHAppDelegate+WHAppService.h" // 应用服务
#import "WHAppDelegate+WHThirdResponse.h" // 第三方回调, 包含支付、分享



@interface WHAppDelegate ()

@end

@implementation WHAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    [self setUpAppService];
    [self setUpWXShareService];
    [self setUpQQService];
    [self setUpSinaWeiBoService];
    
    return YES;
}

@end
