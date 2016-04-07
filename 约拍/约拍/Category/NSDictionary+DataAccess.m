//
//  NSDictionary+DataAccess.m
//  约拍
//
//  Created by apple on 16/3/3.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "NSDictionary+DataAccess.h"

@implementation NSDictionary (DataAccess)

- (NSString *)stringForKey:(NSString *)key
{
    NSString *value = [self objectForKey:key];
    if ([value isKindOfClass:[NSNull class]] || !value) {
        return @"";
    }
    return value;
}

- (double)doubleForKey:(NSString *)key
{
    NSNumber *value = [self objectForKey:key];
    return value.doubleValue;
}

- (NSInteger)integerForKey:(NSString *)key
{
    return [[self objectForKey:key] integerValue];
}

@end
