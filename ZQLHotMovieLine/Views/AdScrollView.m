//
//  AdScrollView.m
//  ZQLHotMovieLine
//
//  Created by MS on 16-1-21.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import "AdScrollView.h"
#import "ZQLDefinedImageView.m"
#import "adverModel.h"
#import "UIImageView+AFNetworking.h"

@interface AdScrollView ()

@property (weak, nonatomic) IBOutlet UIScrollView * scrollView;

@property (weak, nonatomic) IBOutlet UIPageControl * pageControl;

@end
@implementation AdScrollView

//拖xib自动调用  该方法
//- (instancetype)initWithFrame:(CGRect)frame{
//    
//    if (self == [super initWithFrame:frame]) {
//        
//        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([AdScrollView class]) owner:nil options:nil] firstObject];
//        
//    }
//    
//    return self;
//}
//+ (instancetype)viewWithAdverModels:(NSArray *)adverModelsArray frame:(CGRect)frame{
//    
//    AdScrollView * view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([AdScrollView class]) owner:nil options:nil] firstObject];
//    view.frame = frame;
//    view.adverModelsArray = adverModelsArray;
//    
//    return view;
//}
//
//- (void)setAdverModelsArray:(NSArray *)adverModelsArray{
//    
//    _adverModelsArray = adverModelsArray;
//    
//    self.scrollView.contentSize = CGSizeMake(self.frame.size.width * (_adverModelsArray.count + 2), self.frame.size.height);
//    
//    int i = 0;
//    for (adverModel * model in _adverModelsArray) {
//        
//        ZQLDefinedImageView * view = [[ZQLDefinedImageView alloc] initWithFrame:CGRectMake((i + 1) * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
//        
//        [view setImageWithURL:[NSURL URLWithString:model.img2] placeholderImage:[UIImage imageNamed:@"img_120x120"]];
//        
//        [self.scrollView addSubview:view];
//
//        i++;
//    }
//    
//    ZQLDefinedImageView * first = [[ZQLDefinedImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
//  
//    ZQLDefinedImageView * last = [[ZQLDefinedImageView alloc] initWithFrame:CGRectMake(_adverModelsArray.count * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
//    
    
    
    
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
