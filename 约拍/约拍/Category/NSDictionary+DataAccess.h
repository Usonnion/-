//
//  NSDictionary+DataAccess.h
//  约拍
//
//  Created by apple on 16/3/3.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (DataAccess)

- (NSString *)stringForKey:(NSString *)key;
- (double)doubleForKey:(NSString *)key;

@end
