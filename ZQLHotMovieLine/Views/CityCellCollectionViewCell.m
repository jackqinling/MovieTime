//
//  CityCellCollectionViewCell.m
//  ZQLHotMovieLine
//
//  Created by zhaoqinling on 16/1/29.
//  Copyright © 2016年 MS. All rights reserved.
//

#import "CityCellCollectionViewCell.h"

@interface CityCellCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *cityLabel;


@end
@implementation CityCellCollectionViewCell

- (void)setModel:(CityModel *)model{
    
    _model = model;
    self.cityLabel.text = model.n;
}
- (void)awakeFromNib {
    // Initialization code
}

@end
