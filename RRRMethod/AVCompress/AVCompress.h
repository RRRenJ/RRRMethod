//
//  AVCompress.h
//  RRRMethodDemo
//
//  Created by 任敬 on 2018/6/12.
//  Copyright © 2018年 任敬. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>





@class AVCompressModel;

typedef NS_ENUM(NSInteger, AVCompressStatus) {
    AVCompressStatusWithWating,
    AVCompressStatusWithCompressing,
    AVCompressStatusWithSuccess,
    AVCompressStatusWithFailure,
};

@protocol AVCompressDelegate<NSObject>

- (void)av_comressProgress:(NSArray <AVCompressModel *> *)outputModels;

- (void)av_compressCurrentModel:(AVCompressModel *)model completed:(BOOL)isCompleted;

- (void)av_compressAllModelCompleted:(NSArray <AVCompressModel *> *)outputModels;

@end

@interface AVCompress : NSObject

@property (nonatomic, strong) NSMutableArray <AVCompressModel *>* inputModels;

@property (nonatomic, strong, readonly) AVCompressModel * currentModel;

@property (nonatomic, weak) id<AVCompressDelegate>delegate;

+ (AVCompress *)compress;
//添加压缩模型
- (void)addModel:(AVCompressModel *)model;
//开始压缩
- (void)startCompress;
//重新压缩指定文件
- (void)recompressWithModel:(AVCompressModel *)model;
//清除指定压缩文件
- (void)clearWithComressFilePath:(NSString *)filePath;
//清除所有压缩文件
- (void)clearAllCompressFile;



@end


typedef NS_ENUM(NSInteger, AVCompressQuality){
    AVCompressQualityWithLow = 10,
    AVCompressQualityWithMedium,
    AVCompressQualityWithHighest,
};

@interface AVCompressModel :NSObject

/**
 来自相册视频资源
 */
@property (nonatomic, strong) PHAsset * phAsset;
/**
 视频本地地址（仅用于app内本地视屏压缩上传）
 */
@property (nonatomic, strong) NSString * localPath;
/**
 视频压缩后输出
 */
@property (nonatomic, strong) NSString * outputPath;
/**
 压缩质量
 */
@property (nonatomic, assign) AVCompressQuality compressQuality;
/**
 压缩后文件类型
 */
@property (nonatomic, assign) AVFileType fileType;

@property (nonatomic, assign) float progress;

@property (nonatomic, assign) AVCompressStatus status;


@end
