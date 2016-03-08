//
//  ActorCell.m
//  ZQLHotMovieLine
//
//  Created by zhaoqinling on 16/2/4.
//  Copyright © 2016年 MS. All rights reserved.
//

#import "ActorCell.h"
#import "ActorSimpleModel.h"
@interface ActorCell()
@property (weak, nonatomic) IBOutlet UILabel *allActorsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *directorImageView;
@property (weak, nonatomic) IBOutlet UILabel *directorNameCh;

@property (weak, nonatomic) IBOutlet UILabel *directorNameEn;

@property (weak, nonatomic) IBOutlet UIImageView *actor1ImageView;
@property (weak, nonatomic) IBOutlet UILabel *actor1NameCh;
@property (weak, nonatomic) IBOutlet UILabel *actor1NameEn;
@property (weak, nonatomic) IBOutlet UIImageView *role1ImageView;
@property (weak, nonatomic) IBOutlet UILabel *role1NameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *actor2ImageView;
@property (weak, nonatomic) IBOutlet UILabel *actor2NameCh;

@property (weak, nonatomic) IBOutlet UILabel *actor2NameEn;
@property (weak, nonatomic) IBOutlet UIImageView *role2ImageView;
@property (weak, nonatomic) IBOutlet UILabel *role2NameLabel;

@end
@implementation ActorCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(MovieDetailModel *)model{
    _model = model;
    self.allActorsLabel.text = [NSString stringWithFormat:@"%@位演职员", _model.personCount];
    [self.directorImageView setImageWithURL:[NSURL URLWithString:_model.director.directorImg] placeholderImage:PlaceHolder];
    self.directorImageView.clipsToBounds = YES;
    self.directorNameCh.text = _model.director.directorName;
    self.directorNameEn.text = _model.director.directorNameEn;
    
    ActorModel * actor1 = _model.actorList[0];
    ActorModel * actor2 = _model.actorList[1];
    
    
    NSArray * imageViewArray = @[self.actor1ImageView, self.actor2ImageView];
    NSArray * actorArray;
    if (actor1 && actor2) {
        actorArray = @[actor1, actor2];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                for (int i = 0; i < actorArray.count; i++){
                    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[actorArray[i] actorImg]]];
                    UIImage * image = [UIImage imageWithData:data];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIImageView * newImageView = [[UIImageView alloc] init];
                        if (image) {
                            newImageView.frame = CGRectMake(0, 0, [imageViewArray[i] frame].size.width, [imageViewArray[i] frame].size.width * image.size.height / image.size.width);
                            newImageView.image = image;
                            [imageViewArray[i] addSubview:newImageView];
                        }
                    });

                }

            });
    
    }
    
//    [self.actor1ImageView setClipsToBounds:YES];
//    [self.actor1ImageView setImageWithURL:[NSURL URLWithString:actor1.actorImg] placeholderImage:PlaceHolder];
//    [self.actor2ImageView setImageWithURL:[NSURL URLWithString:actor2.actorImg] placeholderImage:PlaceHolder];
    self.actor1NameCh.text = actor1.actor;
    self.actor1NameEn.text = actor1.actorEn;
    self.actor2NameCh.text = actor2.actor;
    self.actor2NameEn.text = actor2.actorEn;
    
    [self.role1ImageView setImageWithURL:[NSURL URLWithString:actor1.roleImg] placeholderImage:PlaceHolder];
    self.role1NameLabel.text = [NSString stringWithFormat:@"饰:%@", actor1.roleName];
    [self.role2ImageView setImageWithURL:[NSURL URLWithString:actor2.roleImg] placeholderImage:PlaceHolder];
    self.role2NameLabel.text = [NSString stringWithFormat:@"饰:%@",actor2.roleName];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
