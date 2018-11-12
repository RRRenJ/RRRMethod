//
//  QRCreateMethod.m
//  GlobalTrading
//
//  Created by 任敬 on 2018/9/12.
//  Copyright © 2018年 任敬. All rights reserved.
//

#import "QRCreateMethod.h"

@interface QRCreateMethod ()

@end

@implementation QRCreateMethod

#pragma mark - public

+ (UIImage *)createQRCodeWithString:(NSString *)QRString withImgWidth:(CGFloat)imageWidth{
    
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    [filter setDefaults];
    
    NSData *data = [QRString dataUsingEncoding:NSUTF8StringEncoding];
    
    [filter setValue:data forKey:@"inputMessage"];
    
    ///获取滤镜输出的图像
    CIImage *outImage = [filter outputImage];
    
    UIImage *imageV = [self imageWithImageWidth:imageWidth withCIIImage:outImage];
    //返回二维码图像
    return imageV;
    
}


+ (UIImage *)createImgQRCodeWithString:(NSString *)QRString centerImage:(UIImage *)centerImage imgWidth:(CGFloat)imageWidth centerImageSize:(CGSize)centerSize{
    
    // 创建滤镜对象
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 恢复滤镜的默认属性
    [filter setDefaults];
    
    // 将字符串转换成 NSdata
    NSData *dataString = [QRString dataUsingEncoding:NSUTF8StringEncoding];
    
    // 设置过滤器的输入值, KVC赋值
    [filter setValue:dataString forKey:@"inputMessage"];
    
    // 获得滤镜输出的图像
    CIImage *outImage = [filter outputImage];
    
//    // 图片小于(27,27),我们需要放大
//    outImage = [outImage imageByApplyingTransform:CGAffineTransformMakeScale(20, 20)];
//
//    // 将CIImage类型转成UIImage类型
//    UIImage *startImage = [UIImage imageWithCIImage:outImage];
    UIImage * startImage = [self imageWithImageWidth:imageWidth withCIIImage:outImage];
    
    // 开启绘图, 获取图形上下文
    UIGraphicsBeginImageContext(startImage.size);

    // 把二维码图片画上去 (这里是以图形上下文, 左上角为(0,0)点
    [startImage drawInRect:CGRectMake(0, 0, startImage.size.width, startImage.size.height)];
    // 再把小图片画上去
    CGFloat icon_imageW = centerSize.width;
    
    CGFloat icon_imageH = centerSize.height;
    
    CGFloat icon_imageX = (startImage.size.width - icon_imageW) * 0.5;
    
    CGFloat icon_imageY = (startImage.size.height - icon_imageH) * 0.5;
    
    [centerImage drawInRect:CGRectMake(icon_imageX, icon_imageY, icon_imageW, icon_imageH)];
    
    // 获取当前画得的这张图片
    UIImage *qrImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭图形上下文
    UIGraphicsEndImageContext();
    
    //返回二维码图像
    return qrImage;
    
}


#pragma mark - private

/**
 根据CIImage生成指定大小的UIImage

 @param imageWidth 图片尺寸
 @param ciiImage CIImage
 @return UIImage
 */
+ (UIImage *)imageWithImageWidth:(CGFloat)imageWidth withCIIImage:(CIImage *)ciiImage{
    
    CGRect extent = CGRectIntegral(ciiImage.extent);
    
    CGFloat scale = MIN(imageWidth/CGRectGetWidth(extent), imageWidth/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    
    size_t height = CGRectGetHeight(extent) * scale;
    
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CGImageRef bitmapImage = [context createCGImage:ciiImage fromRect:extent];
    
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    
    CGContextScaleCTM(bitmapRef, scale, scale);
    
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    
    CGContextRelease(bitmapRef);
    
    CGImageRelease(bitmapImage);
    
    return [UIImage imageWithCGImage:scaledImage];
    
}

#pragma mark - set

#pragma mark - get

@end
