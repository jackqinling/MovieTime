//
//  SeachPersonModel.h
//  ZQLHotMovieLine
//
//  Created by MacQin on 4/16/16.
//  Copyright © 2016 MS. All rights reserved.
//

#import "ZQLBaseModel.h"

@interface SearchPersonModel : ZQLBaseModel

@property (nonatomic, copy) NSString * pid;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * img;
@property (nonatomic, copy) NSString * nameEn;
@property (nonatomic, copy) NSString * sex;
@property (nonatomic, copy) NSString * birthdaty;
@property (nonatomic, copy) NSString * profession;
@property (nonatomic, copy) NSString * constellation;
@property (nonatomic, copy) NSString * birthLocation;
@property (nonatomic, copy) NSString * rating;
@property (nonatomic, copy) NSString * loveDeep;
@end
