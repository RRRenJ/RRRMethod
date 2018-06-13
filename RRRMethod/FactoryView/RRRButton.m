//
//  RRRButton.m
//  RAC&MVVM
//
//  Created by 任敬 on 2017/6/30.
//  Copyright © 2017年 任敬. All rights reserved.
//

#import "RRRButton.h"




@interface RRRButton ()



@end

@implementation RRRButton


- (void)setBoardColor:(UIColor *)boardColor{
    self.layer.borderColor = boardColor.CGColor;
}

- (void)setBoardWidth:(CGFloat)boardWidth{
    self.layer.borderWidth = boardWidth;
}


+ (RRRButton *)createBtWithType:(UIButtonType)type title:(NSString *)title titleColor:(UIColor *)titleColor btColor:(UIColor *)btColor{
    RRRButton * button = [RRRButton buttonWithType:type];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.backgroundColor = btColor;
    return button;
}


+ (RRRButton *)createBtWithFrame:(CGRect)frame type:(UIButtonType)type title:(NSString *)title titleColor:(UIColor *)titleColor btColor:(UIColor *)btColor{
    RRRButton * button = [RRRButton createBtWithType:type title:title titleColor:titleColor btColor:btColor];
    button.frame = frame;
    return  button;
}


+ (RRRButton *)createBtWithFrame:(CGRect)frame type:(UIButtonType)type title:(NSString *)title titleColor:(UIColor *)titleColor btColor:(UIColor *)btColor andTarget:(id)target action:(SEL)selection forControlEvents:(UIControlEvents)event{
    RRRButton * button = [RRRButton createBtWithFrame:frame type:type title:title titleColor:titleColor btColor:btColor];
    [button addTarget:target action:selection forControlEvents:event];
    return button;
}





@end
