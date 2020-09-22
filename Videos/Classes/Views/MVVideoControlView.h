//
//  MVVideoControlView.h
//  Videos
//
//  Created by 胡学礼 on 2020/9/22.
//

#import "MVSliderView.h"
#import "MVVideoModel.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class MVVideoControlView;

@protocol MVVideoControlViewDelegate <NSObject>

- (void)controlViewDidClickSelf:(MVVideoControlView *)controlView;

- (void)controlViewDidClickIcon:(MVVideoControlView *)controlView;

- (void)controlViewDidClickPriase:(MVVideoControlView *)controlView;

- (void)controlViewDidClickComment:(MVVideoControlView *)controlView;

- (void)controlViewDidClickShare:(MVVideoControlView *)controlView;

- (void)controlView:(MVVideoControlView *)controlView touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;

@end


@interface MVVideoControlView : UIView

@property (nonatomic, weak) id<MVVideoControlViewDelegate> delegate;

@property (nonatomic, strong) UIImageView           *coverImgView;

@property (nonatomic, strong) MVVideoModel           *model;

@property (nonatomic, strong) MVSliderView          *sliderView;

- (void)setProgress:(float)progress;

- (void)startLoading;
- (void)stopLoading;

- (void)showPlayBtn;
- (void)hidePlayBtn;

- (void)showLikeAnimation;
- (void)showUnLikeAnimation;
@end

NS_ASSUME_NONNULL_END
