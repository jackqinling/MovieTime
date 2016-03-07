//
//  MovieGoodModel.h
//  ZQLHotMovieLine
//
//  Created by zhaoqinling on 16/2/3.
//  Copyright © 2016年 MS. All rights reserved.
//

#import "ZQLBaseModel.h"
#import "GoodItemModel.h"

@protocol GoodItemModel;

@interface MovieGoodModel : ZQLBaseModel

@property (nonatomic, strong) NSString * relatedId;

@property (nonatomic, strong) NSString * relatedType;

@property (nonatomic, strong) NSString * goodsCount;

@property (nonatomic, strong) NSString * relatedUrl;

@property (nonatomic, strong) NSArray<GoodItemModel, ConvertOnDemand, Optional> * goodsList;

@end
