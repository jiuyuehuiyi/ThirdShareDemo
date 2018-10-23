//
//  WHThirdShareTool.h
//  BinFengExpressOwner
//
//  Created by 邓伟浩 on 2018/10/22.
//  Copyright © 2018年 BinFeng. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger, WHQQShareType) {
    WHQQShareTypeToQQ,
    WHQQShareTypeToQZone,
};

@interface WHThirdShareTool : NSObject

#pragma mark —————— QQ分享 ——————
/** 纯文本分享 */
+ (void)QQMakeShareText:(NSString *)text;

/** 纯图片分享 */
+ (void)QQMakeShareTitle:(NSString *)title description:(NSString *)description image:(UIImage *)image;

/** 新闻分享 */
+ (void)QQMakeShareNewsUrlStr:(NSString *)urlStr title:(NSString *)title description:(NSString *)description previewImageUrl:(NSString *)previewImageUrl shareType:(WHQQShareType)shareType;

/** 音乐分享 */
+ (void)QQMakeShareAudioUrlStr:(NSString *)urlStr title:(NSString *)title description:(NSString *)description previewImageUrl:(NSString *)previewImageUrl shareType:(WHQQShareType)shareType;

/** 视频分享 */
+ (void)QQMakeShareVideoUrlStr:(NSString *)urlStr title:(NSString *)title description:(NSString *)description previewImageUrl:(NSString *)previewImageUrl flashURL:(NSString *)flashURL image:(UIImage *)image shareType:(WHQQShareType)shareType;

#pragma mark —————— 微信分享 ——————
+ (void)WXMakeShareTitle:(NSString *)title description:(NSString *)description webpageUrl:(NSString *)webpageUrl image:(UIImage *)image type:(int)type;

#pragma mark —————— 新浪微博分享 ——————
+ (void)SinaWeiBoMakeShareText:(NSString *)text image:(UIImage *)image objectID:(NSString *)objectID title:(NSString *)title description:(NSString *)description thumbImage:(UIImage *)thumbImage webpageUrl:(NSString *)webpageUrl;

@end
