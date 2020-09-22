//
//  MVPanGestureRecognizer.h
//  Videos
//
//  Created by 胡学礼 on 2020/9/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, MVPanGestureRecognizerDirection) {
    MVPanGestureRecognizerDirectionVertical,
    MVPanGestureRecognizerDirectionHorizontal
};

@interface MVPanGestureRecognizer : UIPanGestureRecognizer
@property (nonatomic, assign) MVPanGestureRecognizerDirection direction;

@end

NS_ASSUME_NONNULL_END
