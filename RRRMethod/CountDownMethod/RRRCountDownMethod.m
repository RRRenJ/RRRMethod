//
//  RRRCountDownMethod.m
//  RRRMethodDemo
//
//  Created by 任敬 on 2018/6/11.
//  Copyright © 2018年 任敬. All rights reserved.
//

#import "RRRCountDownMethod.h"

@interface RRRCountDownMethod ()

@property (nonatomic, assign) NSInteger seconds;

@property (nonatomic, assign) NSInteger totalSeconds;

@property (nonatomic, strong) NSTimer * timer;

@property (nonatomic, copy) NSString * startTitle;

@property (nonatomic, copy) NSString * waitTitle;

@property (nonatomic, copy) NSString * endTitle;

@property (nonatomic, strong) UIButton * button;

@end


@implementation RRRCountDownMethod

- (instancetype)initWithBt:(UIButton *)button startTitle:(NSString *)startTitle waitTitle:(NSString *)waitTitle endTitle:(NSString *)endTitle totalTime:(NSInteger)totalTime{
    self = [super init];
    if (self) {
        self.startTitle = startTitle;
        self.waitTitle = waitTitle;
        self.endTitle = endTitle;
        self.totalSeconds = totalTime;
        self.button = button;
        [self.button setTitle:self.startTitle forState:UIControlStateNormal];
    }
    return self;

}

- (void)send{
    self.button.enabled = NO;
    [self.button setTitle:self.waitTitle forState:UIControlStateDisabled];
}


- (void)sending{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    self.seconds = self.totalSeconds;
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)resend{
    self.button.enabled = YES;
    [self.button setTitle:self.endTitle forState:UIControlStateNormal];
}

- (void)stopCountDown{
    if (self.timer) {
        if ([self.timer isValid]) {
            [self.timer invalidate];
            self.seconds =self.totalSeconds;
            self.timer = nil;
            [self resend];
        }
    }
}

- (void)countDown{
    NSString *title = [NSString stringWithFormat:@"%zds",self.seconds];
    [self.button setTitle:title forState:UIControlStateDisabled];
    self.button.enabled = NO;
    if (self.seconds <= 0) {
        [self stopCountDown];
        return;
    }
    self.seconds -- ;
}



@end

