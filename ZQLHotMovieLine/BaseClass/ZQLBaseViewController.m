//
//  ZQLBaseViewController.m
//  ZQLHotMovieLine
//
//  Created by MS on 16-1-10.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import "ZQLBaseViewController.h"
#import "CitiesChoiceViewController.h"

@interface ZQLBaseViewController ()
@end

@implementation ZQLBaseViewController
{
    UIButton * cityButton;
    CGSize imageSize;
}
- (ZQLRequestManager *)manager{
    
    if (_manager == nil) {
        _manager = [[ZQLRequestManager alloc] init];
    }
    return _manager;
}

- (NSMutableArray *)baseDataSource{
    if (_baseDataSource == nil) {
        _baseDataSource = [NSMutableArray array];
    }
    return _baseDataSource;
    
}

- (UITableView *)baseTableView{
    if (_baseTableView == nil) {
        _baseTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, ZScreenWidth, ZScreenHeight - 20) style:UITableViewStylePlain];
        
        _baseTableView.delegate = self;
        _baseTableView.dataSource = self;
        _baseTableView.bounces = NO;

    }
    return _baseTableView;
}

- (UICollectionView *)baseCollectionView{
    
    if (_baseCollectionView == nil) {
        _baseCollectionView = [[UICollectionView alloc] init];
        _baseCollectionView.delegate = self;
        _baseCollectionView.dataSource = self;
        _baseCollectionView.bounces = NO;

    }
    
    return _baseCollectionView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self settingNaviBar];
}

- (void)settingNaviBarWithTitle:(NSString *)title{
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, NaviBarHeight)];
    label.text = title;
    label.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = label;
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"path"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack:)];
    self.navigationItem.leftBarButtonItem = item;
    
}

- (void)goBack:(UIBarButtonItem *)itme{
    [self.tabBarController.view setTransitionAnimation:ZQLTransitionAnimationTypeFade toward:ZQLTransitionAnimationTowardTypesFromRight duration:0.5];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)settingNaviBar{
    // Do any additional setup after loading the view from its nib.
    //把原来的tabBar变透明  设置新的背景颜色view 并设置statusBar的背景色
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationController.navigationBar.barTintColor = [UIColor clearColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIView * view = [[self.navigationController.navigationBar subviews][0] subviews][0];
    view.hidden = YES;
    _naviBarHiddenView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, ZScreenWidth, 44)];
    _naviBarHiddenView.backgroundColor = [UIColor naviBarColor];
    [self.view addSubview:_naviBarHiddenView];
    _naviBarHiddenView.hidden = NO;
    
    //statusBar
    _statusBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ZScreenWidth, 20)];
    _statusBar.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_statusBar];
}
- (void)changeNaviBarAlpha:(float)alhpa{
    
    UIView * view = [[self.navigationController.navigationBar subviews][0] subviews][0];
    view.hidden = YES;
    UIView * backGroudView = [self.navigationController.navigationBar subviews] [0];
    //    backGroudView.backgroundColor = [UIColor colorWithRed:14 / 255.0f green:95 / 255.0f blue:183 / 255.0f alpha:alhpa];
    UIView * image = [backGroudView.subviews lastObject];
    image.alpha = alhpa;
}

- (void)settingLeftNaviItemWithTitle:(NSString *)title{
    
    if (cityButton) {
        UILabel * label = cityButton.subviews[0];
        UIImageView * imageView = cityButton.subviews[1];
        
        label.text = title;
        CGRect rect = [title boundingRectWithSize:CGSizeMake(ZScreenWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
        [cityButton setFrame:CGRectMake(0, 0, rect.size.width + imageSize.width, rect.size.height)];
        [label setFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
        [imageView setFrame:CGRectMake(rect.size.width + 2, (rect.size.height - imageSize.height) / 2.0f + 1, imageSize.width, imageSize.height)];
        
        return;
    }
    CGRect rect = [title boundingRectWithSize:CGSizeMake(ZScreenWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
    label.text = title;
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor whiteColor];
    label.userInteractionEnabled = NO;
    
    UIImage * image = [UIImage imageNamed:@"icon_index_selectcity"];
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(rect.size.width + 2, (rect.size.height - image.size.height) / 2.0f + 1, image.size.width, image.size.height)];
    imageSize = CGSizeMake(image.size.width, image.size.height);
    
    imageView.image = image;
    
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, rect.size.width + image.size.width + 2, rect.size.height)];
    
    [button addSubview:label];
    [button addSubview:imageView];
    
    cityButton = button;
    
    [button addTarget:self action:@selector(onClickDiscover:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = item;
    
}

- (void)onClickDiscover:(UIButton *)button{
    NSLog(@"find");
    
}

//注册cell
- (void)registerTableViewWithCellNibNameArray:(NSArray *)CellNibName withIdentfierArray:(NSArray *)IdentifierStr{
    int i = 0;
    for (NSString * nibName in CellNibName) {
        [self.baseTableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:IdentifierStr[i]];
        i++;
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
