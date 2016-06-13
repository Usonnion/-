//
//  OrderCell.h
//  约拍
//
//  Created by apple on 16/3/24.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ActionType) {
    ActionTypeWaitingForComments,
    ActionTypeCompleted,
};

@protocol OrderDelegate <NSObject>

@optional
- (void)confirmOrderWithIndexPath:(NSIndexPath *)indexPath;
- (void)customeAction:(ActionType)actionType WithIndexPath:(NSIndexPath *)indexPath;

@end

@interface OrderCell : UITableViewCell

@property (nonatomic, assign) BOOL isCustomerOrder;

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, weak) id<OrderDelegate> delegate;
@property (nonatomic, weak) UIViewController<MFMessageComposeViewControllerDelegate> *superViewController;

- (void)setProductItem:(ProductModel *)product;
- (void)setOrderStatus:(NSString *)status;
- (void)setCustomerItem:(OrderModel *)order;

@end
