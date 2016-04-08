//
//  BaseManager.h
//  ZQLHotMovieLine
//
//  Created by MacQin on 4/8/16.
//  Copyright © 2016 MS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZQLScreenMacro.h"

#define UD_KEY_DATA_CACHE_KEYS @"UD_KEY_DATA_CACHE_KEYS"
#define UD_KEY_DATA_CACHE_OBJECTS @"UD_KEY_DATA_CACHE_OBJECTS"

#define DATA_CACHE_KEY_ALL_TOPIC_LIST @"DATA_CACHE_KEY_ALL_TOPIC_LIST"
#define DATA_CACHE_KEY_MY_TOPIC_LIST @"DATA_CACHE_KEY_MY_TOPIC_LIST"
#define DATA_CACHE_KEY_UPDATED_TOPIC_LIST @"DATA_CACHE_KEY_UPDATED_TOPIC_LIST"

@interface BaseManager : NSObject

+ (id)shareInstance;

- (void)loadData;

- (void)clearMemoryCache;

- (void)clearCacheData;
@end
