//
//  AdScrollView.h
//  ZQLHotMovieLine
//
//  Created by MS on 16-1-21.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdScrollView : UIView

@property (nonatomic, strong) NSArray * adverModelsArray;


+ (instancetype)viewWithAdverModels:(NSArray *)adverModelsArray frame:(CGRect)frame;

@end
