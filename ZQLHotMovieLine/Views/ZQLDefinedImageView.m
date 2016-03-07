//
//  ZQLDefinedImageView.m
//  ZQLHotMovieLine
//
//  Created by MS on 16-1-16.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import "ZQLDefinedImageView.h"

@interface ZQLDefinedImageView ()

@property (assign, nonatomic) SEL selector;

@property (nonatomic, strong)id target;

@end

@implementation ZQLDefinedImageView

- (void)awakeFromNib{
    [self addTarget:self.target action:self.selector];
    
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        self.frame = frame;
    }
    return self;
}
- (IBAction)addTarget:(id)target action:(SEL)selector{
    self.selector = selector;
    self.target = target;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if ([self.target respondsToSelector:self.selector] == YES) {
        [self.target performSelector:self.selector withObject:self];
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
