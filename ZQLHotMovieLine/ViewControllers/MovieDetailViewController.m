//
//  MovieDetailViewController.m
//  ZQLHotMovieLine
//
//  Created by MS on 16-1-24.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "MovieHeaderView.h"
#import "MovieDetailModel.h"
#import "ZQLDefinedImageView.h"
#import "ActorCell.h"
#import "MovieAwardCell.h"
#import "ImagesCell.h"
#import "MovieGoodModel.h"
#import "MovieGoodsCell.h"
#import "LongCommentCell.h"
#import "ShortCommentCell.h"
#import "LongCommentModel.h"
#import "ShortCommentModel.h"
//对应长评论
#import "CommentDetailModel.h"
#import "ShortCommentModel.h"
#import "PreviewVideoViewController.h"

#define HeaderViewHeight (80 + 80 / 55.0f * ZScreenWidth * 105 / 320.0f + 92)

typedef enum {
    Goods = 0,
    BoxOffice,
    Actor,
    Images,
    LongComment,
    ShortComment,
}Section;

static NSString * actorCellID = @"actorCell";
static NSString * awardCellID = @"officeCell";
static NSString * imageCellID = @"imgageCell";
static NSString * goodsCellID = @"goodsCell";
static NSString * longCommentCellID = @"lComCell";
static NSString * shortCommentCellID = @"sComCell";

@interface MovieDetailViewController ()<UIScrollViewDelegate, MovieHeaderViewDelegate>

@end

@implementation MovieDetailViewController
{
    NSMutableArray * _itemsStoreArray;
    UIView * _tableHeaderView;
    BOOL _isCollapsed;
    CGRect _rect;
    MovieHeaderView * _header;
    MovieDetailModel * _movieModel;
    MovieGoodModel * _goodModel;
    //长评论
    LongCommentModel * _longCommentModel;
    CommentDetailModel * _longCommentDetailModel;
    //短评论
    ShortCommentModel * _shortCommentModel;
    SCommentModel * _shortCommentDetailModel;
    
    int _page[2];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self settingNaviBarItem];
    [self settingTableView];
    [self loadData];
    [self loadDataWithRefresh:NO];
  }

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view bringSubviewToFront:self.statusBar];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}
- (void)onClickImage:(ZQLDefinedImageView *)imageView{
    NSLog(@"image");
}

//根据str算行高
- (void)settingTableHeaderViewWithString:(NSString *)str{
    
    _rect = [str boundingRectWithSize:CGSizeMake(ZScreenWidth - 30, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, _rect.size.width, _rect.size.height)];
    label.numberOfLines = 0;
    label.text = str;
    label.font = [UIFont systemFontOfSize:13];
//    label.backgroundColor = [UIColor blueColor];
    _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ZScreenWidth, 50 + _rect.size.height)];
    _tableHeaderView.backgroundColor = [UIColor whiteColor];
    [_tableHeaderView addSubview:label];
    
    UIImage * image = [UIImage imageNamed:@"v10_topListSummaryDown"];
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, _rect.size.height + 15, ZScreenWidth, 35)];
    button.backgroundColor = [UIColor whiteColor];
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(collapse:) forControlEvents:UIControlEventTouchUpInside];
    //展开
    _isCollapsed = YES;
    
    [_tableHeaderView addSubview:button];
    _tableHeaderView.clipsToBounds = YES;
    self.baseTableView.tableHeaderView = _tableHeaderView;
    
}

- (void)collapse:(UIButton *)button{
    NSLog(@"collapse");
    if (_isCollapsed) {
        [_tableHeaderView setFrame:CGRectMake(0, 0, ZScreenWidth, 80)];
        [button setFrame:CGRectMake(0, 45, ZScreenWidth, 35)];
        
        //必须重设,否则留白
        self.baseTableView.tableHeaderView = _tableHeaderView;
        _isCollapsed = NO;
    }else{
        [_tableHeaderView setFrame:CGRectMake(0, 0, ZScreenWidth, 50 + _rect.size.height)];
        [button setFrame:CGRectMake(0, _rect.size.height + 15, ZScreenWidth, 35)];
        self.baseTableView.tableHeaderView = _tableHeaderView;

        _isCollapsed = YES;
    }
}
- (void)settingTableView{
    
    self.baseTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 80, ZScreenWidth, ZScreenHeight - 80) style:UITableViewStyleGrouped];
    
    self.baseTableView.delegate = self;
    self.baseTableView.dataSource = self;
    self.baseTableView.backgroundColor = [UIColor randomColor];
    self.baseTableView.bounces = NO;
    self.baseTableView.tableFooterView = [[UIView alloc] init];
    self.baseTableView.contentInset = UIEdgeInsetsMake(HeaderViewHeight + StatusBarHeight - 60, 0, 0, 0);
    
    self.baseTableView.contentOffset = CGPointMake(0, -(HeaderViewHeight + StatusBarHeight - 60));
    self.baseTableView.showsVerticalScrollIndicator = NO;
    self.baseTableView.showsHorizontalScrollIndicator = NO;
    
    //注册cell
    NSArray * nibName = @[@"ActorCell", @"MovieAwardCell", @"ImagesCell", @"MovieGoodsCell", @"LongCommentCell", @"ShortCommentCell"];
    NSArray * idArray = @[actorCellID, awardCellID, imageCellID, goodsCellID, longCommentCellID, shortCommentCellID];
    [self registerTableViewWithCellNibNameArray:nibName withIdentfierArray:idArray];
    
    [self.view addSubview:self.baseTableView];
}

