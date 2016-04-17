//
//  SearchGoodModel.h
//  ZQLHotMovieLine
//
//  Created by MacQin on 4/16/16.
//  Copyright © 2016 MS. All rights reserved.
//

#import "ZQLBaseModel.h"

@interface SearchGoodModel : ZQLBaseModel

@property (nonatomic, copy) NSString * goodsId;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * imageSrc;
@property (nonatomic, copy) NSString * marketPrice;
@property (nonatomic, copy) NSString * minSalePrice;
@property (nonatomic, copy) NSString * goodsUrl;
@property (nonatomic, copy) NSString * iconText;
@property (nonatomic, copy) NSString * background;

@end
