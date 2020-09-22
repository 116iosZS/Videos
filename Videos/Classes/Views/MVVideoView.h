//
//  MVVideoView.h
//  Videos
//
//  Created by 胡学礼 on 2020/9/22.
//

#import "MVVideoControlView.h"
#import "MVVideoViewModel.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class MVVideoView, MVVideoModel;
@protocol MVVideoViewDelegate <NSObject>

@optional

- (void)videoView:(MVVideoView *)videoView didClickIcon:(MVVideoModel *)videoModel;
- (void)videoView:(MVVideoView *)videoView didClickPraise:(MVVideoModel *)videoModel;
- (void)videoView:(MVVideoView *)videoView didClickComment:(MVVideoModel *)videoModel;
- (void)videoView:(MVVideoView *)videoView didClickShare:(MVVideoModel *)videoModel;
- (void)videoView:(MVVideoView *)videoView didScrollIsCritical:(BOOL)isCritical;
- (void)videoView:(MVVideoView *)videoView didPanWithDistance:(CGFloat)distance isEnd:(BOOL)isEnd;

@end

@interface MVVideoView : UIView

@property (nonatomic, weak) id<MVVideoViewDelegate>     delegate;

@property (nonatomic, strong) MVVideoViewModel          *viewModel;

@property (nonatomic, strong) MVVideoControlView        *currentPlayView;

@property (nonatomic, assign) NSInteger                 currentPlayIndex;

- (instancetype)initWithVC:(UIViewController *)vc;

- (void)setModels:(NSArray *)models index:(NSInteger)index;

- (void)pause;
- (void)resume;
- (void)destoryPlayer;
@end

NS_ASSUME_NONNULL_END
