//
//  RRRTextField.m
//  RAC&MVVM
//
//  Created by 任敬 on 2017/6/30.
//  Copyright © 2017年 任敬. All rights reserved.
//

#import "RRRTextField.h"


@implementation RRRTextField


- (void)setLeftImage:(UIImage *)leftImage{
    UIImageView * leftImageView = [[UIImageView alloc]initWithImage:leftImage];
    self.leftView = leftImageView;
    self.leftViewMode = UITextFieldViewModeAlways;
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    CGRect iconRect = [super leftViewRectForBounds:bounds];
    iconRect.origin.x += 10; //像右边偏15
    return iconRect;
}

//UITextField 文字与输入框的距离
- (CGRect)textRectForBounds:(CGRect)bounds{
    
    return CGRectInset(bounds, 40, 0);
    
}

//控制文本的位置
- (CGRect)editingRectForBounds:(CGRect)bounds{
    
    return CGRectInset(bounds, 40, 0);
}

+ (RRRTextField *)createTFWithFrame:(CGRect)frame type:(UITextBorderStyle)style keyboardType:(UIKeyboardType)type returnType:(UIReturnKeyType)returnType plesHolder:(NSString *)string secret:(BOOL)isSecret clearButtonMode:(BOOL)isClear{
    
    RRRTextField * textField = [[RRRTextField alloc]init];
    textField.frame = frame;
    textField.borderStyle = style;
    textField.keyboardType = type;
    textField.returnKeyType = returnType;
    textField.placeholder = string;
    textField.secureTextEntry = isSecret;
    textField.clearButtonMode = isClear;
    return textField;
}


@end
