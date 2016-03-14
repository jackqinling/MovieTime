//
//  HeadPosterView.m
//  ZQLHotMovieLine
//
//  Created by MS on 16-1-15.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import "HeadPosterView.h"
#import "ZQLScreenMacro.h"
#import "UIButton+AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "UIImage+ImageEffects.h"
#import "ZQLDefinedImageView.h"
#import "UIColor+categoryColor.h"
#import "ZQLScreenMacro.h"
#import "ZQLScreenMacro.h"

#define WindowWidth (ZScreenWidth - 40)
#define HeadSubViewHeight 170.0f
#define HeadImageSpace 50.0f
#define Scale 0.3f

#define PreGap ((ZScreenWidth - WindowWidth) / 2.0f)
#define ImageWidth (WindowWidth / 2.0f - HeadImageSpace)
#define ScrollViewHeight (self.frame.size.height - HeadSubViewHeight)
#define PageWidth (ImageWidth + HeadImageSpace)


@interface HeadPosterView ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *backGroundImage;

@property (weak, nonatomic) IBOutlet UIScrollView *headScrollView;

@property (weak, nonatomic) IBOutlet UILabel *commonSpecialLabel;

@property (weak, nonatomic) IBOutlet UILabel *totalLabel;

@property (weak, nonatomic) IBOutlet UILabel *comingLabel;

@property (weak, nonatomic) IBOutlet UILabel *cimemaLabel;

@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@property (weak, nonatomic) IBOutlet UIButton *detailButton;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *headButtons;

@property (weak, nonatomic) IBOutlet UIImageView *quotImageView;

@property (weak, nonatomic) IBOutlet UILabel *movieNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *intLabel;

@property (weak, nonatomic) IBOutlet UILabel *decemalLabel;


@property (nonatomic, assign) float distance;

@property (nonatomic, assign) float bouncesDis;

@property (nonatomic, assign) float speed;

@property (nonatomic, assign) float preContentOffsetX;
@end

@implementation HeadPosterView

//这句话是干啥的
//- (instancetype)initWithFrame:(CGRect)frame{
//    if (self == [super initWithFrame:frame]) {
//        self = [[[NSBundle mainBundle] loadNibNamed:@"HeadPosterView" owner:nil options:nil] firstObject];
//        self.frame = frame;
//        
//    }
//    return self;
//}
+ (instancetype)viewWithModel:(MovieInfoModel *)model frame:(CGRect)frame{
    
    HeadPosterView * headView = [[[NSBundle mainBundle] loadNibNamed:@"HeadPosterView" owner:nil options:nil] firstObject];
    headView.frame = frame;
    headView.model = model;
    headView.movies = model.movies;
    
  
    return headView;
}

- (void)setModel:(MovieInfoModel *)model{
    
    _model = model;
    
    //setting subbuttons
    for (UIButton * button in self.headButtons) {
        [button addTarget:self action:@selector(onClickSubButton:) forControlEvents:UIControlEventTouchUpInside];
    }

    self.totalLabel.text = model.totalHotMovie;
    self.comingLabel.text = model.totalComingMovie;
    self.cimemaLabel.text = model.totalCinemaCount;
    
}
- (void)setMovies:(NSArray *)movies{
    _movies = movies;
  
    self.headScrollView.contentSize = CGSizeMake(ZScreenWidth + (_movies.count - 1) * (WindowWidth / 2.0f), ScrollViewHeight);
    //设置滚动视图代理

    self.headScrollView.delegate = self;
    
    int i = 0;
    
    for (MovieModel * model in _movies) {
        
        ZQLDefinedImageView * button = [[ZQLDefinedImageView alloc] initWithFrame:CGRectMake(PreGap + ImageWidth * (0.5 + i) + (i + 1) * HeadImageSpace, ImageWidth * 0.25 + NaviBarHeight, ImageWidth, ImageWidth * 1.4)];
        
        [button setImageWithURL:[NSURL URLWithString:model.img]];
        [button addTarget:self action:@selector(onClickImage:)];
        
        button.highlighted = NO;
        if (i == 0) {
            button.transform = CGAffineTransformMakeScale(1 + Scale, 1 + Scale);
        }
        [self.headScrollView addSubview:button];
        
        i++;
    }
    
    [self showModelAtIndex:0];

}


