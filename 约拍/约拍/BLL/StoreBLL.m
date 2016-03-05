//
//  StoreBLL.m
//  约拍
//
//  Created by apple on 16/3/3.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "StoreBLL.h"
#import "HTTPSessionManager.h"

@implementation StoreBLL

- (void)getAllStores
{
    NSString *urlString = [NSString stringWithFormat: @"/api/store?token=%@", [[HTTPSessionManager sharedManager] token]];
    [[HTTPSessionManager sharedManager] GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}

- (void)

@end
