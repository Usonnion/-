//
//  ImagePickHelper.h
//  约拍
//
//  Created by apple on 16/2/21.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImagePickHelper : UICollectionViewCell

+ (void)imagePickup:(UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate> *)viewController allowsEditing:(BOOL)allowsEditing;

@end
