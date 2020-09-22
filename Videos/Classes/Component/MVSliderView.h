//
//  MVSliderView.h
//  Videos
//
//  Created by 胡学礼 on 2020/9/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GKSliderViewDelegate <NSObject>

@optional
- (void)sliderTouchBegan:(float)value;
- (void)sliderValueChanged:(float)value;
- (void)sliderTouchEnded:(float)value;
- (void)sliderTapped:(float)value;

@end


@interface MVSliderView : UIView

@property (nonatomic, weak) id<GKSliderViewDelegate> delegate;

@property (nonatomic, strong) UIColor *maximumTrackTintColor;

@property (nonatomic, strong) UIColor *minimumTrackTintColor;

@property (nonatomic, strong) UIColor *bufferTrackTintColor;

@property (nonatomic, strong) UIImage *maximumTrackImage;

@property (nonatomic, strong) UIImage *minimumTrackImage;

@property (nonatomic, strong) UIImage *bufferTrackImage;

@property (nonatomic, assign) float value;

@property (nonatomic, assign) float bufferValue;

@property (nonatomic, assign) BOOL allowTapped;

@property (nonatomic, assign) CGFloat sliderHeight;

@property (nonatomic, assign) BOOL isHideSliderBlock;

- (void)setBackgroundImage:(UIImage *)image forState:(UIControlState)state;
- (void)setThumbImage:(UIImage *)image forState:(UIControlState)state;

- (void)showLoading;
- (void)hideLoading;

- (void)showLineLoading;
- (void)hideLineLoading;
@end

@interface GKSliderButton : UIButton

- (void)showActivityAnim;
- (void)hideActivityAnim;

@end


@interface UIView (MVFrame)

@property (nonatomic, assign) CGFloat gk_top;
@property (nonatomic, assign) CGFloat gk_left;
@property (nonatomic, assign) CGFloat gk_right;
@property (nonatomic, assign) CGFloat gk_bottom;
@property (nonatomic, assign) CGFloat gk_width;
@property (nonatomic, assign) CGFloat gk_height;
@property (nonatomic, assign) CGFloat gk_centerX;
@property (nonatomic, assign) CGFloat gk_centerY;

@end
NS_ASSUME_NONNULL_END
