//
//  AreaSecondModel.h
//  ZQLHotMovieLine
//
//  Created by MS on 16-1-13.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import "ZQLBaseModel.h"
#import "SubGoodModel.h"

@interface AreaSecondModel : ZQLBaseModel

@property (nonatomic, strong) SubGoodModel * subFirst;

@property (nonatomic, strong) SubGoodModel * subSecond;

@property (nonatomic, strong) SubGoodModel * subThird;

@property (nonatomic, strong) SubGoodModel * subFourth;

@property (nonatomic, strong) SubGoodModel * subFifth;

@end
