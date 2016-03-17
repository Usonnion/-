//
//  ProductModel.h
//  约拍
//
//  Created by apple on 16/1/24.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductModel : NSObject <NSCoding>

@property (nonatomic, strong) NSString *storeId;
@property (nonatomic, strong) NSString *productId;
@property (nonatomic, assign) double price;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSString *productType;
@property (nonatomic, strong) NSString *productDescription;
@property (nonatomic, strong) NSDate *updatedTime;

+ (ProductModel *)fromDictionary:(NSDictionary *)dictionary;

- (NSDictionary *)toDictionary;

@end
