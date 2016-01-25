//
//  DiskCacheManager.m
//  约拍
//
//  Created by apple on 16/1/19.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "DiskCacheManager.h"
#import "Product.h"
#import "ProductModel.h"

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

- (void)removeAllProducts
{
    [Product removeAllProducts];
}

@end
