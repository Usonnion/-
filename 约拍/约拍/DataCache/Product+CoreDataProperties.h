//
//  Product+CoreDataProperties.h
//  约拍
//
//  Created by apple on 16/1/25.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Product.h"

NS_ASSUME_NONNULL_BEGIN

@interface Product (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *storeId;
@property (nullable, nonatomic, retain) NSString *productId;
@property (nullable, nonatomic, retain) NSString *productType;
@property (nullable, nonatomic, retain) NSData *product;

@end

NS_ASSUME_NONNULL_END
