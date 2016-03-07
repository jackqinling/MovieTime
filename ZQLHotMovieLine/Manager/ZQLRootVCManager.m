//
//  ZQLRootVCManager.m
//  ZQLHotMovieLine
//
//  Created by MS on 16-1-11.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import "ZQLRootVCManager.h"
#import "ZQLBaseNaviController.h"
#import "ZQLBaseTabBarController.h"
#import "ZQLBaseViewController.h"
#import "HomeViewController.h"
#import "TicketViewController.h"
#import "StoreViewController.h"
#import "DiscoveryViewController.h"
#import "MeViewController.h"
#import "UIColor+categoryColor.h"
#import "TicketViewController.h"

#import "MovieViewController.h"
#import "CinemaViewController.h"

@interface ZQLRootVCManager ()


@end

@implementation ZQLRootVCManager

+ (UIViewController *)getMainRootVC{
    
    NSArray * controllers = @[@"HomeViewController", @"TicketViewController", @"StoreViewController", @"DiscoveryViewController", @"MeViewController"];
    
    NSArray * titles = @[@"首页", @"购票", @"商城", @"发现", @"我的"];
    
    NSArray * images = @[@"home", @"payticket", @"store", @"discover", @"myinfo"];
    
    NSMutableArray * viewContorllers = [NSMutableArray array];
    
    int i = 0;
    
    for (NSString * controllername in controllers) {
        
        UINavigationController * nc = [self naviVCFromViewControllerClassName:controllername];
        
        UITabBarItem * item = [[UITabBarItem alloc] initWithTitle:titles[i] image:[[UIImage imageNamed:images[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:[NSString stringWithFormat:@"%@_on", images[i]]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        nc.tabBarItem = item;
        nc.navigationBar.translucent = YES;
        nc.navigationBar.tintColor = [UIColor whiteColor];
        nc.navigationBar.barTintColor = [UIColor naviBarColor];
        nc.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
        nc.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -2);
        [viewContorllers addObject:nc];
        
        i++;
    }
    
  
    ZQLBaseTabBarController * tbc = [[ZQLBaseTabBarController alloc] init];
    
    tbc.tabBar.tintColor = [UIColor blackColor];
    tbc.viewControllers = viewContorllers;
    
    //设置tabBar
    tbc.tabBar.translucent = NO;
    return tbc;
}

+ (UINavigationController *)naviVCFromViewControllerClassName:(NSString *)controllerName{
    
    UIViewController * vc = [[NSClassFromString(controllerName) alloc] init];
    
    vc.automaticallyAdjustsScrollViewInsets = NO;
    UINavigationController * nc = [[UINavigationController alloc] initWithRootViewController:vc];
    nc.navigationBar.tintColor = [UIColor whiteColor];
    
    return nc;
}

@end
