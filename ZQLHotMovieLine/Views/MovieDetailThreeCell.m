//
//  MovieDetailThreeCell.m
//  ZQLHotMovieLine
//
//  Created by MS on 16-1-21.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import "MovieDetailThreeCell.h"
#import "ImageModel.h"

@interface MovieDetailThreeCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@property (weak, nonatomic) IBOutlet UILabel *otherLabel;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imageArray;

@end
@implementation MovieDetailThreeCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setModel:(hotPointModel *)model{
    
    _model = model;
    
    self.titleLabel.text = model.title;
    self.descLabel.text = model.desc;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
        int i = 0;
        for (UIImageView * imageView in self.imageArray) {
            

            NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[_model.images[i] url1]]];
            UIImage * image = [UIImage imageWithData:data];
            if (image) {
                UIImageView * newImageView = [[UIImageView alloc] init];
                
                newImageView.frame = CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.width * image.size.height / image.size.width );
                newImageView.contentMode = UIViewContentModeScaleAspectFill;
                
                newImageView.image = image;
                dispatch_async(dispatch_get_main_queue(), ^{
                    //如何在下载完刷新tableView
                    [imageView addSubview:newImageView];
                    imageView.clipsToBounds = YES;
                });

            }
            i++;
        }
    });

    
    self.otherLabel.text = [NSString stringWithFormat:@"评论 %@",_model.commentCount];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
