//
//  BadgeBLL.m
//  约拍
//
//  Created by apple on 16/4/18.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "BadgeBLL.h"
#import "HTTPSessionManager.h"

@implementation BadgeBLL

- (void)getBadgeSuccess:(void (^)())success failure:(void (^)())failure
{
    NSString *urlString = @"/api/badge";
    [[HTTPSessionManager sharedManager] GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [DiskCacheManager sharedManager].badgeCount = [(NSDictionary *)responseObject integerForKey:@"Count"];
        success();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure();
        
    }];
}

@end
