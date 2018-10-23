//
//  WHSharePlatformView.h
//  BinFengExpressOwner
//
//  Created by 邓伟浩 on 2018/10/20.
//  Copyright © 2018年 BinFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clickedBlock)(int index);

@interface WHSharePlatformView : UIView

- (instancetype)initWithImageArray:(NSArray *)imageArray;

@property (nonatomic, copy) clickedBlock clicked;

@end
