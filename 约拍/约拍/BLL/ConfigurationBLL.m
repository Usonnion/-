//
//  ConfigurationBLL.m
//  约拍
//
//  Created by apple on 16/4/24.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "ConfigurationBLL.h"
#import "HTTPSessionManager.h"
#import "RotationModel.h"
#import "ProductTypeModel.h"

@implementation ConfigurationBLL

- (void)getConfigurationSuccess:(void (^)())success failure:(void (^)())failure
{
    NSString *urlString = @"/api/configuration";
    
    [[HTTPSessionManager sharedManager] GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            [DiskCacheManager sharedManager].productTypes = [ProductTypeModel fromArray:[(NSDictionary *)responseObject objectForKey:@"productType"]];
            [DiskCacheManager sharedManager].rotations = [RotationModel fromArray:[(NSDictionary *)responseObject objectForKey:@"rotations"]];
        }
        success();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [DiskCacheManager sharedManager].productTypes = [ProductTypeModel fromArray:nil];
        [DiskCacheManager sharedManager].rotations = [RotationModel fromArray:nil];
        failure();
    }];
}

@end
