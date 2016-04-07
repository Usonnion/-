//
//  CustomerModel.m
//  约拍
//
//  Created by apple on 16/3/23.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "CustomerModel.h"

@implementation CustomerModel

+ (CustomerModel *)fromDictionary:(NSDictionary *)dictionary
{
    CustomerModel *customer = [[CustomerModel alloc] init];
    customer.customerId = [dictionary stringForKey:@"CustomerId"];
    customer.customerName = [dictionary stringForKey:@"CustomerName"];
    customer.customerPhone = [dictionary stringForKey:@"PhoneNumber"];
    customer.customerAddress = [dictionary stringForKey:@"Address"];
    return customer;
}

- (NSDictionary *)toDictionary
{
    return @{@"CustomerId" : self.customerId,
             @"CustomerName" : self.customerName,
             @"PhoneNumber" : self.customerPhone,
             @"Address" : self.customerAddress};
}

@end
