//
//  UITabBar+Ex.m
//  TabbarItemLottie
//
//  Created by 叶晓倩 on 2017/9/29.
//  Copyright © 2017年 xa. All rights reserved.
//

#import "UITabBar+Ex.h"

#import <UIKit/UIKit.h>
#if __has_include(<lottie-ios/Lottie.h>)
#import <lottie-ios/Lottie.h>
#else
#import "Lottie.h"
#endif

#import <objc/runtime.h>

#define LOTAnimationViewWidth 33
#define LOTAnimationViewHeight 33

@implementation UITabBar (Ex)

-(void)addLottieImage:(NSUInteger)index
              offsetY:(CGFloat)offsetY
           lottieName:(NSString *)lottieName {
    if ([NSThread isMainThread]) {
        [self addLottieImageInMainThread:index
                                 offsetY:offsetY
                              lottieName:lottieName];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self addLottieImageInMainThread:index
                                     offsetY:offsetY
                                  lottieName:lottieName];
        });
    }
}

-(void)addLottieImageInMainThread:(NSUInteger)index
                          offsetY:(CGFloat)offsetY
                       lottieName:(NSString *)lottieName{
    LOTAnimationView *lottieView = [LOTAnimationView animationNamed:lottieName];
    
    CGFloat totalW = [UIScreen mainScreen].bounds.size.width;
    CGFloat singleW = totalW / self.items.count;
    
    CGFloat x = ceilf(index * singleW + (singleW - LOTAnimationViewWidth) / 2.0);
    lottieView.frame = CGRectMake(x, offsetY, LOTAnimationViewWidth, LOTAnimationViewHeight);
    lottieView.userInteractionEnabled = NO;
    lottieView.contentMode = UIViewContentModeScaleAspectFit;
    lottieView.tag = 888 + index;
    
    [self addSubview:lottieView];
}

-(void)animationLottieImage:(NSInteger)index{
    [self stopAnimationAllLottieView];
    
    LOTAnimationView *lottieView = [self viewWithTag:888 + index];
    
    if (lottieView && [lottieView isKindOfClass:[LOTAnimationView class]]) {
        lottieView.animationProgress = 0;
        [lottieView play];
    }
}

-(void)stopAnimationAllLottieView {
    for (int i = 0; i < self.items.count; i++) {
        LOTAnimationView *lottieView = [self viewWithTag:888 + i];
        
        if (lottieView && [lottieView isKindOfClass:[LOTAnimationView class]]) {
            [lottieView stop];
        }
    }
}

@end
