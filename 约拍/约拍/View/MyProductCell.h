//
//  MyProductCell.h
//  约拍
//
//  Created by apple on 16/2/18.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "BaseTableViewCell.h"

//@protocol BuyProductDelegate <NSObject>
//
//@optional
//- (void)buyProduct:(id)action;
//
//@end
@protocol PreviewDelegate <NSObject>

@optional
- (void)previewProduct:(id)action;

@end

@interface MyProductCell : BaseTableViewCell

@property (nonatomic, weak) id<PreviewDelegate> delegate;

@end
