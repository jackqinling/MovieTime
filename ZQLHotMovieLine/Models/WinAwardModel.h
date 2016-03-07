//
//  WinAwardModel.h
//  ZQLHotMovieLine
//
//  Created by zhaoqinling on 16/1/31.
//  Copyright © 2016年 MS. All rights reserved.
//

#import "ZQLBaseModel.h"
#import "AwardPersonModel.h"

@protocol AwardPersonModel;

@interface WinAwardModel : ZQLBaseModel

@property (nonatomic, strong) NSString * sequenceNumber;

@property (nonatomic, strong) NSString * festivalEventYear;

@property (nonatomic, strong) NSString * awardName;

@property (nonatomic, strong) NSArray<AwardPersonModel, ConvertOnDemand, Optional> * persons;
@end
