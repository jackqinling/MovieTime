//
//  HomeViewController.m
//  ZQLHotMovieLine
//
//  Created by MS on 16-1-12.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import "HomeViewController.h"
#import "ZQLBaseModel.h"
#import "HeadPosterView.h"
#import "GoodsCell.h"
#import "HomeAdScrollCell.h"
#import "MovieDetailOneCell.h"
#import "MovieDetailThreeCell.h"
#import "hotPointModel.h"
#import "PerfectMovieCell.h"
#import "MovieDetailViewController.h"
#import "CitiesChoiceViewController.h"
#import "HotMovieModel.h"
#import "SectionHeaderView.h"

#define HeaderHeight 200

typedef enum {
    Market = 0,
    Adver,
    HotPoint,
    PerfectMovie,
}HomeSection;


static NSString * const goodsCellID = @"goodsCell";

static NSString * const adCellID = @"adCell";

static NSString * const oneMovieCellID = @"oneCell";

static NSString * const threeMovieCellID = @"threeCell";

static NSString * const perfectMovieCellID = @"perfectCell";

static NSString * const sectionViewID = @"sectionHeaderView";


@interface HomeViewController ()<UITableViewDataSource, UITabBarDelegate, HeadPosterViewDelegate>

@property (nonatomic, strong) HeadPosterView * headView;


@end

@implementation HomeViewController
{
    UIButton * cityButton;
    CGSize imageSize;
    HotMovieModel * _hotMovieModel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self changeNaviBarAlpha:0];
    [self settingNaviBarItem];
    [self settingTableView];
    [self loadMainPageData];
    [self loadHeadPosterDataWithCity:@"290"];
    [self settingLeftNaviItemWithTitle:@"北京"];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)settingTableView{
    
    self.baseTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, ZScreenWidth, ZScreenHeight - 69) style:UITableViewStyleGrouped];
    
    //注册 cell
    NSArray * nibNameArray = @[@"GoodsCell", @"HomeAdScrollCell", @"MovieDetailOneCell", @"MovieDetailThreeCell", @"PerfectMovieCell"];
    NSArray * identifArray = @[goodsCellID, adCellID, oneMovieCellID, threeMovieCellID, perfectMovieCellID];
    [self registerTableViewWithCellNibNameArray:nibNameArray withIdentfierArray:identifArray];
    
    [self.baseTableView registerClass:[SectionHeaderView class] forHeaderFooterViewReuseIdentifier:sectionViewID];
//    [self.baseTableView registerNib:[UINib nibWithNibName:NSStringFromClass([SectionHeaderView class]) bundle:nil] forHeaderFooterViewReuseIdentifier:sectionViewID];
    
    self.baseTableView.bounces = NO;
    self.baseTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.baseTableView.showsHorizontalScrollIndicator = NO;
    self.baseTableView.showsVerticalScrollIndicator = NO;
    self.baseTableView.rowHeight = UITableViewAutomaticDimension;
    self.baseTableView.estimatedRowHeight = 44;

    //confirm delegate
    self.baseTableView.delegate = self;
    self.baseTableView.dataSource = self;
    
    self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.baseTableView];
    
    //影藏透明
    self.naviBarHiddenView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, ZScreenWidth, 44)];
    self.naviBarHiddenView.backgroundColor = [UIColor naviBarColor];
    [self.view addSubview:self.naviBarHiddenView];
    self.naviBarHiddenView.hidden = YES;
}

- (UIView *)settingTableViewFooterView{
    
    NSArray * titles = @[@"新闻", @"预告片", @"排行榜", @"影评"];
    int i = 0;
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ZScreenWidth, 50)];

    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    for (NSString * title in titles) {
        
        
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(i * ZScreenWidth / 4.0f, 0, ZScreenWidth / 4.0f, 50)];
        [button setTitle:title forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont screenFontOfSize:15];
        button.backgroundColor = [UIColor whiteColor];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        CGRect rect = [title boundingRectWithSize:CGSizeMake(ZScreenWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont screenFontOfSize:15]} context:nil];
        UIImage * image = [UIImage imageNamed:@"icon_right_arrow"];
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(ZScreenWidth / 8.0f + rect.size.width / 2.0 + 3, 25 - image.size.height / 2.0f, image.size.width, image.size.height)];
        imageView.image = image;
        [button addSubview:imageView];
        [button addTarget:self action:@selector(onClickFootButton:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [view addSubview:button];
        
        i++;
    }
    
    return view;
}

//最下面的4button
- (void)onClickFootButton:(UIButton *)button{
    
}

