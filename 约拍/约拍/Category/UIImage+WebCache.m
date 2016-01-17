//
//  UIImage+WebCache.m
//  约拍
//
//  Created by apple on 16/1/17.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "UIImage+WebCache.h"

@implementation UIImage (WebCache)

+ (UIImage *)imageWithUrl:(NSString *)url
{
    NSURL *imageUrl = [NSURL URLWithString:url];
    NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
    UIImage *image = [UIImage imageWithData:imageData];
    return image;
}

@end
