//
//  SearchKeyWordsModel.h
//  ZQLHotMovieLine
//
//  Created by MacQin on 4/9/16.
//  Copyright © 2016 MS. All rights reserved.
//

#import "ZQLBaseModel.h"

@interface SearchKeyWordsModel : ZQLBaseModel

@property (nonatomic, strong) NSArray * keywords;

@property (nonatomic, copy) NSString <Optional> * hotContent;

@end
