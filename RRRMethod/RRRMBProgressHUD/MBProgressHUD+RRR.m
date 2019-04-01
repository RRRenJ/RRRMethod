//
//  MBProgressHUD+RRR.m
//  RRRMethodDemo
//
//  Created by 任敬 on 2018/6/11.
//  Copyright © 2018年 任敬. All rights reserved.
//

#import "MBProgressHUD+RRR.h"
#import "RRRMethodConfige.h"
#import "VKMsgSend.h"
#import <objc/runtime.h>



@implementation MBProgressHUD (RRR)
/**
 *  显示信息
 *
 *  @param text 信息内容
 *  @param icon 图标
 *  @param view 显示的视图
 */
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view{
    
     MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
     hud.mode = MBProgressHUDModeCustomView;
    //判断MB版本是否大于1.0
    if ([self containsProperty:@"label"]) {
        [hud setValue:text forKeyPath:@"label.text"];
        [hud setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"label.font"];
        [hud setValue:[UIColor whiteColor] forKey:@"contentColor"];
        [hud setValue:[NSNumber numberWithInteger:0] forKeyPath:@"bezelView.style"];
        [hud setValue:[[UIColor blackColor] colorWithAlphaComponent:0.7f] forKeyPath:@"bezelView.color"];
        if (!([UIApplication sharedApplication].keyWindow)) {
            [hud setValue:[NSValue valueWithCGPoint:CGPointMake(0, -TopHeight)] forKey:@"offset"];
        }
        hud.margin = 15;
        if (icon) {
            // 设置图片
            hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
            hud.minSize = CGSizeMake(160, 90);
        }
        hud.removeFromSuperViewOnHide = YES;
        [hud VKCallSelector:@selector(hide:afterDelay:) error:nil,YES,1.f];
    }else{
        [hud setValue:text forKey:@"labelText"];
        [hud setValue:[UIFont boldSystemFontOfSize:15] forKey:@"labelFont"];
        if (!([UIApplication sharedApplication].keyWindow)) {
            [hud setValue:[NSNumber numberWithFloat: -TopHeight] forKey:@"yOffset"];
        }
        hud.margin = 15;
        if (icon) {
            // 设置图片
            hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
            hud.minSize = CGSizeMake(160, 90);
        }
        hud.removeFromSuperViewOnHide = YES;
        [hud VKCallSelector:@selector(hide:afterDelay:) error:nil,YES,1.f];
    }
}



+ (void)xxx:(NSString *)errr bools:(BOOL)ee{
    NSLog(@"%@   %d",errr,ee);
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
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.animationType = MBProgressHUDAnimationZoom;
    if ([self containsProperty:@"label"]) {
        [hud setValue:message forKeyPath:@"label.text"];
        [hud setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"label.font"];
        [hud setValue:[UIColor whiteColor] forKey:@"contentColor"];
        [hud setValue:[NSNumber numberWithInteger:0] forKeyPath:@"bezelView.style"];
        [hud setValue:[[UIColor blackColor] colorWithAlphaComponent:0.7f] forKeyPath:@"bezelView.color"];
        if (!([UIApplication sharedApplication].keyWindow)) {
            [hud setValue:[NSValue valueWithCGPoint:CGPointMake(0, -TopHeight)] forKey:@"offset"];
        }
    }else{
        [hud setValue:message forKey:@"labelText"];
        [hud setValue:[UIFont boldSystemFontOfSize:15] forKey:@"labelFont"];
        if (!(view == [UIApplication sharedApplication].keyWindow)) {
            hud.yOffset=  -TopHeight;
        }
    }
    if (message.length > 0) {
        hud.minSize = CGSizeMake(180, 100);
    }
    hud.margin = 15;
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
    //判断MB版本是否大于1.0
    if ([self containsProperty:@"label"]) {
        [hud setValue:message forKeyPath:@"label.text"];
        [hud setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"label.font"];
        [hud setValue:[UIColor whiteColor] forKey:@"contentColor"];
        [hud setValue:[NSNumber numberWithInteger:0] forKeyPath:@"bezelView.style"];
        [hud setValue:[[UIColor blackColor] colorWithAlphaComponent:0.7f] forKeyPath:@"bezelView.color"];
        if (!([UIApplication sharedApplication].keyWindow)) {
            [hud setValue:[NSValue valueWithCGPoint:CGPointMake(0, -TopHeight)] forKey:@"offset"];
        }
    }else{
        [hud setValue:message forKey:@"labelText"];
        [hud setValue:[UIFont boldSystemFontOfSize:15] forKey:@"labelFont"];
        if (!([UIApplication sharedApplication].keyWindow)) {
            [hud setValue:[NSNumber numberWithFloat: -TopHeight] forKey:@"yOffset"];
        }
    }
    if (message.length > 0) {
        hud.minSize = CGSizeMake(180, 100);
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


- (void)hideHUD{
    [self hideHUDForView:nil];
}

- (void)hideHUDForView:(UIView *)view{
    if (!view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    //判断MB版本是否大于1.0
    if ([MBProgressHUD containsProperty:@"label"]) {
        [self VKCallSelector:@selector(hideHUDForView:animated:) error:nil,view,YES];
    }else{
        [self hide:YES];
    }
}



+ (NSArray *)getPropertys{
    
    // 获取当前类的所有属性
    unsigned int count;// 记录属性个数
    objc_property_t *properties = class_copyPropertyList(self, &count);
    // 遍历
    NSMutableArray *mArray = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        
        // An opaque type that represents an Objective-C declared property.
        // objc_property_t 属性类型
        objc_property_t property = properties[i];
        // 获取属性的名称 C语言字符串
        const char *cName = property_getName(property);
        // 转换为Objective C 字符串
        NSString *name = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
        [mArray addObject:name];
    }
    
    return mArray.copy;
}

+ (BOOL)containsProperty:(NSString *)property{
    NSArray * propertys = [self getPropertys];
    return [propertys containsObject:property];
}


@end
