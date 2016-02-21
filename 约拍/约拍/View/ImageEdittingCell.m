//
//  ImageEditingCell.m
//  约拍
//
//  Created by apple on 16/2/18.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "ImageEdittingCell.h"

@interface ImageEdittingCell()

@property (nonatomic, weak) IBOutlet UIImageView *imageView;

@end

@implementation ImageEdittingCell

- (void)awakeFromNib
{

}

- (void)setImage:(UIImage *)image
{
    _image = image;
    [self.imageView setImage:image];
}

@end
