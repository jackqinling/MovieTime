//
//  MovieDetailOneCell.m
//  ZQLHotMovieLine
//
//  Created by MS on 16-1-21.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import "MovieDetailOneCell.h"

@interface MovieDetailOneCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@end
@implementation MovieDetailOneCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(hotPointModel *)model{
    
    _model = model;
 
    self.descLabel.text = model.title;
    self.commentLabel.text = model.desc;
    self.timeLabel.text = [NSString stringWithFormat:@"评论 %@", model.commentCount];
    [self.headImage setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:PlaceHolder];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
