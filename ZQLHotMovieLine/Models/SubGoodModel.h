//
//  SubGoodModel.h
//  ZQLHotMovieLine
//
//  Created by MS on 16-1-13.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import "ZQLBaseModel.h"
#import "adverGotoModel.h"

@interface SubGoodModel : ZQLBaseModel

@property (nonatomic, copy) NSString<Optional> * gid;

@property (nonatomic, copy) NSString * goodsId;

@property (nonatomic, copy) NSString * image;

@property (nonatomic, copy) NSString<Optional> * title;

@property (nonatomic, copy) NSString<Optional> * titleColor;

@property (nonatomic, copy) NSString<Optional> * titleSmall;

@property (nonatomic, copy) NSString * image2;

@property (nonatomic, strong) adverGotoModel * gotoPage;

@end
