//
//  UIView+ZQLTransitonAnimation.m
//  模态视图viewcontroller回想切换
//
//  Created by MS on 15-12-1.
//  Copyright (c) 2015年 赵秦岭. All rights reserved.
//

#import "UIView+ZQLTransitonAnimation.h"

@implementation UIView (ZQLTransitonAnimation)

//@"cameraIris",
//@"cube",
//@"fade",
//@"moveIn",
//@"oglFilp",
//@"pageCurl",
//@"pageUnCurl",
//@"push",
//@"reveal",
//@"rippleEffect",
//@"suckEffect"
- (void)setTransitionAnimation:(ZQLTransitionAnimationType)animation toward:(ZQLTransitionAnimationTowardType)toward duration:(NSTimeInterval)time
{
    NSArray * type = @[@"cameraIris", @"cube", @"fade", @"moveIn", @"oglFilp", @"pageCurl", @"pageUnCurl", @"push", @"reveal", @"rippleEffect", @"suckEffect"];
    NSArray * towardType = @[@"fromRight", @"fromLeft", @"fromTop", @"fromBottom"];
    CATransition * cattransiton = [CATransition animation];
    cattransiton.type = type[animation];
    cattransiton.subtype = towardType[toward];
    cattransiton.duration = time;
    [self.layer addAnimation:cattransiton forKey:nil];
    
}
@end
