//
//  Product.h
//  约拍
//
//  Created by apple on 16/1/25.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ProductModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface Product : NSManagedObject

+ (void)insertProduct:(ProductModel *)product;
//+ (NSArray *)getProductByProperty:(NSString *)property value:(NSString *)value;
+ (void)removeAllProducts;
+ (NSArray *)getProductByStoreId:(NSString *)storeId;
+ (NSArray *)getProductByProductType:(NSString *)productType;
+ (Product *)getProductByProductId:(NSString *)productId;

@end

NS_ASSUME_NONNULL_END

#import "Product+CoreDataProperties.h"
