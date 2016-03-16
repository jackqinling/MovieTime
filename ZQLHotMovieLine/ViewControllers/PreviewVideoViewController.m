//
//  PreviewVideoViewController.m
//  ZQLHotMovieLine
//
//  Created by MacQin on 3/16/16.
//  Copyright © 2016 MS. All rights reserved.
//

#import "PreviewVideoViewController.h"

@interface PreviewVideoViewController ()

@end

@implementation PreviewVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBarController.tabBar.hidden = YES;
    [self settingTableView];
    [self settingNaviBarWithTitle:@"预告片&拍摄花絮"];
}

- (void)settingTableView{
    self.baseTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NaviBarHeight + StatusBarHeight, ZScreenWidth, ZScreenHeight - NaviBarHeight - StatusBarHeight) style:UITableViewStylePlain];
    self.baseTableView.backgroundColor = [UIColor randomColor];
    
    [self.view addSubview:self.baseTableView];
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
