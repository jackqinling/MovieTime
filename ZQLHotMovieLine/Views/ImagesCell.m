//
//  ImagesCell.m
//  ZQLHotMovieLine
//
//  Created by 赵秦岭 on 16/2/4.
//  Copyright © 2016年 MS. All rights reserved.
//

#import "ImagesCell.h"


@interface ImagesCell ()

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imgesArray;

@end
@implementation ImagesCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(MovieDetailModel *)model{
    
    _model = model;
    
    int i = 0;
    for (NSString * imageUrlStr in _model.images) {
        
        [self.imgesArray[i] setHidden:NO];
        [self.imgesArray[i] setContentMode:UIViewContentModeScaleAspectFill];
        [self.imgesArray[i] setClipsToBounds:YES];
        [self.imgesArray[i] setImageWithURL:[NSURL URLWithString:imageUrlStr] placeholderImage:PlaceHolder];
        i++;
    }
}

@end
