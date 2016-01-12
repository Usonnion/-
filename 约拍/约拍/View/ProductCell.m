//
//  ProductCollectionViewCell.m
//  约拍
//
//  Created by apple on 16/1/12.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "ProductCell.h"
#import "ActionModel.h"

@interface ProductCell()

@property (nonatomic, weak) IBOutlet UIImageView *imageView;

@end

@implementation ProductCell

- (void)setContentData:(id)contentModel
{
    ActionModel *actionModel = (ActionModel *)contentModel;
    NSURL *imageUrl = [NSURL URLWithString:actionModel.imageURL];
    NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
    UIImage *image = [UIImage imageWithData:imageData];
    [self.imageView setImage:image];
}


@end
