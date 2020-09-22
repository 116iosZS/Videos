//
//  MVVideoModel.m
//  Videos
//
//  Created by 胡学礼 on 2020/9/22.
//

#import "MVVideoModel.h"

@implementation MVVideoAuthorModel


@end

@implementation MVVideoModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"author" : [MVVideoAuthorModel class]};
}
@end
