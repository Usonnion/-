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

- (void)getAllStoresSuccess:(void (^)())success failure:(void (^)())failure
{
    NSString *urlString = @"/api/store";
    [[HTTPSessionManager sharedManager] GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableArray *stores = [NSMutableArray new];
        for (NSDictionary *storeDic in responseObject) {
            [stores addObject:[StoreModel fromDictionary:storeDic]];
        }
        
        if (stores && stores.count) {
            [[DiskCacheManager sharedManager] removeAllStores];
            [[DiskCacheManager sharedManager] archiveStores:stores];
        }
        
        success();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure();
    }];
}

- (void)getStoreByInvivationId:(NSString *)invivationId success:(void (^)(NSDictionary *json))success failure:(void (^)())failure
{
    NSString *urlString = @"/api/store";
    [[HTTPSessionManager sharedManager] PUT:urlString parameters:@{@"InvitationCode":invivationId} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure();
    }];
}

- (void)updateStore:(StoreModel *)store success:(void (^)(NSDictionary *json))success failure:(void (^)())failure
{
    NSString *urlString = @"/api/store";
    [[HTTPSessionManager sharedManager] POST:urlString parameters:[store toDictionary] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure();
    }];
}

@end
