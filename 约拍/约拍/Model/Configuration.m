//
//  Configuration.m
//  约拍
//
//  Created by apple on 16/7/31.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "Configuration.h"

@implementation Configuration

+ (NSArray *)fromArray:(NSDictionary *)jsonArray
{
    if (jsonArray && jsonArray.count) {
        NSMutableArray *configs = [NSMutableArray new];
        for (NSDictionary *json in jsonArray) {
            Configuration *config = [[Configuration alloc] init];
            config.key = [json stringForKey:@"Key"];
            config.value = [json stringForKey:@"Value"];
            [configs addObject:config];
        }
        return configs;
    }
    
    return [Configuration getDefaultsConfigs];
}

+ (NSArray *)getDefaultsConfigs
{
    Configuration *config = [[Configuration alloc] init];
    config.key = @"phone";
    config.value = @"18751634551";
    return @[config];
}

@end
