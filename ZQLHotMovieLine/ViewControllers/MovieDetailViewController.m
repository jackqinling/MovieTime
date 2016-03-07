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

typedef enum {
    RelatedGoods = 0,
    BoxOffice,
    Actors,
    Images,
}Sectinon;

static NSString * actorCellID = @"actorCell";
static NSString * awardCellID = @"officeCell";
static NSString * imageCellID = @"imgageCell";
static NSString * goodsCellID = @"goodsCell";

@interface MovieDetailViewController ()<UIScrollViewDelegate>

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
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self settingNaviBarItem];
    [self settingTableView];
    [self loadData];

  }

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view bringSubviewToFront:self.statusBar];
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
    
    self.baseTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 80, ZScreenWidth, ZScreenHeight - 80 - NaviBarHeight) style:UITableViewStyleGrouped];
    
    self.baseTableView.delegate = self;
    self.baseTableView.dataSource = self;
    self.baseTableView.backgroundColor = [UIColor randomColor];
    self.baseTableView.bounces = NO;
    self.baseTableView.tableFooterView = [[UIView alloc] init];
    self.baseTableView.contentInset = UIEdgeInsetsMake(320 + StatusBarHeight - 60, 0, 0, 0);
    
    self.baseTableView.contentOffset = CGPointMake(0, -(320 + StatusBarHeight - 60));
    self.baseTableView.showsVerticalScrollIndicator = NO;
    self.baseTableView.showsHorizontalScrollIndicator = NO;
    //注册cell
    [self.baseTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ActorCell class]) bundle:nil] forCellReuseIdentifier:actorCellID];
    [self.baseTableView registerNib:[UINib nibWithNibName:NSStringFromClass([MovieAwardCell class]) bundle:nil] forCellReuseIdentifier:awardCellID];
    [self.baseTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ImagesCell class]) bundle:nil] forCellReuseIdentifier:imageCellID];
    [self.baseTableView registerNib:[UINib nibWithNibName:NSStringFromClass([MovieGoodsCell class]) bundle:nil] forCellReuseIdentifier:goodsCellID];
    
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

//开头的视图
- (void)settingHeadViewWithModel:(MovieDetailModel *)model{
    
    _header = [MovieHeaderView viewWithModel:model frame:CGRectMake(0, StatusBarHeight, ZScreenWidth, 320)];
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
    
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        return 320;
    }else if (indexPath.section == 0){
        if ([_movieModel.weekBoxOffice isEqualToString:@""]) {
            return 0;
        }
        return 115;
    }else if(indexPath.section == 2){
        return ((ZScreenWidth - 54) / 4.0f + 46 + 15);
    }else if (indexPath.section == 3 && _goodModel.goodsList.count != 0){
        return 240;
    }
        return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        ActorCell * cell = [tableView dequeueReusableCellWithIdentifier:actorCellID forIndexPath:indexPath];
        cell.model = _movieModel;
        return cell;
    }
    if (indexPath.section == 0) {
        MovieAwardCell * cell = [tableView dequeueReusableCellWithIdentifier:awardCellID forIndexPath:indexPath];
        cell.model = _movieModel;
        if ([_movieModel.weekBoxOffice isEqualToString:@""]) {
            cell.hidden = YES;
        }
        return cell;
    }
    if (indexPath.section == 2) {
        ImagesCell * cell = [tableView dequeueReusableCellWithIdentifier:imageCellID forIndexPath:indexPath];
        cell.model = _movieModel;
        return cell;
    }
    if (indexPath.section == 3) {
        MovieGoodsCell * cell = [tableView dequeueReusableCellWithIdentifier:goodsCellID forIndexPath:indexPath];
        if (_goodModel == nil) {
            [self.manager requestWithGetMethod:RelatedGoodsUrl parameters:@{@"relatedId":self.model.movieId} complicate:^(BOOL success, id object) {
                if (success) {
                    _goodModel = object[0][0];
                    cell.model = _goodModel;
                    if (_goodModel.goodsList.count == 0) {
                        cell.hidden = YES;
                    }
                    [self.baseTableView reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationLeft];
                }
            } modelClassNameArray:@[@"MovieGoodModel"]];
        }
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0 && [_movieModel.weekBoxOffice isEqualToString:@""]) {
            return 0.1;
    }
    if (section == 3 && _goodModel.goodsList.count == 0) {
        return 0.1;
    }
    return 20;

}

#pragma mark - scrollView代理方法

//在此代理里尽量把所有情况都写明不然会有延迟反应,导致界面失调
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //头视图随着tableview滚动联动
    if (scrollView.contentOffset.y >= -68) {
        [_header setFrame:CGRectMake(0, -191, ZScreenWidth, 320)];
    }else if (scrollView.contentOffset.y < -68){
        [_header setFrame:CGRectMake(0, (StatusBarHeight - (scrollView.contentOffset.y - (-(320 + StatusBarHeight - 60)))), self.view.bounds.size.width, 320)];
    }
    if (scrollView.contentOffset.y > -240) {
        self.naviBarHiddenView.alpha = (240 + scrollView.contentOffset.y) / 172.0f;
    }else{
        self.naviBarHiddenView.alpha = 0;
    }
    
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