- (void)settingNaviBarItem{
    
    NSMutableArray * items = [NSMutableArray array];
    NSArray * imageNames = @[@"icon_magnifier", @"icon_scan_barcode_white"];
    for (NSString * name in imageNames) {
        UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:name] style:UIBarButtonItemStylePlain target:self action:@selector(onClickItem:)];
        [items addObject:item];
    }
    self.navigationItem.rightBarButtonItems = items;
    UIImage * titleImage = [UIImage imageNamed:@"ele_logo_mtime"];
    
    UIImageView * titlView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, titleImage.size.width, titleImage.size.height)];
    titlView.image = titleImage;
    self.navigationItem.titleView = titlView;
    


}

#pragma mark NaviItem点击方法
- (void)onClickItem:(UIBarButtonItem *)button{
    NSLog(@"right");
}
- (void)onClickDiscover:(UIButton *)button{
    NSLog(@"find");
    
    CitiesChoiceViewController * cvc = [[CitiesChoiceViewController alloc] init];
    cvc.cityBlcok = ^(CityModel * city){
        [self loadHeadPosterDataWithCity:city.cID];
        [self settingLeftNaviItemWithTitle:city.n];
    };
    [self.tabBarController.view setTransitionAnimation:ZQLTransitionAnimationTypeCameraIris toward:ZQLTransitionAnimationTowardTypesFromBottom duration:1];
    [self.navigationController pushViewController:cvc animated:NO];
}

#pragma mark 数据请求
//request Data
- (void)loadMainPageData{
    [self.manager requestWithPostMethod:FirstPageUrl parameters:nil complicate:^(BOOL success, id object) {
        if (success) {
            //analysize data
            [self.baseDataSource addObject:object[3]];
            [self.baseDataSource addObject:object[1]];
            [self.baseDataSource addObject:object[0]];
            [self.baseDataSource addObject:object[2]];
            [self.baseTableView reloadData];
        }else{
            //failed
        }
    } modelClassNameArray:@[@"hotPointModel", @"adverModel", @"HotMovieModel", @"AreaSecondModel", @"TopPosterModel"]];
}

//request headPosterView data  tableHeaderView
-(void)loadHeadPosterDataWithCity:(NSString *)city{
    [self.manager requestWithGetMethod:HeadUrl parameters:@{@"locationId":city} complicate:^(BOOL success, id object) {
        if (success) {
            MovieInfoModel * model = [[object firstObject] firstObject];
            if (model.movies.count == 0) {
                return;
            }
            if (self.headView == nil) {
                [self creatingHeaderScrollViewWithModel:model];
            }else{
                self.headView.model = model;
            }
            
        }else{
            NSLog(@"%@", object);
        }
    } modelClassNameArray:@[@"MovieInfoModel"]];
}

- (void)creatingHeaderScrollViewWithModel:(MovieInfoModel *)model{
    
    HeadPosterView * view = [HeadPosterView viewWithModel:model frame:CGRectMake(0, StatusBarHeight, ZScreenWidth, ZScreenWidth * 1.2f)];
    view.delegate = self;
    
    self.baseTableView.tableHeaderView = view;

}

