//
//  DataCacheManager.h
//  ZQLHotMovieLine
//
//  Created by MacQin on 4/8/16.
//  Copyright © 2016 MS. All rights reserved.
//

#import "BaseManager.h"

@interface DataCacheManager : BaseManager
{
    NSMutableArray * _memoryCacheKeys;
    NSMutableDictionary * _memoryCachedObjects;
    
    NSMutableArray * _cacheKeys;
    NSMutableDictionary * _cachedObjects;
}

+ (id)sharedManager;

- (void)addObject:(NSObject *)obj forKey:(NSString *)key;

- (void)doSave;

- (void)clearAllCache;

- (void)clearMemoryCache;

- (void)addObjectToMemory:(NSObject *)obj forKey:(NSString *)key;

- (NSObject *)getCachedObjectForKey:(NSString *)key;

- (BOOL)hasObjectInCacheForKey:(NSString *)key;


@end
