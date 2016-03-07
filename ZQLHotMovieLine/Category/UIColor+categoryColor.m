//
//  UIColor+categoryColor.m
//  ZQLHotMovieLine
//
//  Created by MS on 16-1-13.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import "UIColor+categoryColor.h"

@implementation UIColor (categoryColor)

+ (UIColor *)randomColor{
    
    return [UIColor colorWithRed:arc4random() % 255 / 255.0f green:arc4random() % 255 / 255.0f blue:arc4random() % 255 / 255.0f alpha:1];
}

+ (UIColor *)barColor{
    
    return [UIColor colorWithRed:18 / 255.0f green:94 / 255.0f blue:184 / 255.0f alpha:1];
}

+ (UIColor *)greenBack{
    
    return [UIColor colorWithRed:84 / 255.0f green:143 / 255.0f blue:14 / 255.0f alpha:1];
}

+ (UIColor *)orangeBack{
    
    return [UIColor colorWithRed:247 / 255.0f green:113 / 255.0f blue:10 / 255.0f alpha:1];
}

+ (UIColor *)naviBarColor{
    return [UIColor colorWithRed:14 / 255.0f green:95 / 255.0f blue:183 / 255.0f alpha:1];
}

@end
