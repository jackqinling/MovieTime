//
//  CitiesChoiceViewController.h
//  ZQLHotMovieLine
//
//  Created by zhaoqinling on 16/1/28.
//  Copyright © 2016年 MS. All rights reserved.
//

#import "ZQLBaseViewController.h"
#import "CityModel.h"

typedef void(^Block)(CityModel * city);

@interface CitiesChoiceViewController : ZQLBaseViewController

@property (nonatomic, copy) Block cityBlcok;

@end
