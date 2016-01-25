//
//  StoreModel.h
//  约拍
//
//  Created by apple on 16/1/24.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreModel : NSObject

@property (nonatomic, strong) NSString *storeId;
@property (nonatomic, strong) NSString *storeName;
@property (nonatomic, strong) NSString *storeAddress;
@property (nonatomic, strong) NSString *storeImage;
@property (nonatomic, strong) NSString *phoneNumber;

+ (StoreModel *)fromDictionary:(NSDictionary *)dictionary;

@end
