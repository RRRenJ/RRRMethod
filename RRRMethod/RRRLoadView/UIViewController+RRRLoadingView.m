//
//  UIViewController+RRRLoadingView.m
//  RRRCategoryDemo
//
//  Created by 任敬 on 2018/12/13.
//  Copyright © 2018 任敬. All rights reserved.
//

#import "UIViewController+RRRLoadingView.h"
#import <objc/runtime.h>
#define LOAD_RGB(R,G,B,A) [UIColor colorWithRed:R/256.f green:B/256.f blue:G/256.f alpha:A/1.f]
#define LOAD_WIDTH [UIScreen mainScreen].bounds.size.width
#define LOAD_HEIGHT [UIScreen mainScreen].bounds.size.height
#define LOAD_STATUS_BAR_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height
#define LOAD_IS_BANG LOAD_STATUS_BAR_HEIGHT > 20
#define LOAD_BOTTOM_HEIGHT (LOAD_STATUS_BAR_HEIGHT >20?34:0)
#define LOAD_TOP_HEIGHT (LOAD_STATUS_BAR_HEIGHT + 44)

static const void * loadingViewKey = &loadingViewKey;
static const void * loadFailViewKey = &loadFailViewKey;
static const void * loadingBackViewKey = &loadingBackViewKey;
static const void * loadActionCallBackKey = &loadActionCallBackKey;
static const void * loadingRemindKey = &loadingRemindKey;
static const void * onWindowsKey = &onWindowsKey;


@interface UIViewController ()


@property (nonatomic, strong) UIView * loadingBackView;

@property (nonatomic, strong) UIView * loadingView;

@property (nonatomic, strong) UIView * loadFailView;

@property (nonatomic, copy) NSString * loadingRemind;

@property (nonatomic, strong) NSNumber * onWindows;

//@property (nonatomic, copy) NSString * loadFailRemind;


@end


@implementation UIViewController (RRRLoadingView)


- (void)loadDataWithRemind:(nullable NSString *)remind onWindow:(BOOL)isOn{
    if (!self.loadingBackView) {
        self.loadingBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, LOAD_WIDTH, LOAD_HEIGHT)];
        self.loadingBackView.backgroundColor = LOAD_RGB(243, 243, 243, 1);
    }
    
    
    if (isOn) {
        self.onWindows = [NSNumber numberWithBool:isOn];
        UIWindow * window = [UIApplication sharedApplication].keyWindow;
        if (![window.subviews containsObject:self.loadingBackView]) {
            
            CGFloat y = 0;
            CGFloat height = LOAD_HEIGHT;
            if (self.navigationController) {
                y = LOAD_TOP_HEIGHT;
                height = height - LOAD_TOP_HEIGHT;
            }
            if (self.tabBarController) {
                height = height - LOAD_BOTTOM_HEIGHT - 49;
            }
            
            if (self.navigationController.tabBarController) {
                if ((height != LOAD_HEIGHT - LOAD_TOP_HEIGHT - LOAD_BOTTOM_HEIGHT - 49) && (height != LOAD_HEIGHT - LOAD_BOTTOM_HEIGHT - 49)) {
                    height = height - LOAD_BOTTOM_HEIGHT - 49;
                }
            }
            self.loadingBackView.frame = CGRectMake(0, y, LOAD_WIDTH, height);
            [window addSubview:self.loadingBackView];
        }
    }else{
        if (![self.view.subviews containsObject:self.loadingBackView]) {
            [self.view addSubview:self.loadingBackView];
        }
        
        if ([self.view isKindOfClass:[UITableView class]]) {
            UITableView * view = (UITableView *)self.view;
            view.scrollEnabled = NO;
        }
        if ([self.view isKindOfClass:[UICollectionView class]]) {
            UICollectionView * view = (UICollectionView *)self.view;
            view.scrollEnabled = NO;
        }
        if ([self.view isKindOfClass:[UIScrollView class]]) {
            UIScrollView * view = (UIScrollView *)self.view;
            view.scrollEnabled = NO;
        }
    }
    
    
    
    if (!self.loadingView) {
        CGFloat y = self.navigationController ? 0 : LOAD_TOP_HEIGHT;
        self.loadingView = [[UIView alloc]initWithFrame:CGRectMake(0, y + CGRectGetMaxY(self.loadingBackView.frame)/3 - 50 , LOAD_WIDTH,100)];
        UIActivityIndicatorView * indicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self.loadingView addSubview:indicatorView];
        indicatorView.frame = CGRectMake(LOAD_WIDTH/2 - 25, 0, 50, 50);
        [indicatorView startAnimating];
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(20, 70, LOAD_WIDTH - 40, 30)];
        [self.loadingView addSubview:label];
        label.text = remind ? remind : @"正在努力请求数据...";
        self.loadingRemind = remind ? remind : nil;
        label.textColor = LOAD_RGB(153, 153, 153, 1);
        label.font = [UIFont systemFontOfSize:15];
        label.numberOfLines = 2;
        label.textAlignment = NSTextAlignmentCenter;
    }
    if (![self.loadingBackView.subviews containsObject:self.loadingView]) {
        [self.loadingBackView addSubview:self.loadingView];
    }
    
}


