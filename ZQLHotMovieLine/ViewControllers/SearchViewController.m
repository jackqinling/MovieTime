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

#define KeyWordHeight 35
#define RowGapHeight 15
#define ColumnGapWidth 15
#define LabelHeight 35
#define ButBlankWidth 30
#define PreGap 20

typedef enum : NSUInteger {
    Actor = 0,
    Movie,
    Cinema,
} ResultType;

static NSString * cellID = @"cellID";
@interface SearchViewController ()<UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>

@end

@implementation SearchViewController
{
    NSInteger _pageIndex;
    UITextField * _textField;
    
    SearchKeyWordsModel * _keyWordsModel;
    NSArray * _keyWordsHisArray;
    
    UIScrollView * _searchResultScrollView;
//    UITableView * _movieTableView;
//    UITableView * _actorTableView;
//    UITableView * _cinemaTableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _pageIndex = 0;
    [self settingNaviBarWithTitle:@""];
    [self loadData];
    [self settingNaviItems];
    [self settingTableView];
    [self loadResultDataWithRefresh:YES andKeyWord:@"万达"];
}

- (void)loadData{
    [self.manager getWithUrl:SearchMovieUrl parameters:nil complicate:^(BOOL success, id object) {
        _keyWordsModel = [object firstObject];
        [self settingTableHeaderView];
    } modelClass:[SearchKeyWordsModel class]];
}

- (void)loadResultDataWithRefresh:(BOOL)refresh andKeyWord:(NSString *)kewWord{
    if (refresh) {
        _pageIndex = 1;
    }else{
        _pageIndex++;
    }
    NSDictionary * dic = @{@"locationId":@"290", @"KeyWord":kewWord};
    [self.manager requestWithPostMethod:SearchKeyWordUrl parameters:dic complicate:^(BOOL success, id object) {
        SearchResultModel * model = object[0][0];
        
        NSLog(@"%@", model);
    } modelClassNameArray:@[@"SearchResultModel"]];
}


- (void)settingResultScrollView{
    
    _searchResultScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NaviBarHeight + StatusBarHeight + 44, ZScreenWidth, ZScreenHeight - NaviBarHeight - StatusBarHeight - 44)];
    _searchResultScrollView.pagingEnabled = YES;
    _searchResultScrollView.contentSize = CGSizeMake(ZScreenWidth * 3, ZScreenHeight - NaviBarHeight - StatusBarHeight - 44);
    _searchResultScrollView.delegate = self;
    [_searchResultScrollView setHidden:YES];//默认设置为隐藏
    [self.view addSubview:_searchResultScrollView];
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
        CGRect rect = [keyWord boundingRectWithSize:CGSizeMake(ZScreenWidth - 2 * PreGap, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
        
        width += rect.size.width + ButBlankWidth;
        
        if (width > (ZScreenWidth - PreGap) * row) {
            row++;
            width = rect.size.width + ButBlankWidth + PreGap;
        }
        
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(width - rect.size.width - ButBlankWidth, (row - 1) * KeyWordHeight + RowGapHeight * row + LabelHeight, rect.size.width + 10 + ButBlankWidth / 2.0, KeyWordHeight)];
        [button addTarget:self action:@selector(onClickKeyWordButton:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:keyWord forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
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
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, ZScreenWidth - 90, 34)];
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
    return self.baseDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.textLabel.text = self.baseDataSource[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (self.baseDataSource.count != 0) {
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
    if (self.baseDataSource.count != 0) {
        return [self labelWithTitle:@"   搜索历史"];
    }else{
        return [[UIView alloc]init];
    }
    
}
- (void)onClickClearHis:(UIButton *)button{
    NSLog(@"clear");
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
