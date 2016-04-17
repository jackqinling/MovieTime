//
//  CitiesChoiceViewController.m
//  ZQLHotMovieLine
//
//  Created by zhaoqinling on 16/1/28.
//  Copyright © 2016年 MS. All rights reserved.
//

#import "CitiesChoiceViewController.h"
#import "CityModel.h"
#import "CityCellCollectionViewCell.h"
#import "CitySectionHeaderView.h"

static NSString * cityCellID = @"cityCell";

static NSString * headerID = @"headerView";

static NSString * tableCellID = @"tableCell";

@interface CitiesChoiceViewController ()<UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (nonatomic, strong) NSMutableArray * dataSource;

@property (nonatomic, strong) NSMutableArray * storeDataSource;

@end

@implementation CitiesChoiceViewController
{
    UILabel * noReultLabel;
}
- (NSMutableArray *)dataSource{
    
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

//- (NSMutableArray *)storeDataSource{
//    if (_storeDataSource == nil) {
//        _storeDataSource = [NSMutableArray array];
//    }
//    return _storeDataSource;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    [self settingNaviBarWithTitle:@"选择城市"];
    //collection 在下面
    [self settingCollectionView];
    //tableView在上面
    [self settingTableView];
    [self customSearchBar];
    [self loadCities];
}

- (void)settingTableView{
    
    self.baseTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NaviBarHeight + StatusBarHeight + 44, ZScreenWidth, ZScreenHeight - StatusBarHeight - NaviBarHeight - 44 - 44) style:UITableViewStylePlain];
    self.baseTableView.bounces = NO;
    [self.baseTableView setHidden:YES];
    self.baseTableView.delegate = self;
    self.baseTableView.dataSource = self;
    
    //注册
    [self.baseTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:tableCellID];
    
    [self.view addSubview:self.baseTableView];
    self.baseTableView.tableFooterView = [[UIView alloc] init];
    
    noReultLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ZScreenWidth, 40)];
    noReultLabel.textColor = [UIColor lightGrayColor];
    noReultLabel.textAlignment = NSTextAlignmentCenter;
    noReultLabel.font = [UIFont systemFontOfSize:16];
    noReultLabel.text = @"没有搜索结果";
}
- (void)settingCollectionView{
    
    UICollectionViewFlowLayout * flowLayOut = [[UICollectionViewFlowLayout alloc] init];
    flowLayOut.itemSize = CGSizeMake(ZScreenWidth / 4, 50);
    flowLayOut.minimumInteritemSpacing = 0;
    flowLayOut.minimumLineSpacing = 0;
    
    self.baseCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NaviBarHeight + 44 + StatusBarHeight, ZScreenWidth, ZScreenHeight - StatusBarHeight - NaviBarHeight - 44 - 44) collectionViewLayout:flowLayOut];
    self.baseCollectionView.bounces = NO;
    
    self.baseCollectionView.delegate = self;
    self.baseCollectionView.dataSource = self;
    
    //注册
    [self.baseCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CityCellCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:cityCellID];
    [self.baseCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CitySectionHeaderView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID];
    
    self.baseCollectionView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.baseCollectionView];
}


- (void)loadCities{
    [self.manager requestWithGetMethod:CityUrl parameters:nil complicate:^(BOOL success, id object) {
        if (success) {
            
            [self analysisObject:object];
            
        }else{
            NSLog(@"城市接口返回错误:%@", object);
        }
        
    } modelClassNameArray:@[@"CityModel"]];
}

