//
//  StroeDescription.h
//  约拍
//
//  Created by apple on 16/1/31.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreModel.h"

static CGFloat storeDescriptionHeight = 130.0;

@interface StoreDescription : UIView

@property (nonatomic, weak) UIViewController<MFMessageComposeViewControllerDelegate> *superViewController;
+ (StoreDescription *)StoreDescriptionWithStore:(StoreModel *)Store;

@end
