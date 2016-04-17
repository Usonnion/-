//
//  ImageEditingCell.m
//  约拍
//
//  Created by apple on 16/2/18.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "ImageEdittingCell.h"
#import "UIImageView+WebCache.h"

@interface ImageEdittingCell()

@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UIButton *deleteButton;

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

- (void)setMoving:(BOOL)moving
{
    _moving = moving;
    CGFloat alpha = moving ? 0 : 1;
    self.imageView.alpha = alpha;
}

- (UIView *)snapshot
{
    UIView *snapshot = [self snapshotViewAfterScreenUpdates:true];
    snapshot.layer.masksToBounds = YES;
    snapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0);
    snapshot.layer.shadowRadius = 5.0;
    snapshot.layer.shadowOpacity = 0.4;
    return snapshot;
}

- (void)setImageUrl:(NSString *)imagrUrl
{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imagrUrl]];
}

- (void)setShowDelete:(BOOL)showDelete
{
    _showDelete = showDelete;
    self.deleteButton.hidden = !showDelete;
}

- (IBAction)delete:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(deleteImageWithPath:)]) {
        [self.delegate deleteImageWithPath:_indexPath.row];
    }
}

@end
