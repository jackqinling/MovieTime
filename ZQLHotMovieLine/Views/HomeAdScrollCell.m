//
//  HomeAdScrollCell.m
//  ZQLHotMovieLine
//
//  Created by MS on 16-1-21.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import "HomeAdScrollCell.h"
#import "ZQLDefinedScrollView.h"
@interface HomeAdScrollCell ()

@property (strong, nonatomic) IBOutlet ZQLDefinedScrollView *homeScrollView;

@end
@implementation HomeAdScrollCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setAdverModelsArray:(NSArray *)adverModelsArray{
    _adverModelsArray = adverModelsArray;
    self.homeScrollView = [ZQLDefinedScrollView viewWithAdverModels:_adverModelsArray frame:self.bounds];
    
    [self.contentView addSubview:self.homeScrollView];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
