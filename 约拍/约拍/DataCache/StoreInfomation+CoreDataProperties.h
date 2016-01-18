//
//  StoreInfomation+CoreDataProperties.h
//  约拍
//
//  Created by apple on 16/1/18.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "StoreInfomation.h"

NS_ASSUME_NONNULL_BEGIN

@interface StoreInfomation (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *stroeId;
@property (nullable, nonatomic, retain) NSString *storeName;
@property (nullable, nonatomic, retain) NSString *storeAddress;
@property (nullable, nonatomic, retain) NSData *stroreImage;
@property (nullable, nonatomic, retain) NSString *phoneNumber;
@property (nullable, nonatomic, retain) NSSet<Product *> *relationship;

@end

@interface StoreInfomation (CoreDataGeneratedAccessors)

- (void)addRelationshipObject:(Product *)value;
- (void)removeRelationshipObject:(Product *)value;
- (void)addRelationship:(NSSet<Product *> *)values;
- (void)removeRelationship:(NSSet<Product *> *)values;

@end

NS_ASSUME_NONNULL_END
