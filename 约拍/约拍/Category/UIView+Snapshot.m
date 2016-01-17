//
//  UIView+Snapshot.m
//  约拍
//
//  Created by apple on 16/1/17.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "UIView+Snapshot.h"

@implementation UIView (Snapshot)

- (UIImageView *)snapshot
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [[UIImageView alloc] initWithImage:img];
}

@end
