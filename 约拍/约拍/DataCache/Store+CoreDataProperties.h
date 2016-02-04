//
//  Store+CoreDataProperties.h
//  约拍
//
//  Created by apple on 16/1/31.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Store.h"

NS_ASSUME_NONNULL_BEGIN

@interface Store (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *storeId;
@property (nullable, nonatomic, retain) NSData *store;

@end

NS_ASSUME_NONNULL_END
