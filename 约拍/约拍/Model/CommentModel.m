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
             @"Product": [self.product toDictionary],
             @"OrderId": self.orderId};
}

+ (CommentModel *)fromDictionary:(NSDictionary *)dictionary
{
    CommentModel *comment = [[CommentModel alloc] init];
    comment.commentId = [dictionary stringForKey:@"CommentId"];
    comment.customer = [CustomerModel fromDictionary:dictionary[@"Customer"]];
    comment.product = [ProductModel fromDictionary:dictionary[@"Product"]];
    comment.comment = [dictionary stringForKey:@"Comment"];
    comment.score = [dictionary integerForKey:@"Score"];
    comment.createdDate = [[dictionary stringForKey:@"CreatedTime"] toDate];
    return comment;
}

@end
