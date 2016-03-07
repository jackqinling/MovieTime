//
//  ZQLDefinedScrollView.h
//  ZQLHotMovieLine
//
//  Created by MS on 16-1-21.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZQLDefinedImageView.h"
#import "adverModel.h"

@class ZQLDefinedScrollView;

@protocol ZQLDefinedScrollViewDelegate <NSObject>

- (void)zqlDefinedScrollView:(ZQLDefinedScrollView *)zqlDefinedScrollView didSelectView:(ZQLDefinedImageView *)view withModel:(adverModel *)model;


@end
@interface ZQLDefinedScrollView : UIView

@property (nonatomic, weak) id<ZQLDefinedScrollViewDelegate>delegate;

@property (nonatomic, strong) NSArray * adverModelsArray;


+ (instancetype)viewWithAdverModels:(NSArray *)adverModelsArray frame:(CGRect)frame;

@end
