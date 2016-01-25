//
//  PhotoCell.m
//  约拍
//
//  Created by apple on 16/1/14.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "PhotoCell.h"
#import "UIImageView+WebCache.h"

@interface PhotoCell()

@property (nonatomic, weak) IBOutlet UIImageView *imageView;

@end

@implementation PhotoCell

- (void)setImage:(NSString *)imageURL
{
    NSURL *imageUrl = [NSURL URLWithString:imageURL];
    [self.imageView sd_setImageWithURL:imageUrl];}

@end
