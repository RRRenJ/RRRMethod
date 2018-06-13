//
//  ViewController.m
//  RRRMethodDemo
//
//  Created by 任敬 on 2018/6/11.
//  Copyright © 2018年 任敬. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUD+RRR.h"
#import "AVCompress.h"

#import "RRRButton.h"
@interface ViewController ()<AVCompressDelegate>

@property (nonatomic, strong) NSTimer * timer;

@property (nonatomic, assign) NSInteger seconds;

@property (nonatomic, strong) MBProgressHUD * hud;

@property (nonatomic, strong) AVCompress * compress;

@property (nonatomic, strong) AVCompressModel * model;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    // Do any additional setup after loading the view, typically from a nib.
//    NSLog(@"%@",[UIApplication sharedApplication].keyWindow);
    
    RRRButton * bt = [RRRButton createBtWithFrame:CGRectMake(100, 100, 200, 100) type:UIButtonTypeCustom title:nil titleColor:nil btColor:[UIColor blueColor] andTarget:self action:@selector(xxx) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bt];
    
    RRRButton * bt1 = [RRRButton createBtWithFrame:CGRectMake(100, 300, 200, 100) type:UIButtonTypeCustom title:nil titleColor:nil btColor:[UIColor blueColor] andTarget:self action:@selector(xxxx) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bt1];
    
    
    NSLog(@"%@",RRRDocumentPath);
}

- (void)xxx{
//    [MBProgressHUD showMessage:@"成功而王菲王菲王菲王菲王菲王菲无法"];
//    self.hud = [MBProgressHUD showLoadingProgressMessage:@"加载中"];
//    [self sending];
    _compress = [AVCompress compress];
    NSMutableArray * array = [NSMutableArray array];
    for (int index = 0; index < 5; index++) {
        if (index == 2) {
            _model = [[AVCompressModel alloc]init];
            _model.localPath = [NSString stringWithFormat:@"%@/mp4/111.mp4",RRRDocumentPath];
            _model.compressQuality = AVCompressQualityWithMedium;
            _model.fileType = AVFileTypeMPEG4;
            [array addObject:_model];
        }else{
            AVCompressModel * model = [[AVCompressModel alloc]init];
            model.localPath = [NSString stringWithFormat:@"%@/mp4/111.mp4",RRRDocumentPath];
            model.compressQuality = AVCompressQualityWithMedium;
            model.fileType = AVFileTypeMPEG4;
            [array addObject:model];
        }
        
    }
    _compress.inputModels = array;
    _compress.delegate = self;
    [_compress startCompress];
}

- (void)xxxx{
//    AVCompressModel * model = [[AVCompressModel alloc]init];
//    model.localPath = [NSString stringWithFormat:@"%@/mp4/111.mp4",RRRDocumentPath];
//    model.compressQuality = AVCompressQualityWithMedium;
//    model.fileType = AVFileTypeMPEG4;
//
//    [_compress addModel:model];
    [_compress recompressWithModel:_model];
}


- (void)av_compressAllModelCompleted:(NSArray<AVCompressModel *> *)outputModels{
    NSLog(@"%@",outputModels);
}
- (void)av_compressCurrentModel:(AVCompressModel *)model completed:(BOOL)isCompleted{
    NSLog(@"%@",model);
}

- (void)av_comressProgress:(NSArray<AVCompressModel *> *)outputModels{
    NSMutableString * str = [NSMutableString string];
    for (AVCompressModel * model in outputModels) {
        [str appendString:[NSString stringWithFormat:@"  %f",model.progress]];
    }
    NSLog(@"%@",str);
}


- (void)sending{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    self.seconds = 0;
}

- (void)countDown{
    self.hud.progress = self.seconds / 60.f;
    if (self.seconds >= 60) {
        [self.hud hideAnimated:YES];
        if ([self.timer isValid]) {
            [self.timer invalidate];
            self.timer = nil;
        }
        return;
    }
    self.seconds ++ ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end