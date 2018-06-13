//
//  RRRSlider.m
//  LuminousWisdom
//
//  Created by 任敬 on 2017/9/12.
//  Copyright © 2017年 任敬. All rights reserved.
//

#import "RRRSlider.h"

@implementation RRRSlider


- (void)setLeftTrack:(UIImage *)leftTrack{
    [self setMinimumTrackImage:leftTrack forState:UIControlStateNormal];
}

- (void)setRightTrack:(UIImage *)rightTrack{
    [self setMaximumTrackImage:rightTrack forState:UIControlStateNormal];
}

- (void)setThumbTrack:(UIImage *)thumbTrack{
    [self setThumbImage:thumbTrack forState:UIControlStateNormal];
    [self setThumbImage:thumbTrack forState:UIControlStateHighlighted];
}

- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value
{
    rect.origin.x = rect.origin.x - 10 ;
    rect.size.width = rect.size.width +20;
    return CGRectInset ([super thumbRectForBounds:bounds trackRect:rect value:value], 10 , 10);
}

@end
