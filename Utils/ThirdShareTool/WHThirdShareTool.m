//
//  WHThirdShareTool.m
//  BinFengExpressOwner
//
//  Created by 邓伟浩 on 2018/10/22.
//  Copyright © 2018年 BinFeng. All rights reserved.
//

#import "WHThirdShareTool.h"

#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/QQApiInterfaceObject.h>
#import "WXApi.h"
#import "WeiboSDK.h"
#import "WHAppDelegate.h"

@implementation WHThirdShareTool

#pragma mark —————— QQ分享 ——————

+ (void)handleSendResult:(QQApiSendResultCode)sendResult {
    NSString *errorMsg = @"";
    switch (sendResult) {
        case EQQAPISENDSUCESS:
            errorMsg = @"成功";
            break;
        case EQQAPIAPPNOTREGISTED:
            errorMsg = @"App未注册";
            break;
        case EQQAPIMESSAGECONTENTINVALID:
        case EQQAPIMESSAGECONTENTNULL:
        case EQQAPIMESSAGETYPEINVALID:
            errorMsg = @"发送参数错误";
            break;
        case EQQAPIQQNOTINSTALLED:
            errorMsg = @"未安装手Q";
            break;
        case EQQAPIQQNOTSUPPORTAPI:
            errorMsg = @"API接口不支持";
            break;
        case EQQAPISENDFAILD:
            errorMsg = @"发送失败";
            break;
        case EQQAPIVERSIONNEEDUPDATE:
            errorMsg = @"当前QQ版本太低，需要更新";
            break;
        default:
            errorMsg = @"未知错误!";
            break;
    }
    DLog(@"errorMsg = %@", errorMsg);
}

+ (void)QQMakeShare:(QQBaseReq *)req shareType:(WHQQShareType)shareType {
    
    if (shareType == WHQQShareTypeToQQ) { // 将内容分享到QQ
        QQApiSendResultCode sent = [QQApiInterface sendReq:req];
        [self handleSendResult:sent];
    } else if (shareType == WHQQShareTypeToQZone) { // 将内容分享到qzone
        QQApiSendResultCode sent = [QQApiInterface SendReqToQZone:req];
        [self handleSendResult:sent];
    }
}


/** 纯文本分享
 *  [WHThirdShareTool QQMakeShareText:@"文本分享测试"];
 */
+ (void)QQMakeShareText:(NSString *)text {
    QQApiTextObject *txtObj = [QQApiTextObject objectWithText:text];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:txtObj];
    [self QQMakeShare:req shareType:WHQQShareTypeToQQ];
}

/** 纯图片分享
 *  [WHThirdShareTool QQMakeShareTitle:@"测试标题" description:@"测试描述" image:IMAGE_NAMED(@"share_back_png")];
 */
+ (void)QQMakeShareTitle:(NSString *)title description:(NSString *)description image:(UIImage *)image {
    NSData *imgData = UIImagePNGRepresentation(image);
    QQApiImageObject *imgObj = [QQApiImageObject objectWithData:imgData
                                               previewImageData:imgData
                                                          title:title
                                                    description:description];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:imgObj];
    [self QQMakeShare:req shareType:WHQQShareTypeToQQ];
}

/** 新闻分享
 *  [WHThirdShareTool QQMakeShareNewsUrlStr:@"http://www.baidu.com" title:@"测试标题" description:@"测试描述" previewImageUrl:nil shareType:WHQQShareTypeToQQ];
 */
+ (void)QQMakeShareNewsUrlStr:(NSString *)urlStr title:(NSString *)title description:(NSString *)description previewImageUrl:(NSString *)previewImageUrl shareType:(WHQQShareType)shareType {
    QQApiNewsObject *newsObj = [QQApiNewsObject
                                objectWithURL:[NSURL URLWithString:urlStr]
                                title:title
                                description:description
                                previewImageURL:[NSURL URLWithString:previewImageUrl]];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
    [self QQMakeShare:req shareType:shareType];
}

