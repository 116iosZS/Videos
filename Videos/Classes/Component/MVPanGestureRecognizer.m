//
//  MVPanGestureRecognizer.m
//  Videos
//
//  Created by 胡学礼 on 2020/9/22.
//

#import "MVPanGestureRecognizer.h"

CGFloat const static kDirectionPanThreshold = 5.0;

@interface MVPanGestureRecognizer()
@property (nonatomic, assign) BOOL drag;
@property (nonatomic, assign) int moveX;
@property (nonatomic, assign) int moveY;
@end

@implementation MVPanGestureRecognizer

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    if (self.state == UIGestureRecognizerStateFailed) return;
    CGPoint nowPoint = [[touches anyObject] locationInView:self.view];
    CGPoint prevPoint = [[touches anyObject] previousLocationInView:self.view];
    _moveX += prevPoint.x - nowPoint.x;
    _moveY += prevPoint.y - nowPoint.y;
    if (!_drag) {
        if (abs(_moveX) > kDirectionPanThreshold) {
            if (_direction == MVPanGestureRecognizerDirectionVertical) {
                self.state = UIGestureRecognizerStateFailed;
            }else {
                _drag = YES;
            }
        }else if (abs(_moveY) > kDirectionPanThreshold) {
            if (_direction == MVPanGestureRecognizerDirectionHorizontal) {
                self.state = UIGestureRecognizerStateFailed;
            }else {
                _drag = YES;
            }
        }
    }
}

- (void)reset {
    [super reset];
    _drag = NO;
    _moveX = 0;
    _moveY = 0;
}

@end
