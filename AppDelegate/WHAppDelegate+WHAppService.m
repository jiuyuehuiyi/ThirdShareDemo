//
//  WHAppDelegate+WHAppService.m
//  BinFengExpressOwner
//
//  Created by 邓伟浩 on 2018/10/13.
//  Copyright © 2018年 BinFeng. All rights reserved.
//

#import "WHAppDelegate+WHAppService.h"

#import "WHHomeController.h"

@implementation WHAppDelegate (WHAppService)

- (void)setUpAppService {
    [self setUpRootViewController];
}

- (void)setUpRootViewController {
    WHHomeController *homeController = [[WHHomeController alloc] init];
    UIViewController *homeNavi = [[UINavigationController alloc]
                                  initWithRootViewController:homeController];
    self.window.rootViewController = homeNavi;
}

@end
