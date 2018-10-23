//
//  WHSharePlatformView.m
//  BinFengExpressOwner
//
//  Created by 邓伟浩 on 2018/10/20.
//  Copyright © 2018年 BinFeng. All rights reserved.
//

#import "WHSharePlatformView.h"

@interface WHSharePlatformView ()

@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) NSMutableArray *imageViewArray;

@property (nonatomic, strong) UIView *backContentView;

@end

@implementation WHSharePlatformView

- (instancetype)initWithImageArray:(NSArray *)imageArray {
    if (self = [super initWithFrame:CGRectZero]) {
        _imageArray = imageArray;
        [self setUpUI];
    }
    return self;
}

- (NSMutableArray *)imageViewArray {
    if (!_imageViewArray) {
        _imageViewArray = @[].mutableCopy;
    }
    return _imageViewArray;
}

- (void)setUpUI {
    
    [self addSubview:({
        _backContentView = [[UIView alloc] init];
        _backContentView;
    })];
    [_backContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    CGFloat imageWidth = kRealwidth(44);
    for (int i = 0; i < _imageArray.count; i++) {
        
        UIImageView *imageView;
        [_backContentView addSubview:({
            imageView = [[UIImageView alloc] init];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView.image = IMAGE_NAMED([_imageArray objectAtIndex:i]);
            imageView.userInteractionEnabled = YES;
            imageView.tag = 10 + i;
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClicked:)];
            [imageView addGestureRecognizer:tap];
            [self.imageViewArray addObject:imageView];
            
            imageView;
        })];
    }
    
    // 水平固定控件宽度
    [self.imageViewArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:kRealwidth(44) leadSpacing:kRealwidth(44) tailSpacing:kRealwidth(44)];
    
    // 垂直方向约束
    [self.imageViewArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_backContentView.mas_centerY);
        make.height.mas_equalTo(imageWidth);
    }];
    
}

- (void)tapClicked:(UITapGestureRecognizer *)tap {
    int index = (int)tap.view.tag - 10;
    if (self.clicked) {
        self.clicked(index);
    }
}


@end
