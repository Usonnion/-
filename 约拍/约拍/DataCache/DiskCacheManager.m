//
//  DiskCacheManager.m
//  约拍
//
//  Created by apple on 16/1/19.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "DiskCacheManager.h"
#import "Product.h"
#import "Store.h"
#import "Configuration.h"

@interface DiskCacheManager ()

@property (nonatomic, strong) NSDictionary *imageCache;

@end

@implementation DiskCacheManager

+ (DiskCacheManager *)sharedManager
{
    static dispatch_once_t onceToken;
    static DiskCacheManager *manager;
    dispatch_once(&onceToken, ^{
        manager = [[DiskCacheManager alloc] init];
    });
    
    return manager;
}

- (NSString *)getConfig:(NSString *)key;
{
    for (Configuration * config in self.configs) {
        if ([config.key isEqualToString:key]) {
            return config.value;
        }
    }
    return @"";
}

#pragma mark - Product

- (void)archiveProductInformation:(NSArray *)array
{
    for (ProductModel *product in array) {
        [Product insertProduct:product];
    }
}

- (NSArray *)getProductByProductType:(NSString *)productType
{
    NSArray *products = [Product getProductByProductType:productType];
    
    NSMutableArray *productList = [@[] mutableCopy];
    for (Product *product in products) {
        [productList addObject:[NSKeyedUnarchiver unarchiveObjectWithData:product.product]];
    }
    
    return productList;
}

- (ProductModel *)getProductByProductId:(NSString *)prodcutId
{
    Product *product = [Product getProductByProductId:prodcutId];
    if (product) {
        return [NSKeyedUnarchiver unarchiveObjectWithData:product.product];
    }
    
    return nil;
}

- (NSArray *)getProductByStoreId:(NSString *)storeId
{
    NSArray *products = [Product getProductByStoreId:storeId];
    
    NSMutableArray *productList = [@[] mutableCopy];
    for (Product *product in products) {
        [productList addObject:[NSKeyedUnarchiver unarchiveObjectWithData:product.product]];
    }
    
    return productList;
}

- (void)removeAllProducts
{
    [Product removeAllProducts];
}

- (void)updateProductInformation:(ProductModel *)product
{
    [Product updateProductInformation:product];
}

#pragma mark - Store

- (void)removeAllStores
{
    [Store removeAllStores];
}

- (NSArray *)loadAllStores
{
    NSMutableArray *storeModels = [@[] mutableCopy];
    NSArray *stores = [Store loadAllStores];
    for (Store *store in stores) {
        [storeModels addObject:[NSKeyedUnarchiver unarchiveObjectWithData:store.store]];
    }
    return storeModels;
}

- (void)archiveStores:(NSArray *)array
{
    for (StoreModel *store in array) {
        [Store archiveStores:store];
    }
}

- (void)archiveStore:(StoreModel *)store
{
    [Store updateStoreInformation:store];
}

- (StoreModel *)getStoreByStoreId:(NSString *)storeId
{
    Store *store = [Store getStoreByStoreId:storeId];
    if (store) {
        return [NSKeyedUnarchiver unarchiveObjectWithData:store.store];
    }
    
    return nil;
}

- (void)updateStoreInformation:(StoreModel *)store
{
    [Store updateStoreInformation:store];
}

- (void)setBadgeCount:(NSInteger)badgeCount
{
    _badgeCount = badgeCount;
    [UIApplication sharedApplication].applicationIconBadgeNumber = badgeCount;
}

@end
