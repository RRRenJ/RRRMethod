//
//  UICollectionView+FooterView.m
//  RRRMethodDemo
//
//  Created by 任敬 on 2019/8/2.
//  Copyright © 2019 任敬. All rights reserved.
//

#import "UICollectionView+FooterView.h"
#import <objc/runtime.h>
#import "RRRMethodConfige.h"
#import "RRRLabel.h"

static const void * footerViewKey = &footerViewKey;

@interface UICollectionView ()

@property (nonatomic, strong) UIView * footerView;

@end


@implementation UICollectionView (FooterView)


- (void)footerViewWithEmptyView{
    [self.footerView removeFromSuperview];
}


- (void)footerViewWithImageName:(NSString *)imageName andFrame:(CGRect)frame andY:(CGFloat)y{
    UIView * errorView ;
    if (self.footerView) {
        errorView = self.footerView;
    }else{
        errorView =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCR_WIDTH, SCR_HEIGHT/3)];
        self.footerView = errorView;
    }
    UIImageView * errorImageView = [[UIImageView alloc]init];
    [errorView addSubview:errorImageView];
    errorImageView.image = [UIImage imageNamed:imageName];
    errorImageView.frame = frame;
    [self addSubview:errorView];
}

- (void)footerViewWithString:(NSString *)string andFrame:(CGRect)frame andY:(CGFloat)y{
    UIView * errorView ;
    if (self.footerView) {
        errorView = self.footerView;
    }else{
        errorView =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCR_WIDTH, SCR_HEIGHT/3)];
        self.footerView = errorView;
    }
    RRRLabel * remindLabel = [RRRLabel createLbWithText:string textColor:GRAY_TEXT_COLOR textFont:14 textAlignment:NSTextAlignmentCenter];
    [errorView addSubview:remindLabel];
    remindLabel.frame = frame;
    [self addSubview:errorView];
}

- (void)footerViewWithImageName:(NSString *)imageName andImageFrame:(CGRect)imageFrame andString:(NSString *)string andStringFrame:(CGRect)stringFrame andY:(CGFloat)y{
    UIView * errorView ;
    if (self.footerView) {
        errorView = self.footerView;
    }else{
        errorView =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCR_WIDTH, SCR_HEIGHT/3)];
        self.footerView = errorView;
    }
    UIImageView * errorImageView = [[UIImageView alloc]init];
    [errorView addSubview:errorImageView];
    errorImageView.image = [UIImage imageNamed:imageName];
    RRRLabel * remindLabel = [RRRLabel createLbWithText:string textColor:GRAY_TEXT_COLOR textFont:14 textAlignment:NSTextAlignmentCenter];
    [errorView addSubview:remindLabel];
    errorImageView.frame = imageFrame;
    remindLabel.frame = stringFrame;
    [self addSubview:errorView];
}


- (void)footerViewWithCustomView:(UIView *)customView{
    [self addSubview:customView];
    self.footerView = customView;
}


- (UIView *)footerView{
    return objc_getAssociatedObject(self, footerViewKey);
}

- (void)setLoadingView:(UIView *)footerView{
    return objc_setAssociatedObject(self, footerViewKey, footerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
