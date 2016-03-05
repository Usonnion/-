//
//  ImageEditingCell.h
//  约拍
//
//  Created by apple on 16/2/18.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageEdittingCell : UICollectionViewCell

@property (nonatomic, strong) UIView *snapshot;
@property (nonatomic, assign) BOOL moving;
@property (nonatomic, strong) UIImage *image;

@end
