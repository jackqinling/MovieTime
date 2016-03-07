//
//  MovieHeaderView.m
//  ZQLHotMovieLine
//
//  Created by zhaoqinling on 16/1/30.
//  Copyright © 2016年 MS. All rights reserved.
//

#import "MovieHeaderView.h"
#import "UIImageView+AFNetworking.h"

@interface MovieHeaderView ()

@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;

@property (weak, nonatomic) IBOutlet UIButton *wantSeeBtn;
@property (weak, nonatomic) IBOutlet UIButton *wantComment;

@property (weak, nonatomic) IBOutlet UILabel *nameChLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameEnLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieLengthLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieStyleLabel;
@property (weak, nonatomic) IBOutlet UILabel *showTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *doubleMarkImageView;
@property (weak, nonatomic) IBOutlet UIButton *buyTickeBtn;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (weak, nonatomic) IBOutlet UIImageView *backGroundImageView;
@end
@implementation MovieHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"MovieHeaderView" owner:nil options:nil] firstObject];
        self.frame = frame;
    }
    
    return self;
}

+ (instancetype)viewWithModel:(MovieDetailModel *)model frame:(CGRect)frame{
    
    MovieHeaderView * header = [[[NSBundle mainBundle] loadNibNamed:@"MovieHeaderView" owner:nil options:nil] firstObject];
    header.frame = frame;
    
    header.model = model;
    
    return header;
}

- (void)setModel:(MovieDetailModel *)model{
    
    _model = model;
    
    [self.posterImageView setImageWithURL:[NSURL URLWithString:_model.image] placeholderImage:PlaceHolder];
    self.nameChLabel.text = _model.titleCn;
    self.nameEnLabel.text = _model.titleEn;
    self.movieLengthLabel.text = _model.runTime;
    self.scoreLabel.text = _model.rating;
    if ([_model.commonSpecial isEqualToString:@""]) {
        self.doubleMarkImageView.hidden = YES;
    }else{
        self.doubleMarkImageView.hidden = NO;
    }
    self.commentLabel.text = _model.commonSpecial;
    
    NSArray * dateArray = [_model.movieRelease.date componentsSeparatedByString:@"-"];
    NSMutableString * str = [NSMutableString string];
    [str appendFormat:@"%@年%@月%@日%@上映", dateArray[0], dateArray[1], dateArray[2], _model.movieRelease.location];
    self.showTimeLabel.text = str;
    
    [self.backGroundImageView setImageWithURL:[NSURL URLWithString:_model.image] placeholderImage:PlaceHolder];
    
    UIImage * image = [UIImage imageNamed:@"v10_bt_green.png"];
    [image stretchableImageWithLeftCapWidth:80 topCapHeight:32];
    
    [self.wantSeeBtn setBackgroundImage:image forState:UIControlStateNormal];
    [self.wantComment setBackgroundImage:image forState:UIControlStateNormal];
}
- (IBAction)buyTicket:(UIButton *)sender {
    NSLog(@"我是买票");
}
- (IBAction)onClickPoster:(UIButton *)sender {
    NSLog(@"我是poster");
}
- (IBAction)wantToSee:(id)sender {
    NSLog(@"想看");
}
- (IBAction)wantToComment:(id)sender {
    NSLog(@"我要评分");
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
