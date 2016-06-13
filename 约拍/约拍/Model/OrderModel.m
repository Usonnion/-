//
//  OrderModel.m
//  约拍
//
//  Created by apple on 16/3/28.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "OrderModel.h"
#import "DiskCacheManager.h"

@implementation OrderModel

+ (OrderModel *)fromDictionary:(NSDictionary *)dictionary
{
    OrderModel *order = [[OrderModel alloc] init];
    order.orderId = [dictionary stringForKey:@"OrderId"];
    order.productId = [dictionary stringForKey:@"ProductId"];
    order.customerId = [dictionary stringForKey:@"CustomerId"];
    order.status = [dictionary stringForKey:@"Status"];
    order.expectedTime = [[dictionary stringForKey:@"ExpectedTime"] toDate];
    order.product = [[DiskCacheManager sharedManager] getProductByProductId:order.productId];
    order.customer = [CustomerModel fromDictionary:dictionary];
    return order;
}

- (NSDictionary *)toDictionary
{
    return @{@"OrderId" : [NSString getEmptyIfNull:self.orderId],
             @"ProductId" : [NSString getEmptyIfNull:self.productId],
             @"CustomerId" : [NSString getEmptyIfNull:self.customerId],
             @"Status" : [NSString getEmptyIfNull:self.status],
             @"ExpectedTime" : [NSString jsonByDate:self.expectedTime]};
}

@end
