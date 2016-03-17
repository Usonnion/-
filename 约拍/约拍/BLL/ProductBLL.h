//
//  ProductBLL.h
//  约拍
//
//  Created by apple on 16/3/16.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductBLL : NSString

- (void)getAllProductsSuccess:(void (^)())success failue:(void (^)())failue;
- (void)updateProduct:(ProductModel *)product success:(void (^)(NSDictionary *json))success failure:(void (^)())failure;

@end
