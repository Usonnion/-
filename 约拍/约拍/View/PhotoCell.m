//
//  PhotoCell.m
//  约拍
//
//  Created by apple on 16/1/14.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "PhotoCell.h"

@interface PhotoCell()

@property (nonatomic, weak) IBOutlet UIImageView *imageView;

@end

@implementation PhotoCell

- (void)setImage:(NSString *)imageURL
{
    NSURL *imageUrl = [NSURL URLWithString:imageURL];
    NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
    UIImage *image = [UIImage imageWithData:imageData];
    [self.imageView setImage:image];}

@end
