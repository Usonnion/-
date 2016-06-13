//
//  CommentsBLL.h
//  约拍
//
//  Created by apple on 16/6/2.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommentModel.h"

@interface CommentsBLL : NSObject

- (void)createdComment:(CommentModel *)comment success:(void(^)())success failure:(void(^)())failure;

@end
