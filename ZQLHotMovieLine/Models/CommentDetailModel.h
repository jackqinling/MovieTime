//
//  CommentDetailModel.h
//  ZQLHotMovieLine
//
//  Created by MacQin on 3/7/16.
//  Copyright © 2016 MS. All rights reserved.
//

#import "ZQLBaseModel.h"

@interface CommentDetailModel : ZQLBaseModel

@property (nonatomic, copy) NSString * cid;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * content;
@property (nonatomic, copy) NSString * nickname;
@property (nonatomic, copy) NSString * commentCount;
@property (nonatomic, copy) NSString * headurl;
@property (nonatomic, copy) NSString * location;
@property (nonatomic, copy) NSString * modifyTime;
@property (nonatomic, copy) NSString * rating;
@property (nonatomic, assign) BOOL isWantSee;


@end
