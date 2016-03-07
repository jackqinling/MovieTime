//
//  GoodsCell.m
//  ZQLHotMovieLine
//
//  Created by MS on 16-1-20.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import "GoodsCell.h"
#import "UIImageView+AFNetworking.h"

@interface GoodsCell ()

@property (strong, nonatomic) IBOutletCollection(ZQLDefinedImageView) NSArray *goodButtons;

@end

@implementation GoodsCell

- (void)setModels:(NSArray *)models{
    
    _models = models;
    int i = 0;
    for (SubGoodModel * good in models) {

        [self.goodButtons[i] setImageWithURL:[NSURL URLWithString:good.image] placeholderImage:[UIImage imageNamed:@"mtime_default_image_146x146"]];
        i++;
    }
    for (ZQLDefinedImageView * button in self.goodButtons) {
        button.userInteractionEnabled = YES;
        [button addTarget:self action:@selector(onClickGoodButton:)];
    }
}

- (void)onClickGoodButton:(ZQLDefinedImageView *)goodButton{
    //代理
    NSLog(@"货物按钮代理%lu", [self.goodButtons indexOfObject:goodButton]);
    [self.delegate goodsCell:self didSelectButton:goodButton withModel:self.models[[self.goodButtons indexOfObject:goodButton]]];
}
- (void)awakeFromNib {
    // Initialization code
 
}

- (void)layoutSubviews{
   
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
