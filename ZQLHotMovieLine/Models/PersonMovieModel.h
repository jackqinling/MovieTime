//
//  PersonMovieModel.h
//  ZQLHotMovieLine
//
//  Created by MacQin on 4/17/16.
//  Copyright © 2016 MS. All rights reserved.
//

#import "ZQLBaseModel.h"

@interface PersonMovieModel : ZQLBaseModel
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * year;
@property (nonatomic, copy) NSString * url;
@property (nonatomic, copy) NSString * movieId;
@end
