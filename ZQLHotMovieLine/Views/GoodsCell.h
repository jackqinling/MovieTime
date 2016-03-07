//
//  GoodsCell.h
//  ZQLHotMovieLine
//
//  Created by MS on 16-1-20.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubGoodModel.h"
#import "ZQLDefinedImageView.h"

@class GoodsCell;

@protocol GoodsCellDelegate <NSObject>

- (void)goodsCell:(GoodsCell *)goodCell didSelectButton:(ZQLDefinedImageView *)goodButton withModel:(SubGoodModel *)model;


@end
@interface GoodsCell : UITableViewCell

@property (nonatomic, weak) id<GoodsCellDelegate>delegate;

@property (nonatomic, strong) NSArray * models;
@end
