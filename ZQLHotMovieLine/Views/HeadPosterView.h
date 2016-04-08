//
//  HeadPosterView.h
//  ZQLHotMovieLine
//
//  Created by MS on 16-1-15.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieModel.h"
#import "MovieInfoModel.h"
#import "ZQLDefinedImageView.h"

@class HeadPosterView;


@protocol HeadPosterViewDelegate <NSObject>

/**
 *  点击头部滚动图片代理方法
 *
 *  @param headPosterView      头部视图
 *  @param zqlDefinedImageView 图片视图
 *  @param model               图片视图对应模型
 */
- (void)headPosterView:(HeadPosterView *)headPosterView didSelectImageView:(ZQLDefinedImageView *)zqlDefinedImageView withModel:(MovieModel *)model;
/**
 *  点击购买按钮代理方法
 *
 *  @param headPosterView 头部视图
 *  @param buyingButton   购买按钮
 */
- (void)headPosterView:(HeadPosterView *)headPosterView onClickBuyingButton:(UIButton *)buyingButton;

- (void)headPosterView:(HeadPosterView *)headPosterView onClickSubButton:(UIButton *)subButton atIndex:(NSUInteger)index;


@end

@interface HeadPosterView : UICollectionReusableView

@property (nonatomic, weak) IBOutlet id<HeadPosterViewDelegate>delegate;

//@property (nonatomic, weak) id<HeadPosterViewDelegate>delegate;

@property (nonatomic, strong) MovieInfoModel * model;

@property (nonatomic, strong) NSArray * movies;


+ (instancetype)viewWithModel:(MovieInfoModel *)model frame:(CGRect)frame;

@end
