//
//  VideoListModel.h
//  ZQLHotMovieLine
//
//  Created by MacQin on 3/19/16.
//  Copyright © 2016 MS. All rights reserved.
//

#import "ZQLBaseModel.h"

@interface VideoListModel : ZQLBaseModel

@property (nonatomic, copy) NSString * vid;

@property (nonatomic, copy) NSString * url;

@property (nonatomic, copy) NSString * hightUrl;

@property (nonatomic, copy) NSString * image;

@property (nonatomic, copy) NSString * title;

@property (nonatomic, copy) NSString * type;

@property (nonatomic, copy) NSString * length;

@end
