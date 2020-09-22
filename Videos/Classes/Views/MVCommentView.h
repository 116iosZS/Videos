//
//  MVCommentView.h
//  Videos
//
//  Created by 胡学礼 on 2020/9/22.
//

#import "MVCommentViewModel.h"
#import "MVSlidePopupViewContentDelegate.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MVCommentView : UIView
@property (nonatomic, weak) id<MVSlidePopupViewContentProtocol> delegate;
- (instancetype)initWithViewModel:(MVCommentViewModel*)viewmodel;
- (void)requestData;
@end

NS_ASSUME_NONNULL_END