- (void)analysisObject:(NSArray *)object{
    
    NSMutableArray * rankArray = [NSMutableArray array];
    [rankArray addObject:@"当前城市"];
    
    NSString * str = @"A B C D E F G H I J K L M N O P Q R S T U V W X Y Z";
    NSArray * characters = [str componentsSeparatedByString:@" "];
    
    //取出数组
    NSArray * models = object[0];
    
    for (int i = 0; i < 12; i++) {
        [rankArray addObject:models[i]];
    }
    //热门城市
    [self.baseDataSource addObject:rankArray];
    
    //全部城市 按拼音 分组
    for (NSString * ch in characters) {
        NSMutableArray * sub = [NSMutableArray array];
        //数组第一个元素是  城市首字母
        [sub addObject:ch];
        for (int i = 0; i < models.count; i++) {
            CityModel * model = models[i];
            if ([model.pinyinFull hasPrefix:ch]) {
                [sub addObject:model];
                [self.dataSource addObject:model];
            }
        }
        if (sub.count > 1) {
            [self.baseDataSource addObject:sub];
        }
    }
    //保存一下原始 数据源
    self.storeDataSource = [NSMutableArray arrayWithArray:self.dataSource];
    [self.baseTableView reloadData];
    [self.baseCollectionView reloadData];
}

- (void)customSearchBar{
    
    self.searchBar.tintColor = [UIColor redColor];
    self.searchBar.barTintColor = [UIColor barColor];
    self.searchBar.placeholder = @"输入城市名";
    self.searchBar.delegate = self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.searchBar resignFirstResponder];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark searchBar 代理方法
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    
    self.baseCollectionView.hidden = YES;
    self.baseTableView.hidden = NO;
    [searchBar setShowsCancelButton:YES animated:YES];
    
    for (id obj in [searchBar.subviews[0] subviews]) {
        if ([obj isKindOfClass:[UIButton class]]) {
            [(UIButton *)obj setTitle:@"取消" forState:UIControlStateNormal];
        }
    }
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar setShowsCancelButton:NO animated:YES];
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchTex{
    
    [self.dataSource removeAllObjects];
    int sum = 0;
    for (int i = 0; i < self.storeDataSource.count - sum; i++) {
     
        if ([[self.storeDataSource[i] n] containsString:searchTex]) {
            [self.dataSource addObject:self.storeDataSource[i]];
        }
    }
    if ([searchTex isEqualToString:@""]) {
        [self.dataSource addObjectsFromArray:self.storeDataSource];
    }
    if (self.dataSource.count == 0) {
        self.baseTableView.tableHeaderView = noReultLabel;
    }else{
        self.baseTableView.tableHeaderView = nil;
    }
    [self.baseTableView reloadData];
    
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    [self.dataSource removeAllObjects];
    [self.dataSource addObjectsFromArray:self.storeDataSource];
    [self.baseTableView reloadData];
    
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];

    self.baseCollectionView.hidden = NO;
    self.baseTableView.hidden = YES;
    
}
#pragma mark collectionView 代理方法

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return self.baseDataSource.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    return  [(NSArray *)self.baseDataSource[section] count] - 1;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CityCellCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cityCellID forIndexPath:indexPath];
    cell.model = self.baseDataSource[indexPath.section][indexPath.row + 1];
    
    return cell;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        CitySectionHeaderView * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID forIndexPath:indexPath];
        headerView.sectionLabel.text = [self.baseDataSource[indexPath.section] firstObject];
        
        headerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        return headerView;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(ZScreenWidth, 30);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    

    if (self.cityBlcok) {
        self.cityBlcok(self.baseDataSource[indexPath.section][indexPath.row + 1]);
    }
    
    [self.tabBarController.view setTransitionAnimation:ZQLTransitionAnimationTypeFade toward:ZQLTransitionAnimationTowardTypesFromRight duration:0.5];
    [self.navigationController popToRootViewControllerAnimated:NO];

}

#pragma mark tableView代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:tableCellID forIndexPath:indexPath];
    cell.textLabel.text = [self.dataSource[indexPath.row] n];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.searchBar.text = [self.dataSource[indexPath.row] n];
    
    if (self.cityBlcok) {
        self.cityBlcok(self.dataSource[indexPath.row]);
        [self.navigationController.view setTransitionAnimation:ZQLTransitionAnimationTypePageCurl toward:ZQLTransitionAnimationTowardTypesFromBottom duration:0.5];
        [self.navigationController popToRootViewControllerAnimated:NO];
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
