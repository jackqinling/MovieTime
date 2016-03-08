//
//  ShortCommentCell.h
//  ZQLHotMovieLine
//
//  Created by MacQin on 3/7/16.
//  Copyright © 2016 MS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCommentModel.h"

@interface ShortCommentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightCon;
@property (weak, nonatomic) IBOutlet UIView *sectionHeaderView;

@property (weak, nonatomic) IBOutlet UILabel *totalCommentLabel;

@property (nonatomic, strong) SCommentModel * model;

@end
