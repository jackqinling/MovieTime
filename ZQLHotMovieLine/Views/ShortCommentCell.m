//
//  ShortCommentCell.m
//  ZQLHotMovieLine
//
//  Created by MacQin on 3/7/16.
//  Copyright © 2016 MS. All rights reserved.
//

#import "ShortCommentCell.h"

@interface ShortCommentCell ()

@property (weak, nonatomic) IBOutlet UIView *sectionHeaderView;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end
@implementation ShortCommentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(SCommentModel *)model{
    
    _model = model;
    
    self.headImageView.layer.masksToBounds = YES;
    self.headImageView.layer.cornerRadius = self.headImageView.frame.size.width / 2.0f;
    [self.headImageView setImageWithURL:[NSURL URLWithString:_model.caimg] placeholderImage:PlaceHolder];
    self.nickNameLabel.text = _model.ca;
    self.contentLabel.text = _model.ce;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
