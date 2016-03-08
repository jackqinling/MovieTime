//
//  SectionHeaderView.h
//  ZQLHotMovieLine
//
//  Created by MacQin on 3/8/16.
//  Copyright © 2016 MS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SectionHeaderView;

@protocol SectionHeaderViewDelegate <NSObject>

- (void)didSelectHeaderView:(SectionHeaderView *)sectionHeader;

@end

@interface SectionHeaderView : UIView

@property (nonatomic, copy) NSString * title;

@property (nonatomic, weak) id<SectionHeaderViewDelegate>delegate;

@end
