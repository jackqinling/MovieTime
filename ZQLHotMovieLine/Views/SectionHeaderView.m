//
//  SectionHeaderView.m
//  ZQLHotMovieLine
//
//  Created by MacQin on 3/8/16.
//  Copyright © 2016 MS. All rights reserved.
//

#import "SectionHeaderView.h"
#import "ZQLScreenMacro.h"

@interface SectionHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *actionButton;
@end
@implementation SectionHeaderView

//- (instancetype)initWithFrame:(CGRect)frame{
//    if (self = [super initWithFrame:frame]) {
//        self = [[[NSBundle mainBundle] loadNibNamed:@"SectionHeaderView" owner:nil options:nil] firstObject];
//        self.frame = frame;
//        [self.actionButton addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return self;
//}

- (void)awakeFromNib{
   
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"SectionHeaderView" owner:nil options:nil] firstObject];
        [self.actionButton addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        self.frame = CGRectMake(0, 0, ZScreenWidth, 60);
    }
    return self;
}
- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = _title;
}

- (void)onClick:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(didSelectHeaderView:)]) {
        //这句话就是简单的对象调用语句,调用或者执行了哪个方法
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
