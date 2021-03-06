//
//  TopPosterModel.h
//  ZQLHotMovieLine
//
//  Created by MS on 16-1-13.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import "ZQLBaseModel.h"
#import "adverGotoModel.h"

@interface TopPosterModel : ZQLBaseModel

@property (nonatomic, copy) NSString * url;

@property (nonatomic, copy) NSString * keyColor;

@property (nonatomic, copy) NSString * img;

@property (nonatomic, strong) adverGotoModel * gotoPage;

@end
