//
//  PersonModel.h
//  ZQLHotMovieLine
//
//  Created by MacQin on 4/17/16.
//  Copyright © 2016 MS. All rights reserved.
//

#import "ZQLBaseModel.h"

@interface PersonModel : ZQLBaseModel

@property (nonatomic, copy) NSString * pid;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * img;
@property (nonatomic, copy) NSString * nameEn;
@property (nonatomic, copy) NSString * sex;
@property (nonatomic, copy) NSString * birthday;
@property (nonatomic, copy) NSString <Optional> * profession;
@property (nonatomic, copy) NSString <Optional> * constellation;
@property (nonatomic, copy) NSString * birthLocation;
@property (nonatomic, copy) NSString * rating;
@property (nonatomic, copy) NSString * loveDeep;

@end
