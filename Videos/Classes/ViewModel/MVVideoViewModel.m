//
//  MVVideoModel.m
//  Videos
//
//  Created by 胡学礼 on 2020/9/22.
//

#import "MVVideoModel.h"
#import "MVVideoViewModel.h"

@interface  MVVideoViewModel()

@end

@implementation MVVideoViewModel
- (void)refreshNewListWithSuccess:(void (^)(NSArray * _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure {
    
    NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"video" ofType:@"json"];
    
    NSData *jsonData = [NSData dataWithContentsOfFile:videoPath];
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
    
    NSArray *videoList = dic[@"data"][@"video_list"];
    
    NSMutableArray *array = [NSMutableArray new];
    for (NSDictionary *dict in videoList) {
        MVVideoModel *model = [MVVideoModel yy_modelWithDictionary:dict];
        [array addObject:model];
    }
    
    !success ? : success(array);
}

- (void)refreshMoreListWithSuccess:(void (^)(NSArray * _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure {
    NSArray* array = nil;
    !success ? : success(array);
    return;
}

@end
