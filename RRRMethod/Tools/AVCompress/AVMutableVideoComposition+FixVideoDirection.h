//
//  AVMutableVideoComposition+FixVideoDirection.h
//  RRRMethodDemo
//
//  Created by 任敬 on 2018/6/13.
//  Copyright © 2018年 任敬. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

@interface AVMutableVideoComposition (FixVideoDirection)

+ (AVMutableVideoComposition *)fixedCompositionWithAsset:(AVAsset *)videoAsset;

@end
