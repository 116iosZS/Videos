//
//  MVVideoPlayer.h
//  Videos
//
//  Created by 胡学礼 on 2020/9/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, MVVideoPlayerStatus) {
    MVVideoPlayerStatusUnload,      // 未加载
    MVVideoPlayerStatusPrepared,    // 准备播放
    MVVideoPlayerStatusLoading,     // 加载中
    MVVideoPlayerStatusPlaying,     // 播放中
    MVVideoPlayerStatusPaused,      // 暂停
    MVVideoPlayerStatusEnded,       // 播放完成
    MVVideoPlayerStatusError        // 错误
};

@class MVVideoPlayer;
@protocol MVVideoPlayerDelegate <NSObject>
- (void)player:(MVVideoPlayer *)player statusChanged:(MVVideoPlayerStatus)status;

- (void)player:(MVVideoPlayer *)player currentTime:(float)currentTime totalTime:(float)totalTime progress:(float)progress;


@end

@interface MVVideoPlayer : NSObject

@property (nonatomic, weak) id<MVVideoPlayerDelegate>     delegate;

@property (nonatomic, assign) MVVideoPlayerStatus         status;

@property (nonatomic, assign) BOOL                          isPlaying;


- (void)playVideoWithView:(UIView *)playView url:(NSString *)url;

- (void)removeVideo;

- (void)pausePlay;

- (void)resumePlay;

- (void)resetPlay;

@end

NS_ASSUME_NONNULL_END
