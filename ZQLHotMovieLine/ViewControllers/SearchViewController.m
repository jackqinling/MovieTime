//
//  SearchViewController.m
//  ZQLHotMovieLine
//
//  Created by MacQin on 4/8/16.
//  Copyright © 2016 MS. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()<UITextFieldDelegate>

@end

@implementation SearchViewController
{
    UITextField * _textField;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self settingNaviBarWithTitle:@""];
    [self settingNaviItems];
    
}

- (void)settingTableView{
    
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
    UIImageView * leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, 30, 22)];
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
