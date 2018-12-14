//
//  QRCreateMethod.h
//  GlobalTrading
//
//  Created by 任敬 on 2018/9/12.
//  Copyright © 2018年 任敬. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface QRCreateMethod : NSObject


/**
 生成普通二维码

 @param QRStering 字符串
 @param imageWidth 图片大小
 @return 二维码图片
 */
+ (UIImage *)createQRCodeWithString:(NSString *)QRStering withImgWidth:(CGFloat)imageWidth;


/**
 生成带logo二维码

 @param QRString 字符串
 @param centerImage 中心图片
 @return 二维码图片
 */
+ (UIImage *)createImgQRCodeWithString:(NSString *)QRString centerImage:(UIImage *)centerImage imgWidth:(CGFloat)imageWidth centerImageSize:(CGSize)centerSize;

@end
