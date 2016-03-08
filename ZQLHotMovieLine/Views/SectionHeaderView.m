//
//  SectionHeaderView.m
//  ZQLHotMovieLine
//
//  Created by MacQin on 3/8/16.
//  Copyright © 2016 MS. All rights reserved.
//

#import "SectionHeaderView.h"

@interface SectionHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *actionButton;
@end
@implementation SectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.frame = frame;
        [self.actionButton addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = _title;
}

- (void)onClick:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(didSelectHeaderView:)]) {
        [self.delegate didSelectHeaderView:self];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
