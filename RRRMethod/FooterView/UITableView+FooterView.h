//
//  UITableView+FooterView.h
//  Store
//
//  Created by 任敬 on 2017/7/5.
//  Copyright © 2017年 任敬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (FooterView)

- (void)footerViewWithEmptyView;
- (void)footerViewWithEmptyViewAlliPhone;

- (void)footerViewWithImageName:(NSString *)imageName andFrame:(CGRect)frame;
- (void)footerViewWithString:(NSString *)string andFrame:(CGRect)frame;
- (void)footerViewWithImageName:(NSString *)imageName andImageFrame:(CGRect)imageFrame andString:(NSString *)string andStringFrame:(CGRect)stringFrame;

- (void)footerViewWithCustomView:(UIView *)customView;

@end
