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
    store.storeId = [dictionary stringForKey:@"StoreId"];
    store.storeName = [dictionary stringForKey:@"StoreName"];
    store.storeAddress = [dictionary stringForKey:@"StoreAddress"];
    store.storeImage = [dictionary stringForKey:@"StoreImage"];
    store.phoneNumber = [dictionary stringForKey:@"PhoneNumber"];
    return store;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.storeId forKey:@"Store.StoreId"];
    [aCoder encodeObject:self.storeName forKey:@"Store.StoreName"];
    [aCoder encodeObject:self.storeAddress forKey:@"Store.StoreAddress"];
    [aCoder encodeObject:self.storeImage forKey:@"Store.StoreImage"];
    [aCoder encodeObject:self.phoneNumber forKey:@"Store.PhoneNumber"];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.storeId = [aDecoder decodeObjectForKey:@"Store.StoreId"];
        self.storeName = [aDecoder decodeObjectForKey:@"Store.StoreName"];
        self.storeAddress = [aDecoder decodeObjectForKey:@"Store.StoreAddress"];
        self.storeImage = [aDecoder decodeObjectForKey:@"Store.StoreImage"];
        self.phoneNumber = [aDecoder decodeObjectForKey:@"Store.PhoneNumber"];
    }
    return self;
}

- (NSDictionary *)toDictionary
{
    return @{@"StoreId" : self.storeId,
             @"StoreName" : self.storeName,
             @"StoreAddress" : self.storeAddress,
             @"StoreImage" : self.storeImage,
             @"PhoneNumber" : self.phoneNumber};
}

@end
