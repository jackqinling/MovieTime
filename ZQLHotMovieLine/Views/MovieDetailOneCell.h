//
//  MovieDetailOneCell.h
//  ZQLHotMovieLine
//
//  Created by MS on 16-1-21.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "hotPointModel.h"
@interface MovieDetailOneCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthRatioConstraint;

@property (nonatomic, strong) hotPointModel * model;

@end
