//
//  AVCompress.m
//  RRRMethodDemo
//
//  Created by 任敬 on 2018/6/12.
//  Copyright © 2018年 任敬. All rights reserved.
//

#import "AVCompress.h"
#import "AVMutableVideoComposition+FixVideoDirection.h"


@interface AVCompress ()

@property (nonatomic, strong) AVCompressModel * currentModel;

@end


@implementation AVCompress

static AVCompress * compress;

+ (AVCompress *)compress {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        compress = [[self alloc] init];
    });
    return compress;
}

//- (void)beginCompressHandle:(void(^)(NSArray <AVCompressModel *>*outputModel))compressHandle{
//
//}


- (void)addModel:(AVCompressModel *)model{
    [self.inputModels addObject:model];
    [self startCompress];
}

- (void)recompressWithModel:(AVCompressModel *)model{
    if ([self.inputModels containsObject:model]) {
        model.status = AVCompressStatusWithWating;
        [self startCompress];
    }
}

- (void)startCompress{
    
   
    
    for (AVCompressModel * model in self.inputModels) {
        //初始化model状态
        if (model.status == 0) {
             model.status = AVCompressStatusWithWating;
        }
    }
    if (self.inputModels.count > 0) {
        //判断当前是否有任务
        if (!self.currentModel) {
            //没有当前任务，取第一个
            self.currentModel = self.inputModels.firstObject;
            [self compressModel:self.currentModel];
        }else{
            //有当前任务，
            //判断当前任务状态，如果为等待或者进行中则顺序执行,否则执行下一个
            if (self.currentModel.status == AVCompressStatusWithFailure || self.currentModel.status == AVCompressStatusWithSuccess) {
                [self nextModel];
            }
        }  
    }
}



- (void)nextModel{
    NSInteger index = [self.inputModels indexOfObject:self.currentModel];
    if (index+1 < self.inputModels.count) {
        if (self.inputModels[index+1].status == AVCompressStatusWithWating){
            self.currentModel = self.inputModels[index+1];
            [self compressModel:self.currentModel];
        }  
    }else{
        for (AVCompressModel * model in self.inputModels) {
            if (model.status == AVCompressStatusWithWating) {
                self.currentModel = model;
                [self compressModel:self.currentModel];
                return;
            }
        }
    }
}

- (void)compressModel:(AVCompressModel *)model{
    [self compressVideoWithModel:model progressHandle:^(float progress) {
        self.currentModel.progress = progress;
        if (progress == 1) {
            self.currentModel.status = AVCompressStatusWithSuccess;
        }else{
            self.currentModel.status = AVCompressStatusWithCompressing;
        }
        
        if ([self.delegate respondsToSelector:@selector(av_comressProgress:)]) {
            [self.delegate av_comressProgress:self.inputModels];
        }
    } completed:^(NSError *error) {
        if (error) {
            self.currentModel.status = AVCompressStatusWithFailure;
            if ([self.delegate respondsToSelector:@selector(av_compressCurrentModel:completed:)]) {
                [self.delegate av_compressCurrentModel:model completed:NO];
            }
        }else{
            self.currentModel.status = AVCompressStatusWithSuccess;
            //防止时间精度导致progress不等于1
            self.currentModel.progress = 1;
            if ([self.delegate respondsToSelector:@selector(av_compressCurrentModel:completed:)]) {
                [self.delegate av_compressCurrentModel:model completed:YES];
            }
        }
        [self nextModel];
        for (AVCompressModel * model in self.inputModels) {
            if (model.status == AVCompressStatusWithWating) {
                return;
            }
        }
        if ([self.delegate respondsToSelector:@selector(av_compressAllModelCompleted:)]) {
            [self.delegate av_compressAllModelCompleted:self.inputModels];
        }
    }];
}


//配置压缩导出参数
- (void)compressVideoWithModel:(AVCompressModel *)model progressHandle:(void(^)(float progress))progressHandle completed:(void(^)(NSError * error))completed{
    __block AVURLAsset * urlAsset;
    if (model.localPath) {
      urlAsset  = [[AVURLAsset alloc]initWithURL:[NSURL fileURLWithPath:model.localPath] options:nil];
    }else{
        PHVideoRequestOptions* options = [[PHVideoRequestOptions alloc] init];
        options.version = PHVideoRequestOptionsVersionOriginal;
        options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
        options.networkAccessAllowed = YES;
        [[PHImageManager defaultManager] requestAVAssetForVideo:model.phAsset options:options resultHandler:^(AVAsset* avasset, AVAudioMix* audioMix, NSDictionary* info){
            urlAsset = (AVURLAsset*)avasset;
        }];
    }
    if (!urlAsset) {
        NSLog(@"urlAsset为空");
        return;
    }
   
    //获取系统可导出质量
    NSArray * compatiblePreset = [AVAssetExportSession exportPresetsCompatibleWithAsset:urlAsset];
    NSString * compressQuality ;
    switch (model.compressQuality) {
        case AVCompressQualityWithLow:
            compressQuality = AVAssetExportPresetLowQuality;
            break;
        case AVCompressQualityWithMedium:
            compressQuality = AVAssetExportPresetMediumQuality;
            break;
        case AVCompressQualityWithHighest:
            compressQuality = AVAssetExportPresetHighestQuality;
            break;
        default:
            compressQuality = AVAssetExportPresetMediumQuality;
            break;
    }

    if (![compatiblePreset containsObject:compressQuality]) {
        NSError * error = [NSError errorWithDomain:NSCocoaErrorDomain code:-1000 userInfo:@{@"message":@"当前指定压缩质量不支持"}];
        completed(error);
        return;
    }
    AVMutableVideoComposition *videoComposition = [AVMutableVideoComposition fixedCompositionWithAsset:urlAsset];
    
    if (!model.fileType) {
        model.fileType = AVFileTypeMPEG4;
    }
    
    [self exportVideoWithUrlAsset:urlAsset quality:compressQuality exportFileType:model.fileType videoComposition:videoComposition progressHandle:^(float progress) {
        progressHandle(progress);
    } success:^(NSString *outputPath) {
        model.status = AVCompressStatusWithSuccess;
        model.outputPath = outputPath;
        completed(nil);
    } failure:^(NSString *errorMessage) {
        model.status = AVCompressStatusWithFailure;
        model.outputPath = nil;
        NSError * error = [NSError errorWithDomain:NSCocoaErrorDomain code:-1001 userInfo:@{@"message":errorMessage}];
        completed(error);
    }];
}

