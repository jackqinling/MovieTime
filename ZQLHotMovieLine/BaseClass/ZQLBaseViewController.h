//
//  ZQLBaseViewController.h
//  ZQLHotMovieLine
//
//  Created by MS on 16-1-10.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "ZQLUrl.h"
#import "UIColor+categoryColor.h"
#import "ZQLRequestManager.h"
#import "ZQLScreenMacro.h"
#import "UIView+ZQLTransitonAnimation.h"

@interface ZQLBaseViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>


@property (nonatomic, strong) ZQLRequestManager * manager;

@property (nonatomic, strong) UITableView * baseTableView;

@property (nonatomic, strong) NSMutableArray * baseDataSource;

@property (nonatomic, strong) UICollectionView * baseCollectionView;

@property (nonatomic, strong) UIView * naviBarHiddenView;

@property (nonatomic, strong) UIView * statusBar;

- (void)settingLeftNaviItemWithTitle:(NSString *)title;

- (void)onClickDiscover:(UIButton *)button;

- (void)changeNaviBarAlpha:(float)alhpa;

- (void)registerTableViewWithCellNibNameArray:(NSArray *)CellNibName withIdentfierArray:(NSArray *)IdentifierStr;

@end
