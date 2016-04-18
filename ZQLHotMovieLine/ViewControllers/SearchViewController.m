//
//  SearchViewController.m
//  ZQLHotMovieLine
//
//  Created by MacQin on 4/8/16.
//  Copyright © 2016 MS. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchKeyWordsModel.h"
#import "TitleView.h"

#import "SearchResultModel.h"
#import "SearchPersonModel.h"
#import "SearchMovieModel.h"
#import "SearchCinemaModel.h"
#import "SearchGoodModel.h"
#import "SearchPersonModel.h"

#import "SearchActorCell.h"
#import "SearchMovieCell.h"

#define KeyWordHeight 28
#define RowGapHeight 15
#define ColumnGapWidth 15
#define LabelHeight 35
#define ButBlankWidth 30
#define PreGap 20
#define TableViewTag 111
#define SearchType @[@"0", @"2", @"1", @"3"]

typedef enum : NSUInteger {
    Movie = 0,
    Actor,
    Cinema,
    AllType,
} ResultType;

static NSString * const cellID = @"cellID";
static NSString * const movieCellID = @"movieID";
static NSString * const personCellID = @"personID";

@interface SearchViewController ()<UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, TitleViewDelegate, UIScrollViewDelegate>

@end

@implementation SearchViewController
{
    int _pageIndex[4];
    UITextField * _textField;
    
    SearchKeyWordsModel * _keyWordsModel;
    
    NSMutableArray * _keyWordsHisArray;
    SearchResultModel * _resultModel;//数据源
    
    UIScrollView * _searchResultScrollView;
    //滑动按钮
    TitleView * _titleView;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self settingNaviBarWithTitle:@""];
    //设置数据源结构
    [self resetDataSource];
    [self loadData];
    [self settingNaviItems];
    [self settingTableView];
    [self settingResultScrollView];
    [self loadResultDataWithRefresh:YES searchType:AllType KeyWord:@"万达"];

    
}

- (void)resetDataSource{
    for (int i = 0; i < 3; i++) {
        NSMutableArray * array = [NSMutableArray array];
        [self.baseDataSource addObject:array];
    }
    //tableView起始页
    for (int i = 0; i < 4; i++) {
        _pageIndex[i] = 1;
    }
    _keyWordsHisArray = [NSMutableArray array];
}

- (void)loadData{
    [self.manager getWithUrl:KeyWordButtonUrl parameters:nil complicate:^(BOOL success, id object) {
        _keyWordsModel = [object firstObject];
        [self settingTableHeaderView];
    } modelClass:[SearchKeyWordsModel class]];
}

- (UITableView *)tableViewWithType:(ResultType)type{
    
    return (UITableView *)[_searchResultScrollView viewWithTag:type + TableViewTag];
}

- (void)loadResultDataWithRefresh:(BOOL)refresh searchType:(ResultType)resultType KeyWord:(NSString *)kewWord{
    
    Class modelClass;
    if (refresh) {
        _pageIndex[resultType] = 1;
        switch (resultType) {
            case Movie:{
                [self.baseDataSource[Movie] removeAllObjects];
                modelClass = [SearchMovieModel class];
            }
                break;
            case Actor:{
                [self.baseDataSource[Actor] removeAllObjects];
                modelClass = [SearchPersonModel class];
            }
                break;
            case Cinema:{
                [self.baseDataSource[Cinema] removeAllObjects];
                modelClass = [SearchCinemaModel class];
            }
                break;
            default:
                break;
        }
    }else{
        _pageIndex[resultType]++;
    }
    
    NSDictionary * dic = @{@"locationId":@"290", @"KeyWord":kewWord, @"searchType":SearchType[resultType] ,@"pageIndex":@(_pageIndex[resultType])};
    
    switch (resultType) {
        case Movie:
        case Actor:
        case Cinema:{
            [self.manager postWithUrl:SearchKeyWordUrl parameters:dic complicate:^(BOOL success, id object) {
                if (success) {
                    //请求成功
                    [self.baseDataSource[resultType] addObjectsFromArray:object[0]];
                    [[self tableViewWithType:resultType] reloadData];
                }else{
                    //请求失败
                }
            } modelClass:modelClass];
        }
            break;
        default:{
            [self.manager requestWithPostMethod:SearchKeyWordUrl parameters:dic complicate:^(BOOL success, id object) {
                if (success) {
                    [self.baseDataSource[Movie] addObjectsFromArray:object[Movie][0]];
                    [self.baseDataSource[Actor] addObjectsFromArray:object[Actor][0]];
                    [self.baseDataSource[Cinema] addObjectsFromArray:object[Cinema][0]];
   
                    
                    for (int i = 0; i < 3; i++) {
                        [[self tableViewWithType:i] reloadData];
                    }
                }else{
                    //请求失败  处理
                }
                
                
            } modelClassNameArray:@[@"SearchMovieModel", @"SearchPersonModel", @"SearchCinemaModel"]];
        }
            break;
    }

 
}


