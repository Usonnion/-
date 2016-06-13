//
//  CommentModel.h
//  约拍
//
//  Created by apple on 16/6/1.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomerModel.h"

@interface CommentModel : NSObject

@property (nonatomic, strong) NSString *commentId;
@property (nonatomic, assign) NSInteger score;
@property (nonatomic, strong) NSString *comment;
@property (nonatomic, strong) NSDate *createdDate;
@property (nonatomic, strong) CustomerModel *customer;
@property (nonatomic, strong) ProductModel *product;

- (NSDictionary *)toDictionary;

@end
