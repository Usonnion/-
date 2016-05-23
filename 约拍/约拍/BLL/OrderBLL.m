//
//  OrderBLL.m
//  约拍
//
//  Created by apple on 16/3/29.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "OrderBLL.h"
#import "HTTPSessionManager.h"

@implementation OrderBLL

- (void)createOrder:(OrderModel *)order success:(void (^)())success failure:(void (^)())failure
{
    NSString *urlString = @"/api/Order";
    [[HTTPSessionManager sharedManager] POST:urlString parameters:[order toDictionary] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure();
    }];
}

- (void)getAllOrdersSuccess:(void (^)(NSArray *result))success failure:(void (^)())failure
{
    NSString *urlString = @"/api/Order";
    [[HTTPSessionManager sharedManager] GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure();
    }];
}

- (void)getAllStoreOrdersSuccess:(void (^)(NSArray *result))success failure:(void (^)())failure
{
    NSString *urlString = @"/api/StoreOrder";
    [[HTTPSessionManager sharedManager] GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure();
    }];
}

- (void)updateOrderStatus:(OrderModel *)order Success:(void (^)())success failure:(void (^)())failure
{
//    NSLog(order.orderId);
    NSString *urlString = @"/api/StoreOrder";
    [[HTTPSessionManager sharedManager] PUT:urlString parameters:[order toDictionary] success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure();
    }];
}

@end
