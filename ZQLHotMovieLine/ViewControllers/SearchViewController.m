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
#import "DJRefresh.h"

#import "SearchResultModel.h"
#import "SearchPersonModel.h"
#import "SearchMovieModel.h"
#import "SearchCinemaModel.h"
#import "SearchGoodModel.h"
#import "SearchPersonModel.h"
#import "SearchCinemaModel.h"
#import "SearchHintModel.h"

#import "SearchHintCell.h"
#import "SearchCinemaCell.h"
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
    Hint = 8,
} ResultType;

static NSString * const cellID = @"cellID";
static NSString * const movieCellID = @"movieID";
static NSString * const personCellID = @"personID";
static NSString * const cinemaCellID = @"cinemaID";
static NSString * const hintCellID = @"hintID";

@interface SearchViewController ()<UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, TitleViewDelegate, UIScrollViewDelegate, DJRefreshDelegate>

@property (nonatomic, strong) NSMutableArray * refreshArray;

@end

@implementation SearchViewController
{
    int _pageIndex[4];//刷新标签
    UITextField * _textField;
    
    SearchKeyWordsModel * _keyWordsModel;//四个文字搜索按钮
    NSMutableArray * _keyWordsHisArray;//存储搜索过得关键词  退出 返回时 放到本地
    SearchResultModel * _resultModel;//数据源 头按钮(个数)
    
    UIScrollView * _searchResultScrollView;//三个结果tableView
    UITableView * _hintTableView;//搜索关键字 提示列表
    
    TitleView * _titleView;//滑动按钮
    BOOL isDragging;//拖动 和 点击按钮
    
    UIView * _hintHeaderView;//判断是否已经创建,创建的话直接复用
    UILabel * _hintLabel;
    NSMutableArray * _hintArray;
    NSString * _text;
}

//保存插件 防止意外释放
- (NSMutableArray *)refreshArray{
    if (!_refreshArray) {
        _refreshArray = [NSMutableArray array];
    }
    return _refreshArray;
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
    /**
     *  三个搜索结果tableView 装载在一个scrollView中
     */
    [self settingResultScrollView];
    [self loadResultDataWithRefresh:YES searchType:AllType KeyWord:@"万达"];
    //搜索提示列表
    [self settingHintTableView];
}

//初始化 数据源
- (void)resetDataSource{
    for (int i = 0; i < 4; i++) {
        NSMutableArray * array = [NSMutableArray array];
        [self.baseDataSource addObject:array];
    }
    //tableView起始页
    for (int i = 0; i < 4; i++) {
        _pageIndex[i] = 1;
    }
    _keyWordsHisArray = [NSMutableArray array];
    _text = [NSString string];
    _hintArray = [NSMutableArray array];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [_textField resignFirstResponder];
}
//关键字按钮 加载
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
    
    if (refresh) {
        _pageIndex[resultType] = 1;
        [self.baseDataSource[resultType] removeAllObjects];
    }else{
        _pageIndex[resultType]++;
    }
    
    Class modelClass;
    switch (resultType) {
        case Movie:{
            modelClass = [SearchMovieModel class];
        }
            break;
        case Actor:{
            modelClass = [SearchPersonModel class];
        }
            break;
        case Cinema:{
            
            modelClass = [SearchCinemaModel class];
        }
            break;
        default:
            break;
    }

    
    NSDictionary * dic = @{@"locationId":@"290", @"KeyWord":kewWord, @"searchType":SearchType[resultType] ,@"pageIndex":@(_pageIndex[resultType])};
    
    switch (resultType) {
        case Movie:
        case Actor:
        case Cinema:{
            [self.manager postWithUrl:SearchKeyWordUrl parameters:dic complicate:^(BOOL success, id object) {
                if (success) {
                    //请求成功 返回一个数组 含有 一个元素  为数组  装models
                 
                    [self.baseDataSource[resultType] addObjectsFromArray:object];
                    [self.refreshArray[resultType] finishRefreshing];
            
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
                    [self.baseDataSource[Movie] addObjectsFromArray:object[Movie]];
                    [self.baseDataSource[Actor] addObjectsFromArray:object[Actor]];
                    [self.baseDataSource[Cinema] addObjectsFromArray:object[Cinema]];
   
                    
                    for (int i = 0; i < 3; i++) {
                        [[self tableViewWithType:i] reloadData];
                        [self setTitleViewWithModel:object[3][0]];
                    }
                }else{
                    //请求失败  处理
                }
                
                
            } modelClassNameArray:@[@"SearchMovieModel", @"SearchPersonModel", @"SearchCinemaModel", @"SearchResultModel"]];
        }
            break;
    }

 
}

