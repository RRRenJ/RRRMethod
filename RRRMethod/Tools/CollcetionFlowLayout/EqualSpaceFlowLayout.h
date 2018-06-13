//
//  EqualSpaceFlowLayout.h
//  UICollectionViewDemo
//
//  Created by CHC on 15/5/12.
//  Copyright (c) 2015年 CHC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,AlignType){
    AlignWithLeft,
    AlignWithCenter,
    AlignWithRight
};

@interface EqualSpaceFlowLayout : UICollectionViewFlowLayout

//两个Cell之间的距离
@property (nonatomic,assign)CGFloat betweenOfCell;
//cell对齐方式
@property (nonatomic,assign)AlignType cellType;

-(instancetype)initWthType:(AlignType)cellType;
@end
