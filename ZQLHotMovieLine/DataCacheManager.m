//
//  DataCacheManager.m
//  ZQLHotMovieLine
//
//  Created by MacQin on 4/8/16.
//  Copyright © 2016 MS. All rights reserved.
//

#import "DataCacheManager.h"

@implementation DataCacheManager

+ (id)sharedManager{
    
    static DataCacheManager * dataManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (dataManager == nil) {
            dataManager = [[DataCacheManager alloc] init];
        }
    });
    return dataManager;
}

- (id)init{
    
    if (self = [super init]) {
        
        [self restore];
    }
    return self;
}

#pragma - mark private methods
- (void)restore{
    
    if ([USER_DEFAULT objectForKey:UD_KEY_DATA_CACHE_KEYS]) {
        NSArray * keysArray = (NSArray *)[NSKeyedUnarchiver unarchiveObjectWithData:[USER_DEFAULT objectForKey:UD_KEY_DATA_CACHE_KEYS]];
        _cacheKeys = [[NSMutableArray alloc] initWithArray:keysArray];
    }else{
        _cacheKeys = [[NSMutableArray alloc] init];
    }
    
    if ([USER_DEFAULT objectForKey:UD_KEY_DATA_CACHE_OBJECTS]) {
        NSDictionary * objDic = (NSDictionary *)[NSKeyedUnarchiver unarchiveObjectWithData:[USER_DEFAULT objectForKey:UD_KEY_DATA_CACHE_OBJECTS]];
        _cachedObjects = [[NSMutableDictionary alloc] initWithDictionary:objDic];
    }else{
        _cachedObjects = [[NSMutableDictionary alloc] init];
    }
    
    _memoryCacheKeys = [NSMutableArray array];
    _memoryCachedObjects = [NSMutableDictionary dictionary];
}

- (void)removeKey:(NSString *)key fromKeyArray:(NSMutableArray *)keyArray{
    
    long indexInKeys = NSNotFound;
    for (int i = 0; i < keyArray.count; i++) {
        if ([[keyArray objectAtIndex:i] isEqualToString:key]) {
            indexInKeys = i;
            break;
        }
    }
    
    if (indexInKeys != NSNotFound) {
        [keyArray removeObjectAtIndex:indexInKeys];
    }
}


- (BOOL)isValidKey:(NSString *)key{
    
    if (!key || key.length == 0 || (NSNull *)key == [NSNull null]) {
        return NO;
    }else{
        return YES;
    }
}

#pragma - mark public methods

- (void)doSave{
    
    [USER_DEFAULT setObject:[NSKeyedArchiver archivedDataWithRootObject:_cacheKeys] forKey:UD_KEY_DATA_CACHE_KEYS];
    [USER_DEFAULT setObject:[NSKeyedArchiver archivedDataWithRootObject:_cachedObjects] forKey:UD_KEY_DATA_CACHE_OBJECTS];
    
    [USER_DEFAULT synchronize];
}

- (void)clearAllCache{
    
    [self clearMemoryCache];
    [_cacheKeys removeAllObjects];
    [_cachedObjects removeAllObjects];
    
    [self doSave];
}

- (void)clearMemoryCache{
    
    [_memoryCacheKeys removeAllObjects];
    [_memoryCachedObjects removeAllObjects];
}

- (void)addObject:(NSObject *)obj forKey:(NSString *)key{
    
    if (![self isValidKey:key]) {
        return;
    }
    if (!obj || (NSNull *)obj == [NSNull null]) {
        return;
    }
    
    if ([self hasObjectInCacheForKey:key]) {
        [self removeObjectInCacheForKey:key];
    }
    
    [_cacheKeys addObject:key];
    [_cachedObjects setObject:obj forKey:key];
}

- (void)addObjectToMemory:(NSObject *)obj forKey:(NSString *)key{
    if (![self isValidKey:key]) {
        return;
    }
    
    if (!obj || (NSNull *)obj == [NSNull null]) {
        return;
    }
    if ([self hasObjectInCacheForKey:key]) {
        [self removeObjectInCacheForKey:key];
    }
    [_memoryCacheKeys addObject:key];
    [_memoryCachedObjects setObject:obj forKey:key];
}

- (BOOL)hasObjectInCacheForKey:(NSString *)key{
    
    return [self getCachedObjectForKey:key] != nil;
}

- (NSObject *)getCachedObjectForKey:(NSString *)key{
    
    if (![self isValidKey:key]) {
        return nil;
    }
    
    if ([_memoryCachedObjects objectForKey:key]) {
        return [_memoryCachedObjects objectForKey:key];
    }else{
        return [_cachedObjects objectForKey:key];
    }
}

- (void)removeObjectInCacheForKey:(NSString *)key{
    if (![self isValidKey:key]) {
        return;
    }
    
    [_cachedObjects removeObjectForKey:key];
    [self removeKey:key fromKeyArray:_cacheKeys];
    [_memoryCachedObjects removeObjectForKey:key];
    [self removeKey:key fromKeyArray:_memoryCacheKeys];
}
@end
