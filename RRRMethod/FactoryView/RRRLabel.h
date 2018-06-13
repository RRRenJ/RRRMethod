//
//  RRRLabel.h
//  Store
//
//  Created by 任敬 on 2017/7/5.
//  Copyright © 2017年 任敬. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RRRLabel : UILabel



+ (RRRLabel *)createLbWithText:(NSString *)text textColor:(UIColor *)textColor textFont:(CGFloat)fontSize textAlignment:(NSTextAlignment)textAlignment;


+ (RRRLabel *)createLbWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor textFont:(CGFloat)fontSize textAlignment:(NSTextAlignment)textAlignment;

@end
