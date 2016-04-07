//
//  CustomerBLL.h
//  约拍
//
//  Created by apple on 16/3/27.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomerModel.h"

@interface CustomerBLL : NSObject

- (void)getAllCustomers:(void (^)(NSArray *customers))success failure:(void (^)())failure;
- (void)updateCustomer:(CustomerModel *)customer success:(void (^)(NSDictionary *customerDic))success failure:(void (^)())failure;

@end