- (void)settingResultScrollView{
    //头按钮
    _titleView = [[TitleView alloc] initWithFrame:CGRectMake(0, NaviBarHeight + StatusBarHeight, ZScreenWidth, 44)];
    _titleView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [_titleView setTitles:@[@"影片(280)", @"影人(1282)", @"影院(0)"]];
    _titleView.delegate = self;
    [self.view addSubview:_titleView];
    
    //显示搜索结果 tableview
    _searchResultScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NaviBarHeight + StatusBarHeight + 44, ZScreenWidth, ZScreenHeight - NaviBarHeight - StatusBarHeight - 44)];
    _searchResultScrollView.backgroundColor = [UIColor blackColor];
    _searchResultScrollView.pagingEnabled = YES;
    _searchResultScrollView.bounces = NO;
    _searchResultScrollView.autoresizesSubviews = NO;
    _searchResultScrollView.contentSize = CGSizeMake(ZScreenWidth * 3, ZScreenHeight - NaviBarHeight - StatusBarHeight - 44);
    _searchResultScrollView.delegate = self;
    [_searchResultScrollView setHidden:NO];//默认设置为隐藏
    [self.view addSubview:_searchResultScrollView];
    
    //创建tableView
    
    for (int i = 0; i < 3; i++) {
        UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(i * ZScreenWidth, 0, ZScreenWidth, ZScreenHeight - NaviBarHeight - StatusBarHeight - 44) style:UITableViewStyleGrouped];
        tableView.backgroundColor = [UIColor greenColor];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.bounces = NO;
        tableView.tag = TableViewTag + i;
        [_searchResultScrollView addSubview:tableView];
        switch (i) {
            case Movie:
                [tableView registerClass:[SearchMovieCell class] forCellReuseIdentifier:movieCellID];
                break;
            case Actor:
                [tableView registerClass:[SearchActorCell class] forCellReuseIdentifier:personCellID];
                break;
            case Cinema:
                
                break;
                
            default:
                break;
        }
    }
}
- (void)settingTableView{
    
    self.baseTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NaviBarHeight + StatusBarHeight, ZScreenWidth, ZScreenHeight - StatusBarHeight - NaviBarHeight) style:UITableViewStyleGrouped];
    
    self.baseTableView.delegate = self;
    self.baseTableView.dataSource = self;
    self.baseTableView.backgroundColor = [UIColor whiteColor];
    [self.baseTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    [self.view addSubview:self.baseTableView];
}

