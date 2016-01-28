//
//  DiskCacheManager.h
//  约拍
//
//  Created by apple on 16/1/19.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductModel.h"

@interface DiskCacheManager : NSObject

+ (DiskCacheManager *)sharedManager;

- (void)archiveProductInformation:(NSArray *)array;
- (void)removeAllProducts;
- (NSArray *)getProductByProductType:(NSString *)productType;
- (ProductModel *)getProductByProductId:(NSString *)prodcutId;

@end
