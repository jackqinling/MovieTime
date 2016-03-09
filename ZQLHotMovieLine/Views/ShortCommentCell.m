//
//  ShortCommentCell.m
//  ZQLHotMovieLine
//
//  Created by MacQin on 3/7/16.
//  Copyright © 2016 MS. All rights reserved.
//

#import "ShortCommentCell.h"
#import "ZQLDefinedImageView.h"
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
