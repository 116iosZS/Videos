//
//  MVVideoViewModel.h
//  Videos
//
//  Created by 胡学礼 on 2020/9/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MVVideoViewModel : NSObject
@property (nonatomic, assign) BOOL  has_more;

- (void)refreshNewListWithSuccess:(void(^)(NSArray *list))success
                            failure:(void(^)(NSError *error))failure;

- (void)refreshMoreListWithSuccess:(void(^)(NSArray *list))success
                            failure:(void(^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
