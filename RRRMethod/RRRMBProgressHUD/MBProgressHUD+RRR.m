//
//  MBProgressHUD+RRR.m
//  RRRMethodDemo
//
//  Created by 任敬 on 2018/6/11.
//  Copyright © 2018年 任敬. All rights reserved.
//

#import "MBProgressHUD+RRR.h"

@implementation MBProgressHUD (RRR)
/**
 *  显示信息
 *
 *  @param text 信息内容
 *  @param icon 图标
 *  @param view 显示的视图
 */
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.label.text = text;
    hud.label.font = [UIFont boldSystemFontOfSize:15];
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [[UIColor blackColor] colorWithAlphaComponent:0.7f];
    hud.margin = 15;
    if (icon) {
        // 设置图片
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", icon]]];
        hud.minSize = CGSizeMake(160, 90);
    }
    if (!([UIApplication sharedApplication].keyWindow)) {
        hud.offset= CGPointMake(0, -TopHeight);
    }
   
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:1];
}

/**
 显示信息

 @param message 信息内容
 */
+ (void)showMessage:(NSString *)message{
    [self showMessage:message toView:nil ];
}

+ (void)showMessage:(NSString *)message toView:(UIView *)view{
    if (!view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    [self hideHUDForView:view];
    [self show:message icon:nil view:view];
}


/**
 *  显示成功信息
 *
 *  @param success 信息内容
 */
+ (void)showSuccess:(NSString *)success
{
    [self showSuccess:success toView:nil];
}

/**
 *  显示成功信息
 *
 *  @param success 信息内容
 *  @param view    显示信息的视图
 */
+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    if (!view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    [self hideHUDForView:view];
    
    [self show:success icon:@"RRRMBProgressHUD.bundle/success.png" view:view];
}

/**
 *  显示错误信息
 *
 */
+ (void)showError:(NSString *)error
{
    [self showError:error toView:nil];
}

/**
 *  显示错误信息
 *
 *  @param error 错误信息内容
 *  @param view  需要显示信息的视图
 */
+ (void)showError:(NSString *)error toView:(UIView *)view{
    if (!view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    [self hideHUDForView:view];
    
    [self show:error icon:@"RRRMBProgressHUD.bundle/error.png" view:view];
}

/**
 *  显示错误信息
 *
 *  @param message 信息内容
 *
 *  @return 直接返回一个MBProgressHUD，需要手动关闭
 */
+ (MBProgressHUD *)showProgressMessage:(NSString *)message
{
    return [self showProgressMessage:message toView:nil];
}

/**
 *  显示一些信息
 *
 *  @param message 信息内容
 *  @param view    需要显示信息的视图
 *
 *  @return 直接返回一个MBProgressHUD，需要手动关闭
 */
+ (MBProgressHUD *)showProgressMessage:(NSString *)message toView:(UIView *)view {
    
    if (!view){
        view = [UIApplication sharedApplication].keyWindow;
    }
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.animationType = MBProgressHUDAnimationZoom;
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [[UIColor blackColor] colorWithAlphaComponent:0.7f];

    if (!(view == [UIApplication sharedApplication].keyWindow)) {
        hud.offset= CGPointMake(0, -TopHeight);
    }
    if (message.length > 0) {
        hud.minSize = CGSizeMake(180, 100);
        hud.label.text = message;
        hud.label.font = [UIFont boldSystemFontOfSize:15];
    }
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;

    return hud;
}




+ (MBProgressHUD *)showLoadingProgressMessage:(NSString *)message{
    return [self showLoadingProgressMessage:message toView:nil];
}

+ (MBProgressHUD *)showLoadingProgressMessage:(NSString *)message toView:(UIView *)view{
    if (!view){
        view = [UIApplication sharedApplication].keyWindow;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [[UIColor blackColor] colorWithAlphaComponent:0.7f];
    if (message.length > 0) {
        hud.minSize = CGSizeMake(180, 100);
        hud.label.text = message;
        hud.label.font = [UIFont boldSystemFontOfSize:15];
    }
    return hud;
}






/**
 *  手动关闭MBProgressHUD
 */
+ (void)hideHUD
{
    [self hideHUDForView:nil];
}

/**
 *  手动关闭MBProgressHUD
 *
 *  @param view    显示MBProgressHUD的视图
 */
+ (void)hideHUDForView:(UIView *)view
{
    
    if (!view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    [self hideHUDForView:view animated:YES];
}


@end
