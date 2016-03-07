//
//  MovieAwardCell.m
//  ZQLHotMovieLine
//
//  Created by zhaoqinling on 16/2/3.
//  Copyright © 2016年 MS. All rights reserved.
//

#import "MovieAwardCell.h"

@interface MovieAwardCell ()

@property (weak, nonatomic) IBOutlet UILabel *_hotRankLabel;

@property (weak, nonatomic) IBOutlet UILabel *_weekOfficeBox;
@property (weak, nonatomic) IBOutlet UILabel *_totalOfficeBoxLabel;
@property (weak, nonatomic) IBOutlet UILabel *_awardInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalUnitLabel;
@property (weak, nonatomic) IBOutlet UILabel *weekUnitLabel;

@end
@implementation MovieAwardCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(MovieDetailModel *)model{
    _model = model;
    
    self._hotRankLabel.text = _model.hotRanking;
    self._weekOfficeBox.text = _model.weekBoxOffice;
    self._totalOfficeBoxLabel.text = _model.totalBoxOffice;
    self.weekUnitLabel.text = [NSString stringWithFormat:@"周票房(%@)", _model.weekBoxOfficeUnit];
    self.totalUnitLabel.text = [NSString stringWithFormat:@"累计票房(%@)", _model.totalBoxOfficeUnit];
    self._awardInfoLabel.text = [NSString stringWithFormat:@"获奖记录:共获奖%@次,提名%@次", _model.totalWinAward, _model.totalNominateAward];
}
@end
