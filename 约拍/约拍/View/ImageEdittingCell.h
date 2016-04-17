//
//  ImageEditingCell.h
//  约拍
//
//  Created by apple on 16/2/18.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

@protocol ImageEditCellDelegate <NSObject>

- (void)deleteImageWithPath:(NSInteger)index;

@end

#import <UIKit/UIKit.h>

@interface ImageEdittingCell : UICollectionViewCell

@property (nonatomic, weak) id<ImageEditCellDelegate> delegate;

@property (nonatomic, strong) UIView *snapshot;
@property (nonatomic, assign) BOOL moving;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, assign) BOOL showDelete;

- (void)setImageUrl:(NSString *)imagrUrl;

@end
