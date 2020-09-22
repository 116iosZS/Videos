//
//  MVLikeView.h
//  Videos
//
//  Created by 胡学礼 on 2020/9/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MVLikeView : UIView
@property (nonatomic, assign) BOOL      isLike;

- (void)startAnimationWithIsLike:(BOOL)isLike;

- (void)setupLikeState:(BOOL)isLike;

- (void)setupLikeCount:(NSString *)count;

@end

NS_ASSUME_NONNULL_END
