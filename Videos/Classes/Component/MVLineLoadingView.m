//
//  MVLineLoadingView.m
//  Videos
//
//  Created by 胡学礼 on 2020/9/22.
//

#import "MVLineLoadingView.h"

#define MVLineLoadingDuration  0.75
#define MVLineLoadingLineColor [UIColor whiteColor]

@implementation MVLineLoadingView

+ (void)showLoadingInView:(UIView *)view withLineHeight:(CGFloat)lineHeight {
    MVLineLoadingView *loadingView = [[MVLineLoadingView alloc] initWithFrame:view.frame lineHeight:lineHeight];
    [view addSubview:loadingView];
    [loadingView startLoading];
}

+ (void)hideLoadingInView:(UIView *)view {
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subView in subviewsEnum) {
        if ([subView isKindOfClass:[MVLineLoadingView class]]) {
            MVLineLoadingView *loadingView = (MVLineLoadingView *)subView;
            [loadingView stopLoading];
            [loadingView removeFromSuperview];
        }
    }
}

- (instancetype)initWithFrame:(CGRect)frame lineHeight:(CGFloat)lineHeight {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = MVLineLoadingLineColor;
        
        self.center = CGPointMake(frame.size.width * 0.5f, frame.size.height * 0.5f);
        self.bounds = CGRectMake(0, 0, 1.0f, lineHeight);
    }
    return self;
}

- (void)startLoading {
    [self stopLoading];
    
    self.hidden = NO;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = MVLineLoadingDuration;
    animationGroup.beginTime = CACurrentMediaTime();
    animationGroup.repeatCount = MAXFLOAT;
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animation];
    scaleAnimation.keyPath = @"transform.scale.x";
    scaleAnimation.fromValue = @(1.0f);
    scaleAnimation.toValue = @(1.0f * self.superview.frame.size.width);
    
    CABasicAnimation *alphaAnimation = [CABasicAnimation animation];
    alphaAnimation.keyPath = @"opacity";
    alphaAnimation.fromValue = @(1.0f);
    alphaAnimation.toValue = @(0.5f);
    
    animationGroup.animations = @[scaleAnimation, alphaAnimation];
    [self.layer addAnimation:animationGroup forKey:nil];
}

- (void)stopLoading {
    [self.layer removeAllAnimations];
    self.hidden = YES;
}


@end
