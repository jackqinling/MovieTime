//
//  UIFont+ScreenFont.m
//  ZQLHotMovieLine
//
//  Created by MacQin on 4/5/16.
//  Copyright © 2016 MS. All rights reserved.
//

#import "UIFont+ScreenFont.h"
#import "ZQLScreenMacro.h"

@implementation UIFont (ScreenFont)

+ (UIFont *)screenFontOfSize:(CGFloat)fontSize{
    if (ZScreenWidth == 320) {
        return [UIFont systemFontOfSize:fontSize];
    }else{
        return [UIFont systemFontOfSize:(fontSize / 320.f * ZScreenWidth)];
    }
}
@end
