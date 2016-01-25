//
//  StoreModel.m
//  约拍
//
//  Created by apple on 16/1/24.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "StoreModel.h"

@implementation StoreModel

+ (StoreModel *)fromDictionary:(NSDictionary *)dictionary
{
    StoreModel *store = [[StoreModel alloc] init];
    store.storeId = [dictionary objectForKey:@"StoreId"];
    store.storeName = [dictionary objectForKey:@"StoreName"];
    store.storeAddress = [dictionary objectForKey:@"StoreAddress"];
    store.storeImage = [dictionary objectForKey:@"StoreImage"];
    store.phoneNumber = [dictionary objectForKey:@"PhoneNumber"];
    return store;
}

@end
