//
//  RRRLoadView.h
//  RRRMethodDemo
//
//  Created by 任敬 on 2018/12/13.
//  Copyright © 2018 任敬. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//第一次请求数据时遮挡页面布局，避免没数据不好看,继承方式定制调用，使用默认请见UIViewController+RRRLoadingView
@interface RRRLoadView : NSObject
//设置背景颜色 默认f3f3f3
@property (nonatomic, strong) UIColor * backViewColor;
//定制等待view 没有默认
@property (nonatomic, strong) UIView * loadingView;
//定制失败view 没有默认
@property (nonatomic, strong) UIView * loadFailView;
//加载数据时调用
- (void)loadDataWithController:(UIViewController *)viewController;
//加载失败时调用
- (void)loadFail:(void(^)(UIButton * button))callBack;
//加载成功时调用
- (void)loadSucessWithController:(UIViewController *)viewController;


@end