- (void)settingNaviBarItem{
    
    NSMutableArray * itemsArray = [NSMutableArray array];
    NSArray * imageName = @[@"v10_photoNewsLeft", @"icon_sharing", @"st_icon_bookmark1"];
    for (NSString * name in imageName) {
        UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:name] style:UIBarButtonItemStylePlain target:self action:@selector(onBarItemClick:)];
        [itemsArray addObject:item];
    }
    
    _itemsStoreArray = itemsArray;
    
    self.navigationItem.leftBarButtonItem = itemsArray[0];
    self.navigationItem.rightBarButtonItems = @[itemsArray[1], itemsArray[2]];
}

- (void)onBarItemClick:(UIBarButtonItem *)item{
    if (item == _itemsStoreArray[0]) {
        NSLog(@"返回");
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
- (void)loadData{
    
    [self.manager requestWithGetMethod:MovieDetailUrl parameters:@{@"locationId":@"290", @"movieId":self.model.movieId} complicate:^(BOOL success, id object) {
        MovieDetailModel * model = object[0][0];
        
        [self settingHeadViewWithModel:model];
        [self settingTableHeaderViewWithString:model.content];
        _movieModel = model;
        [self.baseTableView reloadData];
        
    } modelClassNameArray:@[@"MovieDetailModel"]];

}

- (void)loadDataWithRefresh:(BOOL)refresh{
    if (refresh) {
        _page[0] = 0;
        [self.baseDataSource removeAllObjects];
    }else{
        _page[0]++;
    }
    [self.manager requestWithGetMethod:ShortCommentUrl parameters:@{@"movieId":self.model.movieId,@"pageIndex":@(_page[0])} complicate:^(BOOL success, id object) {
        if (success) {
            _shortCommentModel = object[0][0];
            for (SCommentModel * model in _shortCommentModel.cts) {
                [self.baseDataSource addObject:model];
            }
            
            [self.baseTableView reloadData];
        }
    } modelClassNameArray:@[@"ShortCommentModel"]];
}

//开头的视图
- (void)settingHeadViewWithModel:(MovieDetailModel *)model{
    
    _header = [MovieHeaderView viewWithModel:model frame:CGRectMake(0, StatusBarHeight, ZScreenWidth, HeaderViewHeight)];
    
    _header.delegate = self;
    [self.view addSubview:_header];
    [self.view bringSubviewToFront:self.statusBar];
    [self.view  bringSubviewToFront:self.naviBarHiddenView];


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark tableView代理方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == Actor) {
        return ZScreenWidth * 0.84;
    }else if (indexPath.section == BoxOffice){
        if ([_movieModel.weekBoxOffice isEqualToString:@""] && _movieModel.awards.count == 0) {
            return 0;
        }
        return 115;
        
    }else if(indexPath.section == Images){
        return ((ZScreenWidth - 54) / 4.0f + 46 + 15);
        
    }else if (indexPath.section == Goods && _goodModel.goodsList.count != 0){
        return 240;
        
    }else if (indexPath.section == LongComment){
        CGRect rect = [_longCommentDetailModel.content boundingRectWithSize:CGSizeMake(ZScreenWidth - 30, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
        if (rect.size.height > 43) {
            return 180;
        }else{
            return 140 + rect.size.height;
        }
        
    }else if (indexPath.section == ShortComment && self.baseDataSource.count != 0){
        SCommentModel * model = self.baseDataSource[indexPath.row];
        CGRect rect = [model.ce boundingRectWithSize:CGSizeMake(ZScreenWidth - 77, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
        //包含图片和不包含图片的评论
        if ([model.ceimg isEqualToString:@""]) {
            if (rect.size.height > 70) {
                return 180;
            }else{
                return (110 + rect.size.height);
            }
        }else{
            if (rect.size.height > 70) {
                return 240;
            }else{
                return (170 + rect.size.height);
            }
        }
        
    }
        return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == ShortComment) {
        return self.baseDataSource.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == Actor) {
        ActorCell * cell = [tableView dequeueReusableCellWithIdentifier:actorCellID forIndexPath:indexPath];
        cell.model = _movieModel;
        return cell;
    }
    if (indexPath.section == BoxOffice) {
        MovieAwardCell * cell = [tableView dequeueReusableCellWithIdentifier:awardCellID forIndexPath:indexPath];
        cell.model = _movieModel;
        if ([_movieModel.weekBoxOffice isEqualToString:@""] && _movieModel.awards.count == 0) {
            cell.hidden = YES;
        }
        return cell;
    }
    if (indexPath.section == Images) {
        ImagesCell * cell = [tableView dequeueReusableCellWithIdentifier:imageCellID forIndexPath:indexPath];
        cell.model = _movieModel;
        return cell;
    }
    if (indexPath.section == Goods) {
        MovieGoodsCell * cell = [tableView dequeueReusableCellWithIdentifier:goodsCellID forIndexPath:indexPath];
        if (_goodModel == nil) {
            [self.manager requestWithGetMethod:RelatedGoodsUrl parameters:@{@"relatedId":self.model.movieId} complicate:^(BOOL success, id object) {
                if (success) {
                    _goodModel = object[0][0];
                    cell.model = _goodModel;
                    //在block里写不生效
//                    if (_goodModel.goodsList.count == 0) {
//                        cell.hidden = YES;
//                        return;
//                    }
                    
                    [self.baseTableView reloadData];
                }
            } modelClassNameArray:@[@"MovieGoodModel"]];
        }
        //在block外写生效
        if (_goodModel.goodsList.count == 0) {
            cell.hidden = YES;
        }
        return cell;
    }
    if (indexPath.section == LongComment) {
        LongCommentCell * cell = [tableView dequeueReusableCellWithIdentifier:longCommentCellID forIndexPath:indexPath];
        if (_longCommentModel.comments.count == 0) {
            [self.manager requestWithGetMethod:LongCommentUrl parameters:@{@"movieId":_model.movieId, @"pageId":@"1"} complicate:^(BOOL success, id object) {
                if (success) {
                    _longCommentModel = object[0][0];
                    cell.model = _longCommentModel;
                    _longCommentDetailModel = _longCommentModel.comments[0];
                    [self.baseTableView reloadData];
                }
            } modelClassNameArray:@[@"LongCommentModel"]];
        }
        return cell;
    }
    if (indexPath.section == ShortComment) {
        ShortCommentCell * cell = [tableView dequeueReusableCellWithIdentifier:shortCommentCellID forIndexPath:indexPath];
            cell.totalCommentLabel.text = [NSString stringWithFormat:@"网友短评(%@)", _shortCommentModel.totalCount];
            SCommentModel * model = self.baseDataSource[indexPath.row];
            
            cell.model = model;
  
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == BoxOffice && ([_movieModel.weekBoxOffice isEqualToString:@""] && _movieModel.awards.count == 0)) {
            return 0.1;
    }
    if (section == Goods && _goodModel.goodsList.count == 0) {
        return 0.1;
    }
    return 20;

}

#pragma mark - scrollView代理方法

//在此代理里尽量把所有情况都写明不然会有延迟反应,导致界面失调
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //头视图随着tableview滚动联动
    if (scrollView.contentOffset.y >= -68) {
        [_header setFrame:CGRectMake(0, 128 - HeaderViewHeight, ZScreenWidth, HeaderViewHeight)];
    }else if (scrollView.contentOffset.y < -68){
        [_header setFrame:CGRectMake(0, (StatusBarHeight - (scrollView.contentOffset.y - (-(HeaderViewHeight + StatusBarHeight - 60)))), self.view.bounds.size.width, HeaderViewHeight)];
    }
    if (scrollView.contentOffset.y > -240) {
        self.naviBarHiddenView.alpha = (240 + scrollView.contentOffset.y) / 172.0f;
    }else{
        self.naviBarHiddenView.alpha = 0;
    }
    
}

#pragma mark - headerViewDelegate

- (void)didClickHeaderViewPlayButtonWithModel:(MovieDetailModel *)model{
    
    PreviewVideoViewController * pvc = [[PreviewVideoViewController alloc] init];
    pvc.movieID = self.model.movieId;
    pvc.title = @"预告片&拍摄花絮";
    [self.navigationController pushViewController:pvc animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
