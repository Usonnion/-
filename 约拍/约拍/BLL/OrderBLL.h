//
//  OrderBLL.h
//  约拍
//
//  Created by apple on 16/3/29.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderModel.h"

@interface OrderBLL : NSObject

- (void)createOrder:(OrderModel *)order success:(void (^)())success failure:(void (^)())failure;
- (void)getAllOrdersSuccess:(void (^)(NSArray *result))success failure:(void (^)())failure;
- (void)getAllStoreOrdersSuccess:(void (^)(NSArray *result))success failure:(void (^)())failure;
- (void)updateOrderStatus:(OrderModel *)order Success:(void (^)())success failure:(void (^)())failure;

@end
