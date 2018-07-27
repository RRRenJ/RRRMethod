//
//  RRRCountDownMethod.h
//  RRRMethodDemo
//
//  Created by 任敬 on 2018/6/11.
//  Copyright © 2018年 任敬. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RRRCountDownMethod : NSObject

- (instancetype)initWithBt:(UIButton *)button startTitle:(NSString *)startTitle  waitTitle:(NSString *)waitTitle endTitle:(NSString *)endTitle totalTime:(NSInteger )totalTime;
//点击按键后调用
- (void)send;
//请求成功调用
- (void)sending;
//请求失败调用
- (void)resend;


@end
