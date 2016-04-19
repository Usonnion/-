//
//  DiskCacheManager.h
//  约拍
//
//  Created by apple on 16/1/19.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductModel.h"
#import "StoreModel.h"

@interface DiskCacheManager : NSObject

@property (nonatomic, assign) NSInteger badgeCount;
@property (nonatomic, strong) NSString *invitationCode;

+ (DiskCacheManager *)sharedManager;

- (void)updateBadge;
- (void)archiveProductInformation:(NSArray *)array;
- (void)removeAllProducts;
- (NSArray *)getProductByStoreId:(NSString *)storeId;
- (NSArray *)getProductByProductType:(NSString *)productType;
- (ProductModel *)getProductByProductId:(NSString *)prodcutId;
- (void)updateProductInformation:(ProductModel *)product;

- (void)removeAllStores;
- (NSArray *)loadAllStores;
- (void)archiveStores:(NSArray *)array;
- (StoreModel *)getStoreByStoreId:(NSString *)storeId;
- (void)updateStoreInformation:(StoreModel *)store;

@end