//展示  model   带回来的信息
- (void)showModelAtIndex:(NSInteger)index{
    if (index >=0 && index < _movies.count) {
        MovieModel * movie = _movies[index];
    
        [self.backGroundImage setImageWithURL:[NSURL URLWithString:movie.img] placeholderImage:[UIImage imageNamed:@"index_img_bg.png"]];
        self.movieNameLabel.text = movie.titleCn;
        
        if (movie.ratingFinal > 0) {
            int score = (movie.ratingFinal * 10) /10;
            int point = (int)(movie.ratingFinal * 10) % 10;
            
            self.intLabel.text = [NSString stringWithFormat:@"%d", score];
            self.decemalLabel.text = [NSString stringWithFormat:@".%d", point];
        }else{
            self.intLabel.text = @"";
            self.decemalLabel.text = @"";
        }
        
        self.movieNameLabel.text = movie.titleCn;
        
        self.commonSpecialLabel.text = movie.commonSpecial;
        [self.detailButton setTitle:@"选座购票" forState:UIControlStateNormal];
        self.detailButton.titleLabel.font = [UIFont systemFontOfSize:18];
        UIImage * image = [UIImage imageNamed:@"bt_solid_orange_50"];
        
        UIImage * strtch = [image stretchableImageWithLeftCapWidth:40 topCapHeight:0];
        
        [self.detailButton setBackgroundImage:strtch forState:UIControlStateNormal];
        
        if ([movie.commonSpecial isEqualToString:@""]) {
            self.quotImageView.hidden = YES;
            NSMutableAttributedString * want = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",movie.wantedCount] attributes:@{NSForegroundColorAttributeName:[UIColor orangeBack],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
            
            NSAttributedString * type = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"人想看-%@/", movie.type] attributes:@{NSForegroundColorAttributeName:[UIColor blackColor], NSFontAttributeName:[UIFont systemFontOfSize:16]}];
            
            NSAttributedString * director = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@/", movie.directorName] attributes:@{NSForegroundColorAttributeName:[UIColor blackColor], NSFontAttributeName:[UIFont systemFontOfSize:16]}];
            NSAttributedString * actor = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@/", movie.actorName1] attributes:@{NSForegroundColorAttributeName:[UIColor blackColor], NSFontAttributeName:[UIFont systemFontOfSize:16]}];
            [want appendAttributedString:type];
            
            [want appendAttributedString:director];
            
            [want appendAttributedString:actor];
            
            
            
            self.commonSpecialLabel.attributedText = want;
            
        }else{
            self.quotImageView.hidden = NO;
            self.commentLabel.text = movie.commonSpecial;
        }
    }
}

#pragma mark - scrollView 代理方法
//结束减速时  更改显示内容
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    int index = scrollView.contentOffset.x / PageWidth;
//    
//    [self showModelAtIndex:index];
//}
//
- (CGPoint)nextContentOffsetFromCurrentOffset:(CGPoint)offset nextPage:(int)page{
    
    int index = offset.x / PageWidth;
    CGPoint point = CGPointMake((index + page) * PageWidth, offset.y);
    return point;
}

