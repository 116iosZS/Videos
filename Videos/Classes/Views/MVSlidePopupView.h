//
//  MVSlidePopupView.h
//  Videos
//
//  Created by 胡学礼 on 2020/9/22.
//

#import "MVSlidePopupViewContentDelegate.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MVSlidePopupView : UIView <MVSlidePopupViewContentProtocol>

+ (instancetype)popupViewWithFrame:(CGRect)frame contentView:(UIView*)contentView;

- (instancetype)initWithFrame:(CGRect)frame contentView:(UIView*)contentView;

- (void)showFrom:(UIView *)fromView completion:(void (^)(void))completion;

- (void)dismiss;
@end

NS_ASSUME_NONNULL_END
