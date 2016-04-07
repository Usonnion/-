//
//  CustomerModel.h
//  约拍
//
//  Created by apple on 16/3/23.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomerModel : NSObject

@property (nonatomic, strong) NSString *customerId;
@property (nonatomic, strong) NSString *customerName;
@property (nonatomic, strong) NSString *customerPhone;
@property (nonatomic, strong) NSString *customerAddress;

+ (CustomerModel *)fromDictionary:(NSDictionary *)dictionary;
- (NSDictionary *)toDictionary;

@end
