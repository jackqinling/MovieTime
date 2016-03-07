//
//  AwardModel.h
//  ZQLHotMovieLine
//
//  Created by zhaoqinling on 16/1/31.
//  Copyright © 2016年 MS. All rights reserved.
//

#import "ZQLBaseModel.h"
#import "WinAwardModel.h"

@protocol WinAwardModel;

@interface AwardModel : ZQLBaseModel

@property (nonatomic, strong) NSString * festivalId;

@property (nonatomic, strong) NSString * winCount;

@property (nonatomic, strong) NSString * nominateCount;

@property (nonatomic, strong) NSArray<WinAwardModel, ConvertOnDemand, Optional> * winAwards;

@end
