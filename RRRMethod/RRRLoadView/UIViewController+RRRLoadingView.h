//
//  UIViewController+RRRLoadingView.h
//  RRRCategoryDemo
//
//  Created by 任敬 on 2018/12/13.
//  Copyright © 2018 任敬. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^LoadActionCallBack)(UIButton *button);

@interface UIViewController (RRRLoadingView)

- (void)loadDataWithRemind:(nullable NSString *)remind onWindow:(BOOL)isOn;

- (void)loadDataFullScreenWithRemind:(nullable NSString *)remind showCancelBt:(BOOL)isShow cancelBtTitle:(nullable NSString *)title cancel:(LoadActionCallBack)callBack;

- (void)loadFail:(LoadActionCallBack)callBack andRemind:(nullable NSString *)remind;

- (void)loadSucess;

@end

NS_ASSUME_NONNULL_END
