//
//  DataLoadView.m
//  RRRMethodDemo
//
//  Created by 任敬 on 2018/12/13.
//  Copyright © 2018 任敬. All rights reserved.
//

#import "DataLoadView.h"

@interface DataLoadView ()

@property (nonatomic, strong) UIView * failView;

@property (nonatomic, strong) UIView * loadView;

@end

@implementation DataLoadView

- (instancetype)init{
    self = [super init];
    if (self) {
        self.loadFailView = self.failView;
        self.loadingView = self.loadView;
    }
    return self;
}



#pragma mark - public

#pragma mark - private

#pragma mark - set

#pragma mark - get

- (UIView *)failView{
    if (!_failView) {
        _failView = [[UIView alloc]initWithFrame:CGRectMake(0, 100, 100, 100)];
        _failView .backgroundColor = [UIColor redColor];
    }
    return _failView;
}

- (UIView *)loadView{
    if (!_loadView) {
        _loadView = [[UIView alloc]initWithFrame:CGRectMake(0, 125, 50, 50)];
        _loadView .backgroundColor = [UIColor blackColor];
    }
    return _loadView;
}

@end
