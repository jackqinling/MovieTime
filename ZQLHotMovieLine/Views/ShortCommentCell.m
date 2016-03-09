//
//  ShortCommentCell.m
//  ZQLHotMovieLine
//
//  Created by MacQin on 3/7/16.
//  Copyright © 2016 MS. All rights reserved.
//

#import "ShortCommentCell.h"
#import "ZQLDefinedImageView.h"
#import "UIColor+categoryColor.h"
@interface ShortCommentCell ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentImageHeigthCon;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet ZQLDefinedImageView *commentImageView;

@end
@implementation ShortCommentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(SCommentModel *)model{
    
    _model = model;
    [self.commentImageView addTarget:self action:@selector(onClick:)];

    self.headImageView.layer.masksToBounds = YES;
    self.headImageView.layer.cornerRadius = self.headImageView.frame.size.width / 2.0f;
    [self.headImageView setImageWithURL:[NSURL URLWithString:_model.caimg] placeholderImage:PlaceHolder];
    self.nickNameLabel.text = _model.ca;
    self.contentLabel.text = _model.ce;
    //图片评论
    if ([_model.ceimg isEqualToString:@""]) {
        self.commentImageView.hidden = YES;
        self.commentImageHeigthCon.constant = 0;
    }else{
        self.commentImageView.hidden = NO;
        self.commentImageHeigthCon.constant = 70;
        [self.commentImageView setImageWithURL:[NSURL URLWithString:_model.ceimg] placeholderImage:PlaceHolder];
    }
    NSUInteger interval = [[NSDate date] timeIntervalSinceDate:[NSDate dateWithTimeIntervalSince1970:_model.lcd.integerValue]];
    NSLog(@"%ld", interval);
    interval = interval + 3600 * 8;
    NSUInteger time = 0;
    NSMutableString * str = [NSMutableString string];
    if (interval / 60 == 0) {
        time = interval;
        [str appendString:@"秒前"];
    }else if (interval / 60 / 60 == 0){
        [str appendString:@"分钟前"];
        time = interval / 60;
    }else if (interval / 60 / 60 / 60 == 0){
        [str appendString:@"小时前"];
        time = interval / 60 / 60;
    }else {
        [str appendString:@"天前"];
        time = interval / 60 / 60 / 60 / 24;
    }
    NSLog(@"%ld", time);
    [str insertString:[NSString stringWithFormat:@"%ld", time] atIndex:0];
    [str appendString:[NSString stringWithFormat:@" - 评 %.1f", _model.cr.floatValue]];
    
    NSMutableAttributedString * atrStr = [[NSMutableAttributedString alloc] initWithString:str];
    [atrStr setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13], NSForegroundColorAttributeName:[UIColor whiteColor], NSBackgroundColorAttributeName:[UIColor greenBack]} range:NSMakeRange(str.length - 3, 3)];
    self.ratingLabel.attributedText = atrStr;
}

- (void)onClick:(ZQLDefinedImageView *)imageView{
    NSLog(@"点击了cell的图片");
    //让代理去干事去
    ZQLDefinedImageView * windowImageView = [[ZQLDefinedImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    windowImageView.backgroundColor = [UIColor blackColor];
    windowImageView.contentMode = UIViewContentModeScaleAspectFit;
    [windowImageView setImageWithURL:[NSURL URLWithString:self.model.ceimg] placeholderImage:PlaceHolder];
    [[[UIApplication sharedApplication].delegate window] addSubview:windowImageView];
    
    [windowImageView addTarget:self action:@selector(removeImageView:)];
    
}

- (void)removeImageView:(ZQLDefinedImageView *)imageView{
    [imageView removeFromSuperview];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
