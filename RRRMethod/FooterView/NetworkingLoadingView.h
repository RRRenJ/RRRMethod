//
//  NetworkingLoadingView.h
//  RRRMethodDemo
//
//  Created by 任敬 on 2018/6/13.
//  Copyright © 2018年 任敬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RRRLabel.h"

typedef void(^LoadingViewClickBlock)(void);

@interface NetworkingLoadingView : UIView

@property (nonatomic, strong, readonly) UIImageView * loadingImgView;

@property (nonatomic, copy) RRRLabel * loadingRemindLb;

@property (nonatomic, copy) LoadingViewClickBlock clickBlock;

@end
