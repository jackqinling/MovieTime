//
//  TitleView.h
//  tableSource
//
//  Created by MS on 16-1-6.
//  Copyright (c) 2016年 赵秦岭. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TitleView;

@protocol TitleViewDelegate <NSObject>

/**
 *  代理方法
 *
 *  @param view  当titleView点击了  对应的button之后会被调用
 *  @param index 选中的位置
 */
- (void)titleView:(TitleView *)view selectIndex:(NSInteger)index;

@end
@interface TitleView : UIView

@property (nonatomic, strong) NSArray * titles;

@property (nonatomic, weak) id<TitleViewDelegate>delegate;

@property (nonatomic, strong) NSMutableArray * buttons;

/**
 *  设置选中第几个button
 *
 *  @param index 选中的位置
 */
//- (void)selectIndex:(NSInteger)index;

//点击了第几个按钮
- (void)clickButton:(UIButton *)button;

@end
