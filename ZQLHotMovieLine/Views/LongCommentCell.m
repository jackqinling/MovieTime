//
//  LongCommentCell.m
//  ZQLHotMovieLine
//
//  Created by MacQin on 3/7/16.
//  Copyright © 2016 MS. All rights reserved.
//

#import "LongCommentCell.h"
#import "CommentDetailModel.h"
#import "UIColor+categoryColor.h"

@interface LongCommentCell ()

@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;

@end

@implementation LongCommentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(LongCommentModel *)model{
    
    _model = model;
    
    self.totalLabel.text = [NSString stringWithFormat:@"精选影评(%@)", _model.totalCount];
    CommentDetailModel * dModel = _model.comments[0];
    self.commentLabel.text = dModel.title;
    self.contentLabel.text = dModel.content;
    [self.headImageView setImageWithURL:[NSURL URLWithString:dModel.headurl] placeholderImage:PlaceHolder];
    self.nickNameLabel.text = dModel.nickname;
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:dModel.modifyTime.integerValue];
    self.timeLabel.text = [date description];
    if ([dModel.rating isEqualToString:@""]) {
        self.ratingLabel.text = @"";
    }else{
        NSString * str = [NSString stringWithFormat:@"看过 - 评分 %0.2f", (float)dModel.rating.integerValue];
        NSMutableAttributedString * atrStr = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11], NSForegroundColorAttributeName:[UIColor blackColor]}];
        
        NSRange range = NSRangeFromString(str);
        [atrStr setAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSBackgroundColorAttributeName:[UIColor barColor]} range:NSMakeRange(range.length - 2, 2)];
        
        self.ratingLabel.attributedText = atrStr;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