//拖动即将结束是判断速度 根据velocity.x  确定将要滑到第几个
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    

    
    if (velocity.x > 0 && velocity.x < 0.6) {
        
        CGPoint point = [self nextContentOffsetFromCurrentOffset:scrollView.contentOffset nextPage:1];
        
        targetContentOffset->x = point.x;
        targetContentOffset->y = point.y;
        
    }else if (velocity.x >= 0.6 && velocity.x <= 2.0){
        CGPoint point = [self nextContentOffsetFromCurrentOffset:scrollView.contentOffset nextPage:2];
        
        targetContentOffset->x = point.x;
        targetContentOffset->y = point.y;
        
    }else if (velocity.x > 2.0){
        
        CGPoint point = [self nextContentOffsetFromCurrentOffset:scrollView.contentOffset nextPage:3];
        targetContentOffset->x = point.x;
        targetContentOffset->y = point.y;
    }else if (velocity.x < 0 && velocity.x > -0.6){
        
        CGPoint point = [self nextContentOffsetFromCurrentOffset:scrollView.contentOffset nextPage:-1];
        
        targetContentOffset->x = point.x;
        targetContentOffset->y = point.y;
    }else if (velocity.x <= - 0.6 && velocity.x > -2.0){
        CGPoint point = [self nextContentOffsetFromCurrentOffset:scrollView.contentOffset nextPage:-2];
        
        targetContentOffset->x = point.x;
        targetContentOffset->y = point.y;
    }else if (velocity.x <= - 2.0){

        CGPoint point = [self nextContentOffsetFromCurrentOffset:scrollView.contentOffset nextPage:-3];
        
        targetContentOffset->x = point.x;
        targetContentOffset->y = point.y;
    }else if (velocity.x == 0){
        
        int nextIndex = roundf(scrollView.contentOffset.x / PageWidth);
        CGPoint point = CGPointMake(nextIndex * PageWidth, 0);
        
        targetContentOffset->x = point.x;
        targetContentOffset->y = point.y;
   
    }
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    self.distance = scrollView.contentOffset.x;
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    static int currentIndex = 0;
    static int pageIndex = 0;
    
    //往右边滑动
    //当前滑到第几个  范围之内
    
    currentIndex = scrollView.contentOffset.x / PageWidth;
    pageIndex = roundf(scrollView.contentOffset.x / PageWidth);
//    NSLog(@"%d", currentIndex);
    ZQLDefinedImageView * midView = [scrollView subviews][currentIndex];
  
    float scale = (scrollView.contentOffset.x - currentIndex * PageWidth) / PageWidth * Scale;

    
    if (scrollView.contentOffset.x >= self.preContentOffsetX) {
        [self showModelAtIndex:pageIndex];
        //开始往右边滑动
        if (currentIndex < _movies.count - 1) {
            ZQLDefinedImageView * nextView = [scrollView subviews][currentIndex + 1];
            midView.transform = CGAffineTransformMakeScale(1 + Scale - scale, 1 + Scale - scale);
            nextView.transform = CGAffineTransformMakeScale(1 + scale, 1 + scale);
        }
        
    }else{
        [self showModelAtIndex:pageIndex];
        //开始向左边滑动 向左边时  midView 变成左边 的view 当前的midView 要加上 1
            ZQLDefinedImageView * currentMidView = [scrollView subviews][currentIndex + 1];
            
            midView.transform = CGAffineTransformMakeScale(1 + Scale - scale, 1 + Scale - scale);
            currentMidView.transform = CGAffineTransformMakeScale(1 + scale, 1 + scale);
    }
    
    self.preContentOffsetX = scrollView.contentOffset.x;
}



#pragma mark 触发headPosterView代理方法
//点击图片设置代理
- (void)onClickImage:(ZQLDefinedImageView *)button{
    
    
    NSUInteger index = [self.headScrollView.subviews indexOfObject:button];
    NSLog(@"%lu", index);
    
    NSInteger currentIndex = self.headScrollView.contentOffset.x / PageWidth;
    NSLog(@"%lu", currentIndex);
    if (index != currentIndex) {
        [self.headScrollView setContentOffset:CGPointMake(index * PageWidth, 0) animated:YES];
        return;
    }
    //设置代理  让代理干该干的事
    [self.delegate headPosterView:self didSelectImageView:button withModel:_movies[index]];
}

- (IBAction)butTicket:(UIButton *)sender {
    NSLog(@"阿川");
    
    [self.delegate headPosterView:self onClickBuyingButton:sender];
}

- (void)onClickSubButton:(UIButton *)button{
    NSLog(@"%ld", [self.headButtons indexOfObject:button]);
    
    [self.delegate headPosterView:self onClickSubButton:button atIndex:[self.headButtons indexOfObject:button]];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
