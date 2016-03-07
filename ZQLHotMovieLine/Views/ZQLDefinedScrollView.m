//
//  ZQLDefinedScrollView.m
//  ZQLHotMovieLine
//
//  Created by MS on 16-1-21.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import "ZQLDefinedScrollView.h"
#import "UIImageView+AFNetworking.h"
#import "ZQLScreenMacro.h"

@interface ZQLDefinedScrollView ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (assign) float preContentOffsetX;

@end
@implementation ZQLDefinedScrollView

//拖xib自动调用  该方法
- (instancetype)init{
    
    if (self == [super init]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"ZQLDefinedScrollView" owner:nil options:nil] firstObject];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self == [super initWithFrame:frame]) {
        
        self = [[[NSBundle mainBundle] loadNibNamed:@"ZQLDefinedScrollView" owner:nil options:nil] firstObject];
        self.frame = frame;
    }
    
    return self;
}
+ (instancetype)viewWithAdverModels:(NSArray *)adverModelsArray frame:(CGRect)frame{
    
    ZQLDefinedScrollView * view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ZQLDefinedScrollView class]) owner:nil options:nil] firstObject];
    view.frame = frame;
    view.adverModelsArray = adverModelsArray;
    
    return view;
}

- (void)setAdverModelsArray:(NSArray *)adverModelsArray{
    //设置代理
    self.mainScrollView.delegate = self;

    _adverModelsArray = adverModelsArray;
    self.pageControl.numberOfPages = _adverModelsArray.count;
    
    self.mainScrollView.contentSize = CGSizeMake(self.frame.size.width * (_adverModelsArray.count + 2), self.frame.size.height);
    self.mainScrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
    int i = 0;
    for (adverModel * model in _adverModelsArray) {
        
        ZQLDefinedImageView * view = [[ZQLDefinedImageView alloc] initWithFrame:CGRectMake((i + 1) * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
        
        [view setImageWithURL:[NSURL URLWithString:model.img2] placeholderImage:PlaceHolder];
        [view addTarget:self action:@selector(onClickImage:)];
        [self.mainScrollView addSubview:view];
        
        i++;
    }
    
    //设置附属骗人头尾视图
    [self settingAuxiliaryView];
    
    //给pageControl 添加方法
    
}

- (IBAction)changePage:(UIPageControl *)sender {
    
    [self.mainScrollView setContentOffset:CGPointMake((sender.currentPage + 1) * self.frame.size.width, 0) animated:YES];
}

//滚动视图添加 最后一个 和  最前面一个  实现连续无限滚动
- (void)settingAuxiliaryView{
    ZQLDefinedImageView * firstView = [[ZQLDefinedImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    adverModel * fmodel = [_adverModelsArray lastObject];
    [firstView setImageWithURL:[NSURL URLWithString:fmodel.img2] placeholderImage:PlaceHolder];
    ZQLDefinedImageView * lastView = [[ZQLDefinedImageView alloc] initWithFrame:CGRectMake((_adverModelsArray.count + 1) * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
    adverModel * lmodel = [_adverModelsArray firstObject];
    [lastView setImageWithURL:[NSURL URLWithString:lmodel.img2] placeholderImage:PlaceHolder];
    
    [self.mainScrollView addSubview:firstView];
    [self.mainScrollView addSubview:lastView];
}

//声明代理方法
- (void)onClickImage:(ZQLDefinedImageView *)imageView{
    NSLog(@"%lud",(unsigned long)[self.mainScrollView.subviews indexOfObject:imageView]);
    [self.delegate zqlDefinedScrollView:self didSelectView:imageView withModel:_adverModelsArray[[self.mainScrollView.subviews indexOfObject:imageView]]];
    
}

#pragma mark scrollView代理方法

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    int currentIndex = roundf(scrollView.contentOffset.x / self.frame.size.width);
    
    self.pageControl.currentPage = currentIndex - 1;
    
    if (scrollView.contentOffset.x == (_adverModelsArray.count + 1) * self.frame.size.width) {
        [scrollView setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
    }
    
    if (scrollView.contentOffset.x == 0) {
        [scrollView setContentOffset:CGPointMake((_adverModelsArray.count) * self.frame.size.width, 0) animated:NO];
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
