//
//  ImagePickHelper.m
//  约拍
//
//  Created by apple on 16/2/21.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "ImagePickHelper.h"

@implementation ImagePickHelper

+ (void)imagePickup:(UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate> *)viewController
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    __weak typeof(viewController) weakviewController = viewController;
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *imagePickcontroller = [[UIImagePickerController alloc] init];
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            imagePickcontroller.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        imagePickcontroller.delegate = weakviewController;
        imagePickcontroller.allowsEditing = NO;
        [weakviewController presentViewController:imagePickcontroller animated:YES completion:nil];
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"照片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *imagePickcontroller = [[UIImagePickerController alloc] init];
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            imagePickcontroller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        imagePickcontroller.delegate = weakviewController;
        imagePickcontroller.allowsEditing = NO;
        [weakviewController presentViewController:imagePickcontroller animated:YES completion:nil];
        
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [viewController presentViewController:alertController animated:YES completion:nil];
}

@end