- (void)setTitleViewWithModel:(SearchResultModel *)model{
    
    NSString * m = [NSString stringWithFormat:@"影片(%@)", model.moviesCount];
    NSString * p =[NSString stringWithFormat:@"影人(%@)", model.personsCount];
    NSString * c = [NSString stringWithFormat:@"影院(%@)", model.locationCinemasCount];
    _titleView = [[TitleView alloc] initWithFrame:CGRectMake(0, NaviBarHeight + StatusBarHeight, ZScreenWidth, 44)];
    _titleView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [_titleView setTitles:@[m, p, c]];
    _titleView.delegate = self;
    [self.view addSubview:_titleView];
}

- (void)settingResultScrollView{
    //头按钮

    //显示搜索结果 tableview
    _searchResultScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NaviBarHeight + StatusBarHeight + 44, ZScreenWidth, ZScreenHeight - NaviBarHeight - StatusBarHeight - 44)];
    _searchResultScrollView.backgroundColor = [UIColor blackColor];
    _searchResultScrollView.pagingEnabled = YES;
    _searchResultScrollView.bounces = NO;
    _searchResultScrollView.autoresizesSubviews = NO;
    _searchResultScrollView.contentSize = CGSizeMake(ZScreenWidth * 3, ZScreenHeight - NaviBarHeight - StatusBarHeight - TabBarHeight);
    _searchResultScrollView.delegate = self;
    [_searchResultScrollView setHidden:NO];//默认设置为隐藏
    [self.view addSubview:_searchResultScrollView];
    
    //创建tableView
    
    for (int i = 0; i < 3; i++) {
        UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(i * ZScreenWidth, 0, ZScreenWidth, ZScreenHeight - NaviBarHeight - StatusBarHeight - 44 - TabBarHeight) style:UITableViewStyleGrouped];
        tableView.backgroundColor = [UIColor greenColor];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tag = TableViewTag + i;
        
        //绑定刷新插件
        DJRefresh * refresh = [[DJRefresh alloc] initWithScrollView:tableView delegate:self];
        refresh.topEnabled = YES;
        refresh.bottomEnabled = YES;
        [self.refreshArray addObject:refresh];
        
        //注册cell
        [_searchResultScrollView addSubview:tableView];
        switch (i) {
            case Movie:
                [tableView registerClass:[SearchMovieCell class] forCellReuseIdentifier:movieCellID];
                break;
            case Actor:
                [tableView registerClass:[SearchActorCell class] forCellReuseIdentifier:personCellID];
                break;
            case Cinema:
                [tableView registerClass:[SearchCinemaCell class] forCellReuseIdentifier:cinemaCellID];
                break;
                
            default:
                break;
        }
    }
}

//关键字列表
- (void)settingTableView{
    
    self.baseTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NaviBarHeight + StatusBarHeight, ZScreenWidth, ZScreenHeight - StatusBarHeight - NaviBarHeight) style:UITableViewStyleGrouped];
    
    self.baseTableView.delegate = self;
    self.baseTableView.dataSource = self;
    self.baseTableView.backgroundColor = [UIColor whiteColor];
    [self.baseTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    [self.view addSubview:self.baseTableView];
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
    _textField.delegate = self;
    
    _textField.placeholder = @"找影片/影院/影人";
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _text = _textField.text;
    [_textField addTarget:self action:@selector(textChaged:) forControlEvents:UIControlEventEditingChanged];
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

//搜索提示 列表
- (void)settingHintTableView{
    _hintTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, StatusBarHeight + NaviBarHeight, ZScreenWidth, ZScreenHeight - StatusBarHeight - NaviBarHeight - TabBarHeight) style:UITableViewStylePlain];
    
    _hintTableView.tag = TableViewTag + 8;
    _hintTableView.delegate = self;
    _hintTableView.dataSource = self;
    _hintTableView.hidden = YES;
    [_hintTableView registerClass:[SearchHintCell class] forCellReuseIdentifier:hintCellID];
    [self.view addSubview:_hintTableView];
    
}

