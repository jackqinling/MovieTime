//
//  SearchViewController.m
//  ZQLHotMovieLine
//
//  Created by MacQin on 4/8/16.
//  Copyright © 2016 MS. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchKeyWordsModel.h"

#define KeyWordHeight 40
#define RowGapHeight 20
#define ColumnGapWidth 40
#define LabelHeight 40
#define ButBlankWidth 20
@interface SearchViewController ()<UITextFieldDelegate>

@end

@implementation SearchViewController
{
    UITextField * _textField;
    
    SearchKeyWordsModel * _keyWordsModel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self settingNaviBarWithTitle:@""];
    [self loadData];
    [self settingNaviItems];
    [self settingTableView];
}

- (void)loadData{
    [self.manager getWithUrl:SearchMovieUrl parameters:nil complicate:^(BOOL success, id object) {
        _keyWordsModel = [object firstObject];
        [self settingTableHeaderView];
    } modelClass:[SearchKeyWordsModel class]];
}
- (void)settingTableView{
    
    self.baseTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NaviBarHeight + StatusBarHeight, ZScreenWidth, ZScreenHeight - StatusBarHeight - NaviBarHeight)];
    [self.view addSubview:self.baseTableView];
}

- (UILabel *)labelWithTitle:(NSString *)title{
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ZScreenWidth, LabelHeight)];
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = [UIColor grayColor];
    label.backgroundColor = [UIColor lightGrayColor];
    label.text = title;
    
    return label;
}
- (void)settingTableHeaderView{
    
    UIView * view = [[UIView alloc] init];
    float width = 15;
    int row = 1;
    int i = 0;
    for (NSString * keyWord in _keyWordsModel.keywords) {
        CGRect rect = [keyWord boundingRectWithSize:CGSizeMake(ZScreenWidth - 30, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
        
        width += rect.size.width + ButBlankWidth;
        
        if (width > (ZScreenWidth - 15) * row) {
            row++;
            width = rect.size.width + ButBlankWidth;
        }
        
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(width - rect.size.width - ButBlankWidth, (row - 1) * KeyWordHeight + RowGapHeight * row + LabelHeight, rect.size.width + 10, KeyWordHeight)];
        [button addTarget:self action:@selector(onClickKeyWordButton:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:keyWord forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"icon_change_subway"] forState:UIControlStateNormal];
        [view addSubview:button];
        i++;
        
        width += ColumnGapWidth;
    }
    
    [view addSubview:[self labelWithTitle:@"热门搜索"]];
    
    [view setFrame:CGRectMake(0, 0, ZScreenWidth, LabelHeight + RowGapHeight * (row - 1) + row * KeyWordHeight)];
    
    self.baseTableView.tableHeaderView = view;
}

//点击搜索关键字
- (void)onClickKeyWordButton:(UIButton *)button{
    
}
- (void)settingNaviItems{
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithTitle:@"搜索" style:UIBarButtonItemStylePlain target:self action:@selector(onClickSearchBtn:)];
    self.navigationItem.rightBarButtonItem = item;
    
    //textField定制
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, ZScreenWidth - 90, 38)];
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