#pragma mark tableView代理


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.baseDataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (section) {
            
        case Market:
        case Adver:
        case PerfectMovie:
            return 1;
            break;
            
        case HotPoint:{
            if (self.baseDataSource.count > 0) {
                NSArray * array = self.baseDataSource[HotPoint] ;
                return array.count;
                
            }else{
                return 0;
            }
        }
            break;
        default:
            return 1;
            break;
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    NSArray * titles = @[@"电影商城", @"", @"今日热点", @"每日佳片"];
    NSArray * buttonTitles = @[@"全部商品", @"", @"更多", @"更多推荐"];
    if (section == Adver) {
        return nil;
    }
    
    SectionHeaderView * sectionView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:sectionViewID];
    
    sectionView.title = titles[section];
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ZScreenWidth, 30)];
    backView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 10, ZScreenWidth, 30)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
    label.text = titles[section];
    label.font = [UIFont screenFontOfSize:15];
    label.textColor = [UIColor blackColor];
    CGRect rect = [buttonTitles[section] boundingRectWithSize:CGSizeMake(ZScreenWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont screenFontOfSize:13]} context:nil];
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(ZScreenWidth - rect.size.width - 23, 10, rect.size.width, 20)];
    [button setTitle:buttonTitles[section] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onClickMore:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont screenFontOfSize:13];
    UIImage * image = [UIImage imageNamed:@"arrowRight"];
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(ZScreenWidth - 20, 13, image.size.width, image.size.height)];
    imageView.userInteractionEnabled = YES;
    imageView.image = image;
    
    
    [view addSubview:label];
    [view addSubview:button];
    [view addSubview:imageView];
    
    [backView addSubview:view];
    return backView;
  
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (section == HotPoint) {
        return [self settingTableViewFooterView];
    }
    
    return nil;
}
- (void)onClickMore:(UIButton *)button{
    NSLog(@"点击更多");
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.baseDataSource.count > 0) {
        switch (indexPath.section) {
                
            case Market:
            {
                GoodsCell * goodsCell = [tableView dequeueReusableCellWithIdentifier:goodsCellID forIndexPath:indexPath];
                
                goodsCell.models = self.baseDataSource[0];
                return goodsCell;
            }
                break;
            case Adver:
            {
                HomeAdScrollCell * adCell = [tableView dequeueReusableCellWithIdentifier:adCellID forIndexPath:indexPath];
                adCell.adverModelsArray = self.baseDataSource[1];
                return adCell;

            }
                break;
                
            case HotPoint:
            {
                hotPointModel * model = self.baseDataSource[indexPath.section][indexPath.row];
                
                if (model.images.count > 0) {
                    MovieDetailThreeCell * cell = [tableView dequeueReusableCellWithIdentifier:threeMovieCellID forIndexPath:indexPath];
                    cell.model = self.baseDataSource[HotPoint][indexPath.row];
                    return cell;
                }else{
                    MovieDetailOneCell * cell = [tableView dequeueReusableCellWithIdentifier:oneMovieCellID forIndexPath:indexPath];
                    cell.model = self.baseDataSource[HotPoint][indexPath.row];
                    cell.widthRatioConstraint.constant = 0.25 * cell.frame.size.height;
                    return cell;
                }
            }
                break;
                
            case PerfectMovie:{
                PerfectMovieCell * cell = [tableView dequeueReusableCellWithIdentifier:perfectMovieCellID forIndexPath:indexPath];
                //容错
                _hotMovieModel = self.baseDataSource[PerfectMovie][indexPath.row];
                
                if (!_hotMovieModel.movie) {
                    return cell;
                }

                
                cell.model = _hotMovieModel;
                
                return cell;
            }
                break;
                
            default:
                return nil;
                break;
        }
    }

    return nil;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case Market:
            return ZScreenWidth * 1.10;
            break;
        case Adver:
            return ZScreenWidth / 4.0f;
            break;
        case HotPoint:{
            if (self.baseDataSource.count > 0) {
                if ([[self.baseDataSource[HotPoint][indexPath.row] images] count] > 0) {
                    return 160;
                }
            }
          
            return 100;

        }
            break;
        case PerfectMovie:{
            if (!_hotMovieModel.movie) {
                return 0;
            }
            return 260;
            break;
        }
        default:
            return 0;
            break;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    switch (section) {
            
        case Adver:
            return 10;
        case PerfectMovie:{
            if (!_hotMovieModel.movie) {
                return 10;
            }
        }
        default:
            return 40;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    switch (section) {
        case Adver:
            return 0.1;
            break;
        case HotPoint:
            return 50;
        default:
            return 0.1;
            break;
    }
}
#pragma mark headerPosterView 代理方法
- (void)headPosterView:(HeadPosterView *)headPosterView onClickBuyingButton:(UIButton *)buyingButton{
    NSLog(@"你好");
}

- (void)headPosterView:(HeadPosterView *)headPosterView didSelectImageView:(ZQLDefinedImageView *)zqlDefinedImageView withModel:(id)model{
    
    MovieDetailViewController * dvc = [[MovieDetailViewController alloc] init];
    dvc.model = model;
    [self.navigationController pushViewController:dvc animated:YES];
    //这么操蛋的一句话
    dvc.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)headPosterView:(HeadPosterView *)headPosterView onClickSubButton:(UIButton *)subButton atIndex:(NSUInteger)index{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark scrollView 代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    static float alpha;
    alpha = scrollView.contentOffset.y / 200.0f;

    if (scrollView.contentOffset.y >= 150 && scrollView.contentOffset.y <= 200) {
        self.naviBarHiddenView.hidden = NO;
        self.naviBarHiddenView.alpha = alpha;
    }else if (scrollView.contentOffset.y > 200){
        self.naviBarHiddenView.alpha = 1;
    }
    else{
        self.naviBarHiddenView.hidden = YES;
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
