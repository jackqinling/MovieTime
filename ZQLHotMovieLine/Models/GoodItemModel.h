//
//  GoodItemModel.h
//  ZQLHotMovieLine
//
//  Created by zhaoqinling on 16/2/3.
//  Copyright © 2016年 MS. All rights reserved.
//

#import "ZQLBaseModel.h"

@interface GoodItemModel : ZQLBaseModel

@property (nonatomic, strong) NSString * goodsId;

@property (nonatomic, strong) NSString * iconText;

@property (nonatomic, strong) NSString * background;

@property (nonatomic, strong) NSString * name;

@property (nonatomic, strong) NSString * longName;

@property (nonatomic, strong) NSString * image;

@property (nonatomic, strong) NSString * marketPrice;

@property (nonatomic, strong) NSString * minSalePrice;

@property (nonatomic, strong) NSString * goodsUrl;

@end
