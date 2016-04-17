//
//  TotalGoodsModel.h
//  ZQLHotMovieLine
//
//  Created by MacQin on 4/16/16.
//  Copyright © 2016 MS. All rights reserved.
//

#import "ZQLBaseModel.h"
#import "SearchGoodModel.h"

@protocol SearchGoodModel;

@interface TotalGoodsModel : ZQLBaseModel

@property (nonatomic, copy) NSString * keywordUrl;
@property (nonatomic, strong) NSArray <Optional, ConvertOnDemand, SearchGoodModel> * goodsList;
@end
