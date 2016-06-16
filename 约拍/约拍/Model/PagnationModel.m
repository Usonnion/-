//
//  PagnationModel.m
//  约拍
//
//  Created by apple on 16/6/15.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "PagnationModel.h"

@implementation PagnationModel

- (NSDictionary *)toDictionary
{
    return @{@"Page": @(self.page)};
}

@end
