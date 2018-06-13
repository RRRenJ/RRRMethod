//
//  RRRButton.h
//  RAC&MVVM
//
//  Created by 任敬 on 2017/6/30.
//  Copyright © 2017年 任敬. All rights reserved.
//

#import <UIKit/UIKit.h>


IB_DESIGNABLE
@interface RRRButton : UIButton

@property (nonatomic, assign)IBInspectable CGFloat boardWidth;
@property (nonatomic, assign)IBInspectable UIColor * boardColor;


/**
 按键

 @param type 按键类型
 @param title 按键名称
 @param titleColor 文字颜色
 @param btColor 按键颜色
 @return RRRBt
 */
+ (RRRButton *)createBtWithType:(UIButtonType)type title:(NSString *)title titleColor:(UIColor *)titleColor btColor:(UIColor *)btColor;

/**
 按键

 @param frame frame
 @param type 按键类型
 @param title 按键名称
 @param titleColor 文字颜色
 @param btColor 按键颜色
 @return RRRBt
 */
+ (RRRButton *)createBtWithFrame:(CGRect)frame type:(UIButtonType)type title:(NSString *)title titleColor:(UIColor *)titleColor btColor:(UIColor *)btColor;


+ (RRRButton *)createBtWithFrame:(CGRect)frame type:(UIButtonType)type title:(NSString *)title titleColor:(UIColor *)titleColor btColor:(UIColor *)btColor andTarget:(id)target action:(SEL)selection forControlEvents:(UIControlEvents)event;



@end