- (UILabel *)labelWithTitle:(NSString *)title{
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ZScreenWidth, LabelHeight)];
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = [UIColor grayColor];
    label.backgroundColor = [UIColor groupTableViewBackgroundColor];
    label.text = title;
    
    return label;
}
- (void)settingTableHeaderView{
    
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    float width = PreGap;
    int row = 1;
    int i = 0;
    for (NSString * keyWord in _keyWordsModel.keywords) {
        CGRect rect = [keyWord boundingRectWithSize:CGSizeMake(ZScreenWidth - 2 * PreGap, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
        
        width += rect.size.width + ButBlankWidth;
        
        if (width > (ZScreenWidth - PreGap) * row) {
            row++;
            width = rect.size.width + ButBlankWidth + PreGap;
        }
        
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(width - rect.size.width - ButBlankWidth, (row - 1) * KeyWordHeight + RowGapHeight * row + LabelHeight, rect.size.width + 10 + ButBlankWidth / 2.0, KeyWordHeight)];
        [button addTarget:self action:@selector(onClickKeyWordButton:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:keyWord forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setBackgroundImage:[[UIImage imageNamed:@"icon_change_subway"] stretchableImageWithLeftCapWidth:30 topCapHeight:0] forState:UIControlStateNormal];
        [view addSubview:button];
        i++;
        
        width += ColumnGapWidth;
    }
    
    [view addSubview:[self labelWithTitle:@"   热门搜索"]];
    NSLog(@"%d行", row);
    [view setFrame:CGRectMake(0, 0, ZScreenWidth, LabelHeight + RowGapHeight * (row + 1) + row * KeyWordHeight) ];
    
    self.baseTableView.tableHeaderView = view;
}

//点击搜索关键字
- (void)onClickKeyWordButton:(UIButton *)button{
    
}
- (void)settingNaviItems{
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithTitle:@"搜索" style:UIBarButtonItemStylePlain target:self action:@selector(onClickSearchBtn:)];
    self.navigationItem.rightBarButtonItem = item;
    
    //textField定制
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, ZScreenWidth - 90, 32)];
    _textField.returnKeyType = UIReturnKeySearch;
    _textField.tintColor = [UIColor blackColor];
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    
    _textField.backgroundColor = [UIColor whiteColor];
    
    _textField.placeholder = @"找影片/影院/影人";
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    //左
    _textField.leftViewMode = UITextFieldViewModeAlways;
    UIImageView * leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 22)];
    leftImageView.contentMode = UIViewContentModeScaleAspectFit;
    leftImageView.image = [UIImage imageNamed:@"search"];
    _textField.leftView = leftImageView;
    //右
    _textField.rightViewMode = UITextFieldViewModeUnlessEditing;
    UIButton * rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 0, 40, 30)];
    [rightBtn setImage:[UIImage imageNamed:@"icon_scan_barcode"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(onClickScan:) forControlEvents:UIControlEventTouchUpInside];
    _textField.rightView = rightBtn;
    
    
    self.navigationItem.titleView = _textField;
    
}
//naivItem 点击方法
- (void)onClickSearchBtn:(UIBarButtonItem *)item{
    NSLog(@"跳转到搜索结果页");
}

- (void)onClickScan:(UIButton *)button{
    NSLog(@"二维码");
}

#pragma mark - tableView代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //判断是哪个tableView
    switch (tableView.tag - TableViewTag) {
        case Movie:
            return [self.baseDataSource[Movie] count];
            break;
        case Actor:
            return [self.baseDataSource[Actor] count];
            break;
        case Cinema:
            return 0;
            return [self.baseDataSource[Cinema] count];
            break;
            //查找历史
        default:
            return _keyWordsHisArray.count;
            break;
    }
//    return self.baseDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (tableView.tag - TableViewTag) {
        case Movie:{
            SearchMovieCell * cell = [tableView dequeueReusableCellWithIdentifier:movieCellID forIndexPath:indexPath];
            cell.model = self.baseDataSource[Movie][indexPath.row];
            return cell;
        }
            break;
        case Actor:{
            SearchPersonModel * model = self.baseDataSource[Actor][indexPath.row];
            SearchActorCell * cell = [tableView dequeueReusableCellWithIdentifier:personCellID forIndexPath:indexPath];
            cell.model = model;
            return cell;
        }
            break;
        case Cinema:{
        }
            break;
        default:
            break;
    }
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.textLabel.text = _keyWordsHisArray[indexPath.row];
    return cell;
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (tableView.tag - TableViewTag) {
        case Movie:
        case Actor:
            return 150;
            break;
            
        default:
            return 0;
            break;
    }
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == self.baseTableView) {
        return 40;
    }
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (_keyWordsHisArray.count != 0) {
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, ZScreenWidth, 40)];
        [button setTitle:@"点击清空历史记录" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor barColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button addTarget:self action:@selector(onClickClearHis:) forControlEvents:UIControlEventTouchUpInside];
        return button;
    }else{
        return [[UIView alloc]init];
    }
   
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (_keyWordsHisArray.count != 0) {
        return [self labelWithTitle:@"   搜索历史"];
    }else{
        return [[UIView alloc]init];
    }
    
}
- (void)onClickClearHis:(UIButton *)button{
    NSLog(@"clear");
}

#pragma makr - scrollView代理方法
//无限循环调用
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    if (scrollView == _searchResultScrollView) {
//        int index = (int)(scrollView.contentOffset.x / ZScreenWidth + 0.6);
//        [_titleView clickButton:_titleView.buttons[index]];
//
//    }
//}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == _searchResultScrollView) {
        int index = (int)(scrollView.contentOffset.x / ZScreenWidth);
        [_titleView clickButton:_titleView.buttons[index]];

    }
}
#pragma mark - titleView代理方法
- (void)titleView:(TitleView *)view selectIndex:(NSInteger)index{
    [_searchResultScrollView setContentOffset:CGPointMake(index * ZScreenWidth, 0) animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
