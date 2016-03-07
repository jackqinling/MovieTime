//
//  TicketViewController.m
//  ZQLHotMovieLine
//
//  Created by MS on 16-1-12.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import "TicketViewController.h"
#import "CitiesChoiceViewController.h"

@interface TicketViewController ()

@end

@implementation TicketViewController
{
    UIButton * cityButton;
    CGSize imageSize;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self settingNaviBarItem];
    [self settingLeftNaviItemWithTitle:@"北京"];
}

- (void)settingNaviBarItem{
    
    //右边按钮
    NSMutableArray * items = [NSMutableArray array];
    NSArray * imageNames = @[@"icon_magnifier"];
    for (NSString * name in imageNames) {
        UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:name] style:UIBarButtonItemStylePlain target:self action:@selector(onClickItem:)];
        [items addObject:item];
    }
    self.navigationItem.rightBarButtonItems = items;
    
    //titleView segmented control 中间按钮
    NSArray * itemsArray = @[@"电影", @"影院"];
    UISegmentedControl * segmentControl = [[UISegmentedControl alloc] initWithItems:itemsArray];
    segmentControl.frame = CGRectMake(0, 0, 140, 30);
    
    [segmentControl.layer setMasksToBounds:YES];
    [segmentControl.layer setCornerRadius:15];
    segmentControl.selectedSegmentIndex = 0;
    
    [segmentControl addTarget:self action:@selector(onClickSegment:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = segmentControl;
}
//leftButton

- (void)onClickSegment:(UISegmentedControl *)segment{
    
}
- (void)onClickItem:(UIBarButtonItem *)button{
    NSLog(@"right");
}
- (void)onClickDiscover:(UIButton *)button{
    NSLog(@"find");
    CitiesChoiceViewController * cvc = [[CitiesChoiceViewController alloc] init];
    cvc.cityBlcok = ^(CityModel * city){
//        [self loadHeadPosterDataWithCity:city.cID];
        [self settingLeftNaviItemWithTitle:city.n];
    };
    [self.tabBarController.view setTransitionAnimation:ZQLTransitionAnimationTypeCameraIris toward:ZQLTransitionAnimationTowardTypesFromBottom duration:1];
    [self.navigationController pushViewController:cvc animated:NO];
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