//压缩并导出
- (void)exportVideoWithUrlAsset:(AVURLAsset *)urlAsset quality:(NSString *)quality exportFileType:(AVFileType)fileType videoComposition:(AVMutableVideoComposition *)videoComposition progressHandle:(void(^)(float progress))progressHandle success:(void (^)(NSString *outputPath))success failure:(void (^)(NSString *errorMessage))failure{
  
    AVAssetExportSession * exportSession = [[AVAssetExportSession alloc]initWithAsset:urlAsset presetName:quality];
    
    NSString * outputPath = [self createCompressModelOutputPathWithType:fileType];
    if (!outputPath) {
         failure(@"当前指定导出视频格式暂不支持");
        return;
    }
    exportSession.outputURL = [NSURL fileURLWithPath:outputPath];
    // 是否对网络进行优化
    exportSession.shouldOptimizeForNetworkUse = true;
    NSArray * supportedTypes = exportSession.supportedFileTypes;
    if ([supportedTypes containsObject:fileType]) {
        // 转换成MP4格式
        exportSession.outputFileType = fileType;
    }else if (supportedTypes.count == 0 ){
        failure(@"当前指定导出视频格式暂不支持");
        return;
    }else{
        failure(@"当该视频类型暂不支持导出");
        return;
    }
    if (videoComposition.renderSize.width) {
        // 修正视频转向
        exportSession.videoComposition = videoComposition;
    }
    
//     创建GCD定时器
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 0.1 * NSEC_PER_SEC, 0); //每秒执行
    // 事件回调
    dispatch_source_set_event_handler(timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            // 在主线程中实现需要的功能
            if (progressHandle) {
                progressHandle(exportSession.progress);
                if (exportSession.progress == 1) {
                    dispatch_source_cancel(timer);
                }
            }
        });
    });
    dispatch_resume(timer);
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [exportSession exportAsynchronouslyWithCompletionHandler:^{
            
            dispatch_async(dispatch_get_main_queue(), ^{
//                 如果导出的状态为完成
                switch (exportSession.status){
                    case AVAssetExportSessionStatusCompleted:
                        if (success) {
                            success(outputPath);
                        }
                        NSLog(@"AVAssetExportSessionStatusCompleted");
                        break;
                    case AVAssetExportSessionStatusFailed:
                        if (failure) {
                            failure(@"AVAssetExportSessionStatusFailed");
                        }
                        NSLog(@"AVAssetExportSessionStatusFailed");
                        break;
                    case AVAssetExportSessionStatusCancelled:
                        if (failure) {
                            failure(@"AVAssetExportSessionStatusCancelled");
                        }
                        NSLog(@"AVAssetExportSessionStatusCancelled");
                        break;
                    case AVAssetExportSessionStatusUnknown:
    
                        break;
                    case AVAssetExportSessionStatusWaiting:
    
                        break;
                    case AVAssetExportSessionStatusExporting:
                        break;
                }
            });
            
        }];
    });

}



- (NSString *)createCompressModelOutputPathWithType:(AVFileType)type{
    NSString * files ;
    if ([type isEqualToString:AVFileTypeQuickTimeMovie]) {
        files = @"mov";
    }else if ([type isEqualToString:AVFileTypeMPEG4]){
        files = @"mp4";
    }else if ([type isEqualToString:AVFileTypeAppleM4V]){
        files = @"m4v";
    }else if ([type isEqualToString:AVFileTypeAppleM4A]){
        files = @"m4a";
    }else if ([type isEqualToString:AVFileType3GPP]){
        files = @"3gp";
    }else if ([type isEqualToString:AVFileType3GPP2]){
        files = @"3g2";
    }else{
        return nil;
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd-HH:mm:ss-SSS"];
    NSDate   *date = [[NSDate alloc] init];
    NSString *outputPath = [NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"output-%@.%@",[formatter stringFromDate:date],files]];
    
    return outputPath;
}


- (void)clearWithComressFilePath:(NSString *)filePath{
    if (filePath) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSFileManager * fileManager = [NSFileManager defaultManager];
            [fileManager removeItemAtPath:filePath error:nil];
        });
    }
}

- (void)clearAllCompressFile{
    for (AVCompressModel * model in self.inputModels) {
        [self clearWithComressFilePath:model.outputPath];
    }
}

@end




@implementation AVCompressModel













@end
