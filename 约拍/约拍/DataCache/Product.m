//
//  Product.m
//  约拍
//
//  Created by apple on 16/1/25.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "Product.h"

@implementation Product

+ (void)insertProduct:(ProductModel *)product
{
    Product *productEntity = [NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:[AppDelegate sharedContext]];
    productEntity.storeId = product.storeId;
    productEntity.productId = product.productId;
    productEntity.productType = product.productType;
    productEntity.product = [NSKeyedArchiver archivedDataWithRootObject:product];
    [[AppDelegate sharedContext] save:nil];
}

//+ (NSArray *)getProductByProperty:(NSString *)property value:(NSString *)value
//{
//    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Product"];
//    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"productType == %@", value];
//    NSArray *result = [[AppDelegate sharedContext] executeFetchRequest:fetchRequest error:nil];
//    return result;
//}

+ (void)removeAllProducts
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Product"];
    NSArray *result = [[AppDelegate sharedContext] executeFetchRequest:fetchRequest error:nil];
    for (Product *product in result) {
        [[AppDelegate sharedContext] deleteObject:product];
    }
}

+ (NSArray *)getProductByStoreId:(NSString *)storeId
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Product"];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"storeId == %@", storeId];
    NSArray *result = [[AppDelegate sharedContext] executeFetchRequest:fetchRequest error:nil];
    return result;
}

+ (NSArray *)getProductByProductType:(NSString *)productType
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Product"];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"productType == %@", productType];
    NSArray *result = [[AppDelegate sharedContext] executeFetchRequest:fetchRequest error:nil];
    return result;
}

@end
