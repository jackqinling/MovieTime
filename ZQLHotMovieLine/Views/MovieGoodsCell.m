//
//  MovieGoodsCell.m
//  ZQLHotMovieLine
//
//  Created by zhaoqinling on 16/2/3.
//  Copyright © 2016年 MS. All rights reserved.
//

#import "MovieGoodsCell.h"
#import "ZQLDefinedImageView.h"
#import "GoodItemModel.h"

@interface MovieGoodsCell ()

@property (strong, nonatomic) IBOutletCollection(ZQLDefinedImageView) NSArray *goodImageView;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *goodNameLabel;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *goodPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *relatedLabel;

@end

@implementation MovieGoodsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(MovieGoodModel *)model{
    
    _model = model;
    if (_model.goodsList.count != 0) {
        
        self.relatedLabel.text = [NSString stringWithFormat:@"电影周边(%@)", _model.goodsCount];
        int i = 0;
        for (GoodItemModel * item in _model.goodsList) {
            if (i < 3) {
                [self.goodImageView[i] setImageWithURL:[NSURL URLWithString:item.image] placeholderImage:PlaceHolder];
                UILabel * label = self.goodNameLabel[i];
                label.text = item.name;
                UILabel * labelP = self.goodPriceLabel[i];
                labelP.text = [NSString stringWithFormat:@"￥%0.1f", [item.minSalePrice integerValue] / 100.0f];
                i++;
            }
        }
    }
   
    
}

@end
