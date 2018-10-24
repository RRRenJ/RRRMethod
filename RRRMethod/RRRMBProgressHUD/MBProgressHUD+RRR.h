//
//  MBProgressHUD+RRR.h
//  RRRMethodDemo
//
//  Created by 任敬 on 2018/6/11.
//  Copyright © 2018年 任敬. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (RRR)

+ (void)showMessage:(NSString *)message;
+ (void)showMessage:(NSString *)message toView:(UIView *)view;

+ (void)showSuccess:(NSString *)success;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;

+ (void)showError:(NSString *)error;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)showProgressMessage:(NSString *)message;
+ (MBProgressHUD *)showProgressMessage:(NSString *)message toView:(UIView *)view;

+ (MBProgressHUD *)showLoadingProgressMessage:(NSString *)message;
+ (MBProgressHUD *)showLoadingProgressMessage:(NSString *)message  toView:(UIView *)view;

+ (void)hideHUD;
+ (void)hideHUDForView:(UIView *)view;

- (void)hideHUD;
- (void)hideHUDForView:(UIView *)view;

@end
