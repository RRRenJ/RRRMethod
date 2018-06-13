//
//  RRRTextField.h
//  RAC&MVVM
//
//  Created by 任敬 on 2017/6/30.
//  Copyright © 2017年 任敬. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface RRRTextField : UITextField


@property (nonatomic, strong)IBInspectable UIImage * leftImage;


/**
 输入框

 @param frame frame
 @param style borderStyle
 @param type KeyboardType
 @param returnType return键类型
 @param string 输入提示
 @param isSecret 是否密文显示
 @param isClear 是否一键删除
 @return RRRTextField
 */
+ (RRRTextField *)createTFWithFrame:(CGRect)frame type:(UITextBorderStyle)style keyboardType:(UIKeyboardType)type returnType:(UIReturnKeyType)returnType plesHolder:(NSString *)string secret:(BOOL)isSecret clearButtonMode:(BOOL)isClear;

@end
