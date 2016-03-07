//
//  hotPointModel.h
//  ZQLHotMovieLine
//
//  Created by MS on 16-1-13.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import "ZQLBaseModel.h"
#import "ImageModel.h"

@protocol ImageModel;

@interface hotPointModel : ZQLBaseModel

@property (nonatomic, copy) NSString * hid;

@property (nonatomic, copy) NSString * type;

@property (nonatomic, copy) NSString * tag;

@property (nonatomic, copy) NSString * title;

@property (nonatomic, copy) NSString * desc;

@property (nonatomic, copy) NSString * img;

@property (nonatomic, copy) NSString * img2;

@property (nonatomic, copy) NSString * img3;

@property (nonatomic, assign) NSInteger publishTime;

@property (nonatomic, copy) NSString * commentCount;

//有images数据的  值为1  没有的  为  空
@property (nonatomic, strong) NSValue <Optional> * hasThreeImages;

@property (nonatomic, strong) NSArray <Optional, ConvertOnDemand, ImageModel> * images;

@end
