//
//  ViewController.m
//  ThirdShareDemo
//
//  Created by 邓伟浩 on 2018/10/23.
//  Copyright © 2018年 邓伟浩. All rights reserved.
//

#import "WHHomeController.h"
#import "WHSharePlatformView.h"
#import "WHThirdShareTool.h"

@interface WHHomeController ()

@end

@implementation WHHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

- (void)setUpUI {
    WHSharePlatformView *sharView = [[WHSharePlatformView alloc] initWithImageArray:@[@"share_WXChat_icon", @"share_WXpengyou_icon", @"share_QQ_icon", @"share_Sina_icon"]];
    [self.view addSubview:sharView];
    [sharView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(kRealwidth(66));
    }];
    
    [self.view layoutIfNeeded];
    
    [UIView animateWithDuration:.5f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [sharView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view.mas_bottom).offset(-kRealwidth(100));
            make.left.right.mas_equalTo(self.view);
            make.height.mas_equalTo(kRealwidth(66));
        }];
        [self.view layoutIfNeeded];
    } completion:nil];
    
    kWeakSelf(self);
    
    sharView.clicked = ^(int index) {
        [weakself makeShareby:index];
    };
}

- (void)makeShareby:(int)index {
    DLog(@"index == %d", index);
    if (index == 2) { // QQ分享
        [self makeShareToQQ];
    }
    if (index == 0) {
        [self makeShareToWX:0];
    }
    if (index == 1) {
        [self makeShareToWX:1];
    }
    if (index == 3) {
        [self makeSinaShare];
    }
}

#pragma mark - —————— QQ分享 ——————

- (void)makeShareToQQ {
    [WHThirdShareTool QQMakeShareTitle:@"测试标题" description:@"测试描述" image:IMAGE_NAMED(@"share_back_png")];
}

#pragma mark —————— 微信分享 ——————

- (void)makeShareToWX:(int)type {
    [WHThirdShareTool WXMakeShareTitle:@"测试标题" description:@"测试描述" webpageUrl:@"http://www.baidu.com" image:IMAGE_NAMED(@"share_back_png") type:type];
}

#pragma mark —————— 新浪微博分享 ——————

- (void)makeSinaShare {
    [WHThirdShareTool SinaWeiBoMakeShareText:@"测试文本内容" image:nil objectID:@"hahahha" title:@"测试标题" description:@"测试描述" thumbImage:IMAGE_NAMED(@"share_back_png") webpageUrl:@"http://www.baidu.com"];
}



@end
