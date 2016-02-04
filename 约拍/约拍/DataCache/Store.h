//
//  Store.h
//  约拍
//
//  Created by apple on 16/1/31.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "StoreModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface Store : NSManagedObject

+ (void)removeAllStores;
+ (NSArray *)loadAllStores;
+ (void)insertStore:(StoreModel *)store;
+ (Store *)getStoreByStoreId:(NSString *)storeId;

@end

NS_ASSUME_NONNULL_END

#import "Store+CoreDataProperties.h"
