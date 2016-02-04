//
//  Store.m
//  约拍
//
//  Created by apple on 16/1/31.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "Store.h"

@implementation Store

+ (void)insertStore:(StoreModel *)store
{
    Store *storeEntity = [NSEntityDescription insertNewObjectForEntityForName:@"Store" inManagedObjectContext:[AppDelegate sharedContext]];
    storeEntity.storeId = store.storeId;
    storeEntity.store = [NSKeyedArchiver archivedDataWithRootObject:store];
    [[AppDelegate sharedContext] save:nil];
}

+ (NSArray *)loadAllStores
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Store"];
    NSArray *result = [[AppDelegate sharedContext] executeFetchRequest:fetchRequest error:nil];
    return result;
}

+ (void)removeAllStores
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Store"];
    NSArray *result = [[AppDelegate sharedContext] executeFetchRequest:fetchRequest error:nil];
    for (Store *store in result) {
        [[AppDelegate sharedContext] deleteObject:store];
    }
}

+ (Store *)getStoreByStoreId:(NSString *)storeId
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Store"];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"storeId == %@", storeId];
    NSArray *result = [[AppDelegate sharedContext] executeFetchRequest:fetchRequest error:nil];
    return result.firstObject;
}

@end
