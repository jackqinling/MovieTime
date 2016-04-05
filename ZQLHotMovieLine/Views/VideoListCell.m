//
//  VideoListCell.m
//  ZQLHotMovieLine
//
//  Created by MacQin on 3/19/16.
//  Copyright © 2016 MS. All rights reserved.
//

#import "VideoListCell.h"

@interface VideoListCell ()

@property (weak, nonatomic) IBOutlet UIImageView *PosterImageView;
@property (weak, nonatomic) IBOutlet UILabel *TitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *TimeLabel;
@end
@implementation VideoListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(VideoListModel *)model{
    _model = model;
    
    [self.PosterImageView setImageWithURL:[NSURL URLWithString:_model.image] placeholderImage:PlaceHolder];
    self.TitleLabel.text = _model.title;
    
    NSInteger minute = [_model.length integerValue] / 60;
    NSInteger sec = [_model.length integerValue] % 60;
    if (minute) {
        self.TimeLabel.text = [NSString stringWithFormat:@"片长:%ld分%ld秒", minute, sec];
    }else{
        self.TimeLabel.text = [NSString stringWithFormat:@"片长:%ld秒", sec];
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