- (void)settingHintHeaderViewWith:(NSString *)str{
    
    if (!_hintHeaderView) {
        _hintHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ZScreenWidth, 45)];
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 25, 25)];
        imageView.image = [UIImage imageNamed:@"icon_search_suggestion_store"];
        
        //label
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(45, 13, ZScreenWidth - 65, 20)];
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor barColor];
        NSMutableAttributedString * attStr = [self attributeStringWithString:str];
        label.attributedText = attStr;
        //记住将要复用的label
        _hintLabel = label;
        
        //箭头
        UIImageView * arrow = [[UIImageView alloc] initWithFrame:CGRectMake(ZScreenWidth - 20, 15, 10, 15)];
        arrow.image = [UIImage imageNamed:@"icon_right_arrow"];
        
        //button
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, ZScreenWidth, 45)];
        [button addTarget:self action:@selector(onClickStoreBtn:) forControlEvents:UIControlEventTouchDown];
        //底线
        UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, 44, ZScreenWidth, 1)];
        line.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        [_hintHeaderView addSubview:imageView];
        [_hintHeaderView addSubview:label];
        [_hintHeaderView addSubview:arrow];
        [_hintHeaderView addSubview:button];
        [_hintTableView addSubview:line];

    }else{
        NSMutableAttributedString * attStr = [self attributeStringWithString:str];
        _hintLabel.attributedText = attStr;
    }
    
    _hintTableView.tableHeaderView = _hintHeaderView;
}

- (NSMutableAttributedString *)attributeStringWithString:(NSString *)str {
    NSString * tex = [NSString stringWithFormat:@"在商城中搜索〝%@〞", str];
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:tex];
    [attStr setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15]} range:NSMakeRange(tex.length - str.length - 2, str.length + 2)];
    return attStr;
}

- (void)onClickStoreBtn:(UIButton *)button {
    //点击跳转到 商城
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
//    NSLog(@"%d行", row);
    [view setFrame:CGRectMake(0, 0, ZScreenWidth, LabelHeight + RowGapHeight * (row + 1) + row * KeyWordHeight) ];
    
    self.baseTableView.tableHeaderView = view;
}

//点击搜索关键字
- (void)onClickKeyWordButton:(UIButton *)button{
    
}

//hintTableView 请求数据
- (void)textChaged:(UITextField *)textField{
    
    //设置头
    [self settingHintHeaderViewWith:textField.text];
    NSLog(@"========%@", textField.text);
    NSDictionary * dic = @{@"locationId":@"290", @"keyword":textField.text};
    
    [self.manager postWithUrl:SearchHintUrl parameters:dic complicate:^(BOOL success, id object) {
        if (success) {
            [_hintArray removeAllObjects];//一进来就清空
            //请求成功 装载数据源 重绘tableView
            [_hintArray addObjectsFromArray:object];
            [_hintTableView reloadData];
            _hintTableView.hidden = NO;
            [self.view bringSubviewToFront:_hintTableView];
        } else {
            //请求失败
        }
    } modelClass:[SearchHintModel class]];
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
            return [self.baseDataSource[Cinema] count];
            break;
        case Hint:
            return [_hintArray count];
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
            SearchCinemaModel * model = self.baseDataSource[Cinema][indexPath.row];
            SearchCinemaCell * cell = [tableView dequeueReusableCellWithIdentifier:cinemaCellID forIndexPath:indexPath];
            cell.model = model;
            return cell;
        }
        case Hint:{
            SearchHintModel * model = _hintArray[indexPath.row];
            SearchHintCell * cell = [tableView dequeueReusableCellWithIdentifier:hintCellID forIndexPath:indexPath];
            cell.model = model;
            return cell;
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
        case Cinema:
        case Hint:
            return 110;
            break;
        default:
            return 0;
            break;
    }
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (tableView == self.baseTableView) {
        return 40;
    }
    return 0.1;
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
//无限循环调用  实时刷新  lineView 的位置
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == _searchResultScrollView && isDragging) {
        [_titleView setLineViewPositon:scrollView.contentOffset.x / 3.0f];
    }
}
//滚动后  选择  titleView
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == _searchResultScrollView) {
        int index = (int)(scrollView.contentOffset.x / ZScreenWidth);
        [_titleView clickButton:_titleView.buttons[index]];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (scrollView == _searchResultScrollView) {
        isDragging = YES;
    }
}

#pragma mark - titleView代理方法
- (void)titleView:(TitleView *)view selectIndex:(NSInteger)index{
    isDragging = NO;
    [_searchResultScrollView setContentOffset:CGPointMake(index * ZScreenWidth, 0) animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - DJRefresh代理方法
//开刷
- (void)refresh:(DJRefresh *)refresh didEngageRefreshDirection:(DJRefreshDirection)direction{
    
    ResultType type = refresh.scrollView.tag - TableViewTag;
    
    if (direction == DJRefreshDirectionTop) {
        //顶部
        [self loadResultDataWithRefresh:YES searchType:type KeyWord:@"万达"];
    } else {
        //底部
        [self loadResultDataWithRefresh:NO searchType:type KeyWord:@"万达"];
    }
}

#pragma mark - TextField代理方法

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
