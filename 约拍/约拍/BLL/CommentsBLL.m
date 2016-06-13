//
//  CommentsBLL.m
//  约拍
//
//  Created by apple on 16/6/2.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "CommentsBLL.h"
#import "HTTPSessionManager.h"

@implementation CommentsBLL

- (void)createdComment:(CommentModel *)comment success:(void(^)())success failure:(void(^)())failure
{
    NSString *urlString = @"/api/Comments";
    
    [[HTTPSessionManager sharedManager] POST:urlString parameters:[comment toDictionary] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure();
    }];
}

@end
