//
//  FileUploadBLL.h
//  约拍
//
//  Created by apple on 16/3/5.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileUploadBLL : NSString

- (void)uploadImage:(NSData *)imageData imageIndex:(NSInteger)index success:(void (^)(NSDictionary *json, NSInteger index))success failure:(void (^)())failure;

@end
