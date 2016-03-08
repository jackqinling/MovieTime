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
    if (_model.comments.count != 0) {
        self.totalLabel.text = [NSString stringWithFormat:@"精选影评(%@)", _model.totalCount];
        CommentDetailModel * dModel = _model.comments[0];
        self.commentLabel.text = dModel.title;
        NSMutableString * contentStr = [NSMutableString stringWithString:dModel.content];
        [contentStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, contentStr.length)];
        self.contentLabel.text = contentStr;
        
        self.headImageView.layer.masksToBounds = YES;
        self.headImageView.layer.cornerRadius = self.headImageView.frame.size.width / 2.0f;
        [self.headImageView setImageWithURL:[NSURL URLWithString:dModel.headurl] placeholderImage:PlaceHolder];
        self.nickNameLabel.text = dModel.nickname;
        NSDate * date = [NSDate dateWithTimeIntervalSince1970:dModel.modifyTime.integerValue];
        NSDateFormatter * dateFormater = [[NSDateFormatter alloc] init];
        dateFormater.dateFormat = @"yyyy-MM-dd HH:mm";
        NSString * dateStr = [dateFormater stringFromDate:date];
        self.timeLabel.text = dateStr;
        if ([dModel.rating isEqualToString:@"0"]) {
            self.ratingLabel.text = @"";
        }else{
            NSString * str = [NSString stringWithFormat:@"看过 - 评分 %0.1f", (float)dModel.rating.integerValue];
            NSMutableAttributedString * atrStr = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11], NSForegroundColorAttributeName:[UIColor blackColor]}];
            
            [atrStr setAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSBackgroundColorAttributeName:[UIColor greenBack], NSFontAttributeName:[UIFont systemFontOfSize:14]} range:NSMakeRange(str.length - 3, 3)];
            
            self.ratingLabel.attributedText = atrStr;
        }

    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
