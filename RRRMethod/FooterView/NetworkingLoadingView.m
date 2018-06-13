//
//  NetworkingLoadingView.m
//  RRRMethodDemo
//
//  Created by 任敬 on 2018/6/13.
//  Copyright © 2018年 任敬. All rights reserved.
//

#import "NetworkingLoadingView.h"
#import "RRRMethodConfige.h"

@interface NetworkingLoadingView()

@property (nonatomic, strong) UIImageView * loadingImgView;

@end


@implementation NetworkingLoadingView



- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:243.f/255.f green:243.f/255.f blue:243.f/255.f alpha:1];
        self.frame = CGRectMake(0, 0, SCR_WIDTH, SCR_HEIGHT- TopHeight);
        self.userInteractionEnabled = YES;
        [self addSubview:self.loadingImgView];
        [self addSubview:self.loadingRemindLb];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClicked:)];
        [self addGestureRecognizer:tap];
        
    }
    return self;
}


- (void)tapClicked:(UITapGestureRecognizer *)sender{
    if (self.clickBlock) {
        self.clickBlock();
    }
}


- (UIImageView *)loadingImgView{
    if (!_loadingImgView) {
        _loadingImgView = [[UIImageView alloc]init];
        _loadingImgView.frame = CGRectMake(SCR_WIDTH/2 - 75, 200, 150, 75);
        _loadingImgView.image = [UIImage imageNamed:@"NetworkingLoadingView.bundle/NetworkingBad.png"];
        _loadingImgView.userInteractionEnabled = YES;
    }
    return _loadingImgView;
}

- (RRRLabel *)loadingRemindLb{
    if (!_loadingRemindLb) {
        _loadingRemindLb = [RRRLabel createLbWithText:@"网络不给力，点击屏幕重试" textColor:[UIColor grayColor] textFont:14 textAlignment:NSTextAlignmentCenter];
        _loadingRemindLb.frame = CGRectMake(15, CGRectGetMaxY(self.loadingImgView.frame)+20, SCR_WIDTH - 30, 30);
        _loadingRemindLb.userInteractionEnabled = YES;
    }
    return _loadingRemindLb;
}

@end
