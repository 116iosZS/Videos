//
//  MVLineLoadingView.h
//  Videos
//
//  Created by 胡学礼 on 2020/9/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MVLineLoadingView : UIView

+ (void)showLoadingInView:(UIView *)view withLineHeight:(CGFloat)lineHeight;

+ (void)hideLoadingInView:(UIView *)view;
@end

NS_ASSUME_NONNULL_END
