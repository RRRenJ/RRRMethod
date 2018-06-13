//
//  RRRLabel.m
//  Store
//
//  Created by 任敬 on 2017/7/5.
//  Copyright © 2017年 任敬. All rights reserved.
//

#import "RRRLabel.h"

@implementation RRRLabel

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        self.text = @"";
        self.textColor = [UIColor blackColor];
        self.font = [UIFont systemFontOfSize:16];
    }
    return self;
}


+ (RRRLabel *)createLbWithText:(NSString *)text textColor:(UIColor *)textColor textFont:(CGFloat)fontSize textAlignment:(NSTextAlignment)textAlignment{
    RRRLabel * label = [[RRRLabel alloc]init];
    label.text = text;
    label.textColor = textColor;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textAlignment = textAlignment;
    
    return label;
}


+ (RRRLabel *)createLbWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor textFont:(CGFloat)fontSize textAlignment:(NSTextAlignment)textAlignment{
    
    RRRLabel * label = [RRRLabel createLbWithText:text textColor:textColor textFont:fontSize textAlignment:textAlignment];
    label.frame = frame;
    return label;
    
}




@end
