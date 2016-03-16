//
//  MovieHeaderView.h
//  ZQLHotMovieLine
//
//  Created by zhaoqinling on 16/1/30.
//  Copyright © 2016年 MS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieDetailModel.h"

@protocol MovieHeaderViewDelegate <NSObject>

- (void)didClickHeaderViewPlayButtonWithModel:(MovieDetailModel *)model;

@end
@interface MovieHeaderView : UIView

@property (nonatomic, weak) id<MovieHeaderViewDelegate>delegate;

@property (nonatomic, strong) MovieDetailModel * model;

- (instancetype)initWithFrame:(CGRect)frame;

+ (instancetype)viewWithModel:(MovieDetailModel *)model frame:(CGRect)frame;

@end
