//
//  ZQLRequestManager.m
//  ZQLHotMovieLine
//
//  Created by MS on 16-1-10.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import "ZQLRequestManager.h"
#import "AFNetworking.h"
#import "ZQLBaseModel.h"

@interface ZQLRequestManager ()

@property (nonatomic, strong) AFHTTPRequestOperationManager * manager;

@end

@implementation ZQLRequestManager

- (AFHTTPRequestOperationManager *)manager{
    if (_manager == nil) {
        _manager = [AFHTTPRequestOperationManager manager];
        [_manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html", @"application/json", @"application/x-javascript", nil]];
    }
    return _manager;
}

/**
 *  GET proxy
 *
 *  @param urlStr     interface URL
 *  @param dic        parameters
 *  @param complicate complicate callback block
 *  @param modelClass returning type of model
 */
- (void)requestWithGetMethod:(NSString *)urlStr parameters:(NSDictionary *)dic complicate:(Complicate)complicate modelClassNameArray:(NSArray *)modelClassNameArray{
    
    [self.manager GET:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (complicate) {
           
            NSMutableArray * arrayOfModelsArray = [NSMutableArray array];
            
            for (NSString * modelClassName in modelClassNameArray) {
                NSArray * models = [NSClassFromString(modelClassName) arrayOfModelsFromJson:responseObject];
                [arrayOfModelsArray addObject:models];
            }
            
            complicate(YES, arrayOfModelsArray);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (complicate) {
            complicate(NO, error);
        }
    }];
    
}

- (void)getWithUrl:(NSString *)urlStr parameters:(NSDictionary *)dic complicate:(Complicate)complicate modelClass:(Class)class{
    
    [self.manager GET:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (complicate) {
            NSArray * resultArray = [class arrayOfModelsFromJson:responseObject];
            complicate(YES, resultArray);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (complicate) {
            complicate(NO, error);
        }
    }];
}

- (void)postWithUrl:(NSString *)urlStr parameters:(NSDictionary *)dic complicate:(Complicate)complicate modelClass:(Class)class{
    
    [self.manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (complicate) {
            NSArray * resultArray = [class arrayOfModelsFromJson:responseObject];
            complicate(YES, resultArray);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (complicate) {
            complicate(NO, error);
        }
    }];
}

- (void)requestWithPostMethod:(NSString *)urlStr parameters:(NSDictionary *)dic complicate:(Complicate)complicate modelClassNameArray:(NSArray *)modelClassNameArray{
    [self.manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (complicate) {
            NSMutableArray * arrayOfModelsArray = [NSMutableArray array];
            
            for (NSString * modelClassName in modelClassNameArray) {
                if ([modelClassName isEqualToString:@""] || ![modelClassName hasSuffix:@"Model"]) {
                    NSLog(@"传入model名有误,请检查!!!!!!!!!");
                    return;
                }
                NSArray * models = [NSClassFromString(modelClassName) arrayOfModelsFromJson:responseObject];
                [arrayOfModelsArray addObject:models];
            }
            
            complicate(YES, arrayOfModelsArray);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (complicate) {
            
            complicate(NO, error);
        }
    }];
}

@end
