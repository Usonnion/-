//
//  ProductBLL.m
//  约拍
//
//  Created by apple on 16/3/16.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "ProductBLL.h"
#import "HTTPSessionManager.h"

@implementation ProductBLL

- (void)getAllProductsSuccess:(void (^)())success failure:(void (^)())failure
{
    NSString *urlString = @"/api/products";
    [[HTTPSessionManager sharedManager] GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableArray *products = [NSMutableArray new];
        for (NSDictionary *productDic in responseObject) {
            [products addObject:[ProductModel fromDictionary:productDic]];
        }
        
        if (products && products.count) {
            [[DiskCacheManager sharedManager] removeAllProducts];
            [[DiskCacheManager sharedManager] archiveProductInformation:products];
        }
        
        success();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure();
    }];
}

- (void)updateProduct:(ProductModel *)product success:(void (^)(NSDictionary *json))success failure:(void (^)())failure
{
    NSString *urlString = @"/api/products";
    [[HTTPSessionManager sharedManager] POST:urlString parameters:[product toDictionary] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure();
        
    }];
}

@end
