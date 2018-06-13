//
//  RRRSlider.h
//  LuminousWisdom
//
//  Created by 任敬 on 2017/9/12.
//  Copyright © 2017年 任敬. All rights reserved.
//

#import <UIKit/UIKit.h>


IB_DESIGNABLE

@interface RRRSlider : UISlider

@property (nonatomic, strong)IBInspectable UIImage * leftTrack;
@property (nonatomic, strong)IBInspectable UIImage * rightTrack;
@property (nonatomic, strong)IBInspectable UIImage * thumbTrack;

@end
