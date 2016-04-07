//
//  CustomerBLL.m
//  约拍
//
//  Created by apple on 16/3/27.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "CustomerBLL.h"
#import "HTTPSessionManager.h"

@implementation CustomerBLL

- (void)getAllCustomers:(void (^)(NSArray *customers))success failure:(void (^)())failure
{
    NSString *urlString = @"/api/customer";
    [[HTTPSessionManager sharedManager] GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure();
    }];
}

- (void)updateCustomer:(CustomerModel *)customer success:(void (^)(NSDictionary *customerDic))success failure:(void (^)())failure
{
    NSString *urlString = @"/api/customer";
    [[HTTPSessionManager sharedManager] POST:urlString parameters:[customer toDictionary] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure();
    }];
}

@end
