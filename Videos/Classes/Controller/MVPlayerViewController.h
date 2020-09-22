//
//  MVPlayerViewController.h
//  Videos
//
//  Created by 胡学礼 on 2020/9/22.
//

#import "MVVideoView.h"

#import <UIKit/UIKit.h>
@class MVVideoModel;
NS_ASSUME_NONNULL_BEGIN

@interface MVPlayerViewController : UIViewController

@property (nonatomic, strong) MVVideoView *videoView;


@end

NS_ASSUME_NONNULL_END
