//
//  OrderModel.h
//  约拍
//
//  Created by apple on 16/3/28.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomerModel.h"

@interface OrderModel : NSObject

@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *customerId;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSDate *expectedTime;
@property (nonatomic, strong) ProductModel *product;
@property (nonatomic, strong) CustomerModel *customer;

+ (OrderModel *)fromDictionary:(NSDictionary *)dictionary;
- (NSDictionary *)toDictionary;

@end
