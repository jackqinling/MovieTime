//
//  PreviewVideoViewController.m
//  ZQLHotMovieLine
//
//  Created by MacQin on 3/16/16.
//  Copyright © 2016 MS. All rights reserved.
//

#import "PreviewVideoViewController.h"
#import "VideoListCell.h"
#import "VideoListModel.h"
#import "DJRefresh.h"

static NSString * const videoCellID = @"videoCell";

@interface PreviewVideoViewController ()<UITableViewDataSource, UITableViewDelegate, DJRefreshDelegate>
{
    int page;
}
//防止被意外释放
@property (nonatomic, strong) NSMutableArray * refreshArray;

@end

@implementation PreviewVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBarController.tabBar.hidden = YES;
    [self settingTableView];
    [self settingNaviBarWithTitle:@"预告片&拍摄花絮"];
    [self loadDataRefresh:YES];
}

- (void)loadDataRefresh:(BOOL)refresh{

    if (refresh) {
        page = 1;
    }else{
        page++;
    }
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:@{@"pageIndex":@(page)}];
    [dic setObject:self.movieID forKey:@"movieId"];
    
    [self.manager requestWithGetMethod:VideoListUrl parameters:dic complicate:^(BOOL success, id object) {
        
        [(DJRefresh * )self.refreshArray[0] finishRefreshing];
        
        if (success) {
            if (refresh) {
                [self.baseDataSource removeAllObjects];
            }
            
            [self.baseDataSource addObjectsFromArray:object[0]];
            //请求成功后刷新cell
            [self.baseTableView reloadData];
        }else{
            //界面显示错误信息
        }
        
    } modelClassNameArray:@[@"VideoListModel"]];
}
- (void)settingTableView{
    
    self.refreshArray = [NSMutableArray array];
    
    self.baseTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NaviBarHeight + StatusBarHeight, ZScreenWidth, ZScreenHeight - NaviBarHeight - StatusBarHeight) style:UITableViewStylePlain];
    self.baseTableView.backgroundColor = [UIColor randomColor];
    
    self.baseTableView.delegate = self;
    self.baseTableView.dataSource = self;
    //注册
    [self registerTableViewWithCellNibNameArray:@[@"VideoListCell"] withIdentfierArray:@[videoCellID]];
    
    //刷新插件
    DJRefresh * refresh = [[DJRefresh alloc] initWithScrollView:self.baseTableView delegate:self];
    refresh.topEnabled = YES;
    refresh.bottomEnabled = YES;
    //保留一次
    [self.refreshArray addObject:refresh];
    
    [self.view addSubview:self.baseTableView];
}

#pragma mark - tableView代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.baseDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    VideoListCell * cell = [self.baseTableView dequeueReusableCellWithIdentifier:videoCellID forIndexPath:indexPath];
    
    cell.model = self.baseDataSource[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    VideoListModel * model = self.baseDataSource[indexPath.row];
    
    CGRect rect = [model.title boundingRectWithSize:CGSizeMake(ZScreenWidth - 180, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
    if (rect.size.height > 57) {
        return (55 + rect.size.height);
    }else{
        return 115;
    }
}
#pragma mark - DJRefresh代理方法

- (void)refresh:(DJRefresh *)refresh didEngageRefreshDirection:(DJRefreshDirection)direction{
    
    if (direction == DJRefreshDirectionTop) {
        [self loadDataRefresh:YES];
    }
    if (direction == DJRefreshDirectionBottom) {
        [self loadDataRefresh:NO];
    }
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
