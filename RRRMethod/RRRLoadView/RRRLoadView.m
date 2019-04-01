//
//  RRRLoadView.m
//  RRRMethodDemo
//
//  Created by 任敬 on 2018/12/13.
//  Copyright © 2018 任敬. All rights reserved.
//

#import "RRRLoadView.h"
#import "RRRMethodConfige.h"
#define RRRLOAD_RGB(R,G,B,A) [UIColor colorWithRed:R/256.f green:B/256.f blue:G/256.f alpha:A/1.f]

@interface RRRLoadView ()

@property (nonatomic, strong) UIView * loadingBackView;

@end

@implementation RRRLoadView

#pragma mark - public
- (void)loadDataWithController:(UIViewController *)viewController onWindow:(BOOL)on{
    if (self.backViewColor) {
        self.loadingBackView.backgroundColor = self.backViewColor;
    }
    
    if (on) {
        UIWindow * window = [UIApplication sharedApplication].keyWindow;
        if (![window.subviews containsObject:self.loadingBackView]) {
            
            CGFloat y = 0;
            CGFloat height = SCR_HEIGHT;
            if (viewController.navigationController) {
                y = TopHeight;
                height = height - TopHeight;
            }
            if (viewController.tabBarController) {
                height = height - TabBarHeight;
            }
            
            if (viewController.navigationController.tabBarController) {
                if ((height != SCR_HEIGHT - TopHeight - TabBarHeight) && (height != SCR_HEIGHT - TabBarHeight)) {
                    height = height - TabBarHeight;
                }
            }
            self.loadingBackView.frame = CGRectMake(0, y, SCR_WIDTH, height);
            [window addSubview:self.loadingBackView];
        }
    }else{
        if (![viewController.view.subviews containsObject:self.loadingBackView]) {
            [viewController.view addSubview:self.loadingBackView];
        }
        if ([viewController.view isKindOfClass:[UITableView class]]) {
            UITableView * view = (UITableView *)viewController.view;
            view.scrollEnabled = NO;
        }
        if ([viewController.view isKindOfClass:[UICollectionView class]]) {
            UICollectionView * view = (UICollectionView *)viewController.view;
            view.scrollEnabled = NO;
        }
        if ([viewController.view isKindOfClass:[UIScrollView class]]) {
            UIScrollView * view = (UIScrollView *)viewController.view;
            view.scrollEnabled = NO;
        }
    }
    if (self.loadingView && ![self.loadingBackView.subviews containsObject:self.loadingView]) {
        [self.loadingBackView addSubview:self.loadingView];
    }
    
}

- (void)loadFail:(void (^)(UIButton *))callBack{
     [self.loadingView removeFromSuperview];
    if (![self.loadingBackView.subviews containsObject:self.loadFailView] && self.loadFailView) {
        [self.loadingBackView addSubview:self.loadFailView];
    }
}


- (void)loadSucessWithController:(UIViewController *)viewController{
    if ([viewController.view isKindOfClass:[UITableView class]]) {
        UITableView * view = (UITableView *)viewController.view;
        view.scrollEnabled = YES;
    }
    if ([viewController.view isKindOfClass:[UICollectionView class]]) {
        UICollectionView * view = (UICollectionView *)viewController.view;
        view.scrollEnabled = YES;
    }
    if ([viewController.view isKindOfClass:[UIScrollView class]]) {
        UIScrollView * view = (UIScrollView *)viewController.view;
        view.scrollEnabled = YES;
    }
    [self.loadingBackView removeFromSuperview];
}



#pragma mark - private

#pragma mark - set

#pragma mark - get

- (UIView *)loadingBackView{
    if (!_loadingBackView) {
        _loadingBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCR_WIDTH, SCR_HEIGHT)];
        _loadingBackView.backgroundColor = BACKGROUND_COLOR;
    }
    return _loadingBackView;
}

@end
