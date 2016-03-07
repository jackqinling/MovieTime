//
//  PerfectMovieCell.m
//  ZQLHotMovieLine
//
//  Created by MS on 16-1-24.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import "PerfectMovieCell.h"

@interface PerfectMovieCell ()

@property (weak, nonatomic) IBOutlet UIImageView *topCoverImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@property (weak, nonatomic) IBOutlet UIImageView *bookImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleChLabel;

@property (weak, nonatomic) IBOutlet UILabel *titleEnLabel;

@end
@implementation PerfectMovieCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(HotMovieModel *)model{
    
    _model = model;
    
    [self.topCoverImageView setImageWithURL:[NSURL URLWithString:_model.topCover] placeholderImage:PlaceHolder];
    
    self.titleLabel.text = _model.title;
    self.descLabel.text = _model.movie.desc;
    
    [self.bookImageView setImageWithURL:[NSURL URLWithString:_model.movie.image] placeholderImage:PlaceHolder];
    
    self.titleChLabel.text = _model.movie.titleCn;
    self.titleEnLabel.text = _model.movie.titleEn;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
