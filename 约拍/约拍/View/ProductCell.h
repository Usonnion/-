//
//  ProductCollectionViewCell.h
//  约拍
//
//  Created by apple on 16/1/12.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BuyProductDelegate <NSObject>

@optional
- (void)buyProduct:(id)action;

@end

@interface ProductCell : UICollectionViewCell

@property (nonatomic, weak) id<BuyProductDelegate> delegate;
- (void)setContentData:(id)contentModel;

@end
