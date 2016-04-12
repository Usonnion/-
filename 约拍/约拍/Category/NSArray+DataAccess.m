//
//  NSArray+DataAccess.m
//  约拍
//
//  Created by apple on 16/4/9.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "NSArray+DataAccess.h"

@implementation NSArray(DataAccess)

- (id)objectByIndex:(NSInteger)index
{
    if (index >= 0 && index < self.count) {
        return self[index];
    }
    return nil;
}

@end
