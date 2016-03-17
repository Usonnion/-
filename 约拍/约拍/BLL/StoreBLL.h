//
//  StoreBLL.h
//  约拍
//
//  Created by apple on 16/3/3.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreBLL : NSObject

- (void)getAllStoresSuccess:(void (^)())success failue:(void (^)())failue;
- (void)getStoreByInvivationId:(NSString *)invivationId success:(void (^)(NSDictionary *json))success failure:(void (^)())failure;
- (void)updateStore:(StoreModel *)store success:(void (^)(NSDictionary *json))success failure:(void (^)())failure;

@end