/** 音乐分享 */
+ (void)QQMakeShareAudioUrlStr:(NSString *)urlStr title:(NSString *)title description:(NSString *)description previewImageUrl:(NSString *)previewImageUrl shareType:(WHQQShareType)shareType {
    QQApiAudioObject *audioObj =
    [QQApiAudioObject objectWithURL:[NSURL URLWithString:urlStr]
                              title:title
                        description:description
                    previewImageURL:[NSURL URLWithString:previewImageUrl]];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:audioObj];
    [self QQMakeShare:req shareType:shareType];
}

/** 视频分享 */
+ (void)QQMakeShareVideoUrlStr:(NSString *)urlStr title:(NSString *)title description:(NSString *)description previewImageUrl:(NSString *)previewImageUrl flashURL:(NSString *)flashURL image:(UIImage *)image shareType:(WHQQShareType)shareType {
    
    NSData *imgData = UIImagePNGRepresentation(image);
    QQApiVideoObject *videoObj = [QQApiVideoObject objectWithURL:[NSURL URLWithString:urlStr]
                                                           title:title
                                                     description:description
                                                previewImageData:imgData];
    [videoObj setFlashURL:[NSURL URLWithString:flashURL]];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:videoObj];
    [self QQMakeShare:req shareType:shareType];
}

#pragma mark —————— 微信分享 ——————
+ (void)WXMakeShareTitle:(NSString *)title description:(NSString *)description webpageUrl:(NSString *)webpageUrl image:(UIImage *)image type:(int)type {
    if ([WXApi isWXAppInstalled]) {
        SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc] init];
        
        sendReq.bText = NO; //不使用文本信息
        sendReq.scene = type; //0 = 好友列表 1 = 朋友圈 2 = 收藏
        
        // 创建分享内容对象
        WXMediaMessage *urlMessage = [WXMediaMessage message];
        
        urlMessage.title = title; //分享标题
        urlMessage.description = description; //分享描述
        [urlMessage setThumbImage:image];
        
        // 创建多媒体对象
        WXWebpageObject *webObj = [WXWebpageObject object];
        webObj.webpageUrl = webpageUrl; //分享链接
        
        // 完成发送对象实例
        urlMessage.mediaObject = webObj;
        sendReq.message = urlMessage;
        
        // 发送分享信息
        [WXApi sendReq:sendReq];
    } else {
//        [WHView showMessage:@"未安装微信!" inView:nil];
    }
}

#pragma mark —————— 新浪微博分享 ——————
+ (void)SinaWeiBoMakeShareText:(NSString *)text image:(UIImage *)image objectID:(NSString *)objectID title:(NSString *)title description:(NSString *)description thumbImage:(UIImage *)thumbImage webpageUrl:(NSString *)webpageUrl {
    
    WHAppDelegate *myDelegate = (WHAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = @"http://api.weibo.com/oauth2/default.html";
    authRequest.scope = @"all";
    
    WBMessageObject *message = [WBMessageObject message];
    message.text = text;
    
    if (image) {
        WBImageObject *imageObject = [WBImageObject object];
        imageObject.imageData = UIImagePNGRepresentation(image);
        message.imageObject = imageObject;
    } else {
        WBWebpageObject *webpage = [WBWebpageObject object];
        webpage.objectID = objectID;
        webpage.title = title;
        webpage.description = description;
        
        UIGraphicsBeginImageContext(CGSizeMake(thumbImage.size.width*0.5, thumbImage.size.height*0.5));
        [image drawInRect:CGRectMake(0, 0, thumbImage.size.width*0.5, thumbImage.size.height*0.5)];
        UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        NSData *resultThumbImageData =  UIImageJPEGRepresentation(resultImage, 0.5);
        long thumbImageSize = (long)(resultThumbImageData.length / 1024);
//        DLog(@"resultThumbImageDataLength: %ld k", (long)(resultThumbImageData.length / 1024));
        if (thumbImageSize < 32) {
            webpage.thumbnailData = resultThumbImageData;
        }
        
        webpage.webpageUrl = webpageUrl;
        message.mediaObject = webpage;
    }
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message authInfo:authRequest access_token:myDelegate.wbtoken];
    [WeiboSDK sendRequest:request];
    
}

@end
