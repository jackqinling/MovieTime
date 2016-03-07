//
//  ZQLRequestManager.h
//  ZQLHotMovieLine
//
//  Created by MS on 16-1-10.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void(^Complicate)(BOOL success, id object);

@interface ZQLRequestManager : NSObject

- (void)requestWithGetMethod:(NSString *)urlStr parameters:(NSDictionary *)dic complicate:(Complicate)complicate modelClassNameArray:(NSArray *)modelClassNameArray;

- (void)requestWithPostMethod:(NSString *)urlStr parameters:(NSDictionary *)dic complicate:(Complicate)complicate modelClassNameArray:(NSArray *)modelClassNameArray;
@end
