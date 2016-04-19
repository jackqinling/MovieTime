//
//  ZQLBaseModel.h
//  ZQLHotMovieLine
//
//  Created by MS on 16-1-11.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "ZQLScreenMacro.h"
#import "Masonry.h"

@interface ZQLBaseModel : JSONModel

+ (NSArray *)arrayOfModelsFromJson:(id)object;

@end
