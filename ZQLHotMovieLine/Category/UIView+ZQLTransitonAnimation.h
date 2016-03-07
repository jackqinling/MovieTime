//
//  UIView+ZQLTransitonAnimation.h
//  模态视图viewcontroller回想切换
//
//  Created by MS on 15-12-1.
//  Copyright (c) 2015年 赵秦岭. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    ZQLTransitionAnimationTypeCameraIris,
    ZQLTransitionAnimationTypeCube,
    ZQLTransitionAnimationTypeFade,
    ZQLTransitionAnimationTypeMoveIn,
    ZQLTransitionAnimationTypeOglFilp,
    ZQLTransitionAnimationTypePageCurl,
    ZQLTransitionAnimationTypePush,
    ZQLTransitionAnimationTypeReveal,
    ZQLTransitionAnimationTypeRippleEffect,
    ZQLTransitionAnimationTypeSuckEffect
}ZQLTransitionAnimationType;

typedef enum {
    ZQLTransitionAnimationTowardTypesFromLeft,
    ZQLTransitionAnimationTowardTypesFromRight,
    ZQLTransitionAnimationTowardTypesFromTop,
    ZQLTransitionAnimationTowardTypesFromBottom
}ZQLTransitionAnimationTowardType;

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
@interface UIView (ZQLTransitonAnimation)

- (void)setTransitionAnimation:(ZQLTransitionAnimationType)animation toward:(ZQLTransitionAnimationTowardType)toward duration:(NSTimeInterval)time;

@end
