//
//  CommentModel.m
//  约拍
//
//  Created by apple on 16/6/1.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel

- (NSDictionary *)toDictionary
{
    return @{@"Score": @(self.score),
             @"Comment": [NSString getEmptyIfNull:self.comment],
             @"Customer": [self.customer toDictionary],
             @"Product": [self.product toDictionary]};
}

@end
