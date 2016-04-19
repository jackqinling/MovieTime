//
//  SearchHintModel.h
//  ZQLHotMovieLine
//
//  Created by MacQin on 4/19/16.
//  Copyright © 2016 MS. All rights reserved.
//

#import "ZQLBaseModel.h"

@interface SearchHintModel : ZQLBaseModel

@property (nonatomic, strong) NSString * hid;
@property (nonatomic, strong) NSString * type;
@property (nonatomic, strong) NSString * cover;
//电影
@property (nonatomic, strong) NSString <Optional>* contentType;
@property (nonatomic, strong) NSString <Optional>* movieType;
@property (nonatomic, strong) NSString <Optional>* isFilter;
@property (nonatomic, strong) NSString <Optional>* titlecn;
@property (nonatomic, strong) NSString <Optional>* titleen;
@property (nonatomic, strong) NSString <Optional>* rLocation;
@property (nonatomic, strong) NSString <Optional>* locationName;
@property (nonatomic, strong) NSString <Optional>* year;
@property (nonatomic, strong) NSString <Optional>* director;
//电影院
@property (nonatomic, strong) NSString <Optional>* name;
@property (nonatomic, strong) NSString <Optional>* address;


@end
