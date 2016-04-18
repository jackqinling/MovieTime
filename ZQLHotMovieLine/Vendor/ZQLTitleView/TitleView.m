//
//  TitleView.m
//  tableSource
//
//  Created by MS on 16-1-6.
//  Copyright (c) 2016年 赵秦岭. All rights reserved.
//

#import "TitleView.h"
#import "ZQLScreenMacro.h"
#import "UIColor+categoryColor.h"

#define BTN_STA_WID (ZScreenWidth / 5.0)
#define Space 20
#define FontSize 18
#define SelectedColor [UIColor barColor]

@interface TitleView ()

@property (nonatomic, strong) UIScrollView * scrollView;


//线


@end

@implementation TitleView
{
    NSUInteger preIndex;
}
- (UIView *)lineView{
    
    if (_lineView == nil) {
        _lineView = [[UIView alloc]initWithFrame:CGRectZero];
        _lineView.backgroundColor = [UIColor barColor];

        [self.scrollView addSubview:_lineView];
    }
    return _lineView;
}
/**
 *  设置titleview
 *
 *  @param titles view数组
 */

- (void)setTitles:(NSArray *)titles{
    
    _titles = titles;
    //更新视图显示的内容
    [self initView];
}
//初始化视图
- (void)initView{
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    
    //设置内容大小
    self.scrollView.contentSize = CGSizeMake([self totalWidth], self.frame.size.height);
    self.scrollView.bounces = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self selectIndex:0];//默认选中第0个
    
    
    [self addSubview:self.scrollView];
}

- (void)createButtonWithWidth:(CGFloat)width{
    
    for (int i = 0; i < _titles.count; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i * width, 0, width, self.frame.size.height);
        button.titleLabel.font = [UIFont systemFontOfSize:FontSize];
        [button setTitle:_titles[i] forState:UIControlStateNormal];
        [button setTitleColor:SelectedColor forState:UIControlStateSelected];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.buttons addObject:button];
        [self.scrollView addSubview:button];
    }

}
- (float)totalWidth{
    
    float width = 0;
    if (_titles.count <= 5 && _titles.count >=1) {
        
        width = ZScreenWidth / _titles.count;
        [self createButtonWithWidth:width];
        return ZScreenWidth;
        
    }else if (_titles.count > 5){
        for (NSString * title in _titles) {
            
            //通过字体计算长度和高度
            CGRect rect = [title boundingRectWithSize:CGSizeMake(320, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:FontSize]} context:nil];//计算文字的高度和宽度
            
            
            //button 的宽度  与   间隙
            float butonWidth = rect.size.width + Space;
            
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            button.frame = CGRectMake(width, 0, butonWidth, self.frame.size
                                      .height);
            button.titleLabel.font = [UIFont systemFontOfSize:FontSize];
            [button setTitle:title forState:UIControlStateNormal];
            [button setTitleColor:SelectedColor forState:UIControlStateSelected];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.buttons addObject:button];
            [self.scrollView addSubview:button];
            
            
            width += butonWidth;
            
        }
        return width;

    }else{
        return 0;
    }
}

- (NSMutableArray *)buttons{
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

//点击  button 告诉使用者  你点击了  第几个button
- (void)clickButton:(UIButton *)button{
    
    if (button.selected == YES) {
        return;
    }
    
    for (UIButton * b in self.buttons) {
        b.selected = NO;
    }
    
    button.selected = YES;
    
    //当title个数大于5时  开始滑动动画
    if (_titles.count > 5) {
        if (self.scrollView.contentSize.width - [self buttonCenterAtIndex:[self.buttons indexOfObject:button]] <= ZScreenWidth / 2 && [self buttonCenterAtIndex:[self.buttons indexOfObject:button]] >= ZScreenWidth / 2){
            [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentSize.width - ZScreenWidth, 0) animated:YES];
        }else if ([self buttonCenterAtIndex:[self.buttons indexOfObject:button]] <= ZScreenWidth / 2){
            
            [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }else {
            
            [self.scrollView setContentOffset:CGPointMake(button.frame.origin.x + button.frame.size.width / 2 - self.scrollView.frame.size.width /2, 0) animated:YES];
        }
    }
    
  
    [UIView animateWithDuration:0.3 animations:^{
        self.lineView.frame = CGRectMake(button.frame.origin.x, self.frame.size.height - 3, button.frame.size.width, 3);
    }];
    
    if ([self.delegate respondsToSelector:@selector(titleView:selectIndex:)] == YES) {
        [self.delegate titleView:self selectIndex:[self.buttons indexOfObject:button]];
    }
    
//    preIndex = [self.buttons indexOfObject:button];
//    NSLog(@"中心点%f", [self buttonCenterAtIndex:preIndex]);

}

//选中第几个
- (void)selectIndex:(NSInteger)index{
    
    
    UIButton * button = self.buttons[index];
    
    for (UIButton * b in self.buttons) {
        b.selected = NO;
    }
    
    button.selected = YES;
    if (index >= 2) {
        [self.scrollView setContentOffset:CGPointMake(button.frame.origin.x + button.frame.size.width / 2 - self.scrollView.frame.size.width /2, 0) animated:YES];
    }
    

    self.lineView.frame = CGRectMake(button.frame.origin.x, self.frame.size.height - 3, button.frame.size.width, 3);
}

- (void)setLineViewPositon:(CGFloat)x{
    
    self.lineView.frame = CGRectMake(x, self.frame.size.height - 3, ZScreenWidth / _titles.count, 3);
}
- (CGFloat)buttonCenterAtIndex:(NSUInteger)index{
    
    CGFloat width = 0;
    CGRect rect;
    for (int i = 0; i <= index; i++) {
         rect = [self.titles[i] boundingRectWithSize:CGSizeMake(320, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:FontSize]} context:nil];
        width += rect.size.width + Space;
    }
    
    return width - rect.size.width / 2.0 + Space / 2.0;
    
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