- (void)loadFail:(LoadActionCallBack)callBack andRemind:(nullable NSString *)remind{
    [self.loadingView removeFromSuperview];
    if (!self.loadFailView) {
        CGFloat y = self.navigationController ? 0 : LOAD_TOP_HEIGHT;
        self.loadFailView = [[UIView alloc]initWithFrame:CGRectMake(0,y + CGRectGetMaxY(self.loadingBackView.frame)/3 - 100, LOAD_WIDTH,200)];
        
        UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"RRRLoadView.bundle/networkError.png"]];
        imageView.frame = CGRectMake(LOAD_WIDTH/2 - 30, 0, 60, 60);
        
        [self.loadFailView addSubview:imageView];
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(imageView.frame) + 10, LOAD_WIDTH - 40, 40)];
        [self.loadFailView addSubview:label];
        label.text = remind ? remind : @"数据请求失败";
        label.textColor = LOAD_RGB(153, 153, 153, 1);
        label.font = [UIFont systemFontOfSize:15];
        label.numberOfLines = 2;
        label.textAlignment = NSTextAlignmentCenter;
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"点击重新加载" forState:UIControlStateNormal];
        [button setTitleColor:LOAD_RGB(153, 153, 153, 1) forState:UIControlStateNormal];
        [self.loadFailView addSubview:button];
         button.frame = CGRectMake(LOAD_WIDTH/2 - 60, CGRectGetMaxY(label.frame) + 20, 120, 36);
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        button.layer.cornerRadius = 18;
        button.layer.masksToBounds = YES;
        button.layer.borderColor = LOAD_RGB(153, 153, 153, 1).CGColor;
        button.layer.borderWidth = 1;
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self setCallBack:callBack];
    }
    

    if (![self.loadingBackView.subviews containsObject:self.loadFailView]) {
        [self.loadingBackView addSubview:self.loadFailView];
    }
}

- (void)loadSucess{
    if ([self.view isKindOfClass:[UITableView class]]) {
        UITableView * view = (UITableView *)self.view;
        view.scrollEnabled = YES;
    }
    if ([self.view isKindOfClass:[UICollectionView class]]) {
        UICollectionView * view = (UICollectionView *)self.view;
        view.scrollEnabled = YES;
    }
    if ([self.view isKindOfClass:[UIScrollView class]]) {
        UIScrollView * view = (UIScrollView *)self.view;
        view.scrollEnabled = YES;
    }
    [self.loadingBackView removeFromSuperview];
}

- (void)buttonClicked:(UIButton *)sender{
    if (self.callBack) {
        self.callBack(sender);
    }
    [self.loadFailView removeFromSuperview];
    [self loadDataWithRemind:self.loadingRemind onWindow:self.onWindows.boolValue];
}




- (UIView *)loadingView{
    return objc_getAssociatedObject(self, loadingViewKey);
}

- (void)setLoadingView:(UIView *)loadingView{
    return objc_setAssociatedObject(self, loadingViewKey, loadingView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)loadFailView{
     return objc_getAssociatedObject(self, loadFailViewKey);
}

- (void)setLoadFailView:(UIView *)loadFailView{
    return objc_setAssociatedObject(self, loadFailViewKey, loadFailView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)loadingBackView{
     return objc_getAssociatedObject(self, loadingBackViewKey);
}

- (void)setLoadingBackView:(UIView *)loadingBackView{
    return objc_setAssociatedObject(self, loadingBackViewKey, loadingBackView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (LoadActionCallBack)callBack{
    return objc_getAssociatedObject(self, loadActionCallBackKey);
}

- (void)setCallBack:(LoadActionCallBack)callBack{
    return objc_setAssociatedObject(self, loadActionCallBackKey, callBack, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)loadingRemind{
    return objc_getAssociatedObject(self, loadingRemindKey);
}

- (void)setLoadingRemind:(NSString *)loadingRemind{
    return objc_setAssociatedObject(self, loadingRemindKey, loadingRemind, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (NSNumber *)onWindows{
    return objc_getAssociatedObject(self, onWindowsKey);
}


- (void)setOnWindows:(NSNumber *)onWindows{
    return objc_setAssociatedObject(self, onWindowsKey, onWindows, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
