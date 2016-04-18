//
//  ZQLScreenMacro.h
//  ZQLHotMovieLine
//
//  Created by MS on 16-1-12.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#ifndef ZQLHotMovieLine_ZQLScreenMacro_h
#define ZQLHotMovieLine_ZQLScreenMacro_h

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self

#define ZScreenSize ([UIScreen mainScreen].bounds.size)
#define ZScreenWidth (ZScreenSize.width)
#define ZScreenHeight (ZScreenSize.height)
#define NaviBarHeight 44.0
#define TabBarHeight 49.0
#define StatusBarHeight 20.0
#define PlaceHolder [UIImage imageNamed:@"icon_default_100x100"]
#define SquareHolder [UIImage imageNamed:@"icon_default_100x100"]
#define HRectangleHolder [UIImage imageNamed:@"icon_default_90x60"]
#define LHRectangleHolder [UIImage imageNamed:@"icon_default_320x120"]
#define VRectangleHolder [UIImage imageNamed:@"icon_default_60x90"]
#define LVRectangleHolder [UIImage imageNamed:@"icon_default_200x300"]

#define USER_DEFAULT [NSUserDefaults standardUserDefaults]

#endif

