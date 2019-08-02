//
//  UICollectionView+FooterView.h
//  RRRMethodDemo
//
//  Created by 任敬 on 2019/8/2.
//  Copyright © 2019 任敬. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView (FooterView)

- (void)footerViewWithEmptyView;

- (void)footerViewWithImageName:(NSString *)imageName andFrame:(CGRect)frame andY:(CGFloat)y;
- (void)footerViewWithString:(NSString *)string andFrame:(CGRect)frame andY:(CGFloat)y;
- (void)footerViewWithImageName:(NSString *)imageName andImageFrame:(CGRect)imageFrame andString:(NSString *)string andStringFrame:(CGRect)stringFrame andY:(CGFloat)y;

- (void)footerViewWithCustomView:(UIView *)customView;

@end

NS_ASSUME_NONNULL_END
