//
//  OrderCell.m
//  约拍
//
//  Created by apple on 16/3/24.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "OrderCell.h"
#import "UIImageView+WebCache.h"
#import "CommentViewController.h"

@interface OrderCell()

@property (nonatomic, assign) ActionType actionType;
@property (nonatomic, weak) IBOutlet UILabel *productDescriptionLabel;
@property (nonatomic, weak) IBOutlet UILabel *productPriceLabel;
@property (nonatomic, weak) IBOutlet UILabel *orderStatusLabel;
@property (nonatomic, weak) IBOutlet UIImageView *productImageView;
@property (nonatomic, weak) IBOutlet UIView *customerView;
@property (nonatomic, weak) IBOutlet UILabel *customerNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *customerPhoneLabel;
@property (nonatomic, weak) IBOutlet UILabel *expectedTimeLabel;
@property (nonatomic, weak) IBOutlet UILabel *customerAddressLabel;
@property (nonatomic, weak) IBOutlet UIButton *confirmButton;
@property (nonatomic, weak) IBOutlet UIButton *customerActionButton;

@end

@implementation OrderCell

- (void)awakeFromNib {
}

- (void)setProductItem:(ProductModel *)product
{
    self.productDescriptionLabel.text = product.productDescription;
    self.productPriceLabel.text = [NSString stringWithFormat:@"¥ %@", @(product.price)];
    [self.productImageView sd_setImageWithURL:[NSURL URLWithString:product.images.firstObject]];
}

- (void)setOrderStatus:(NSString *)status
{
    self.orderStatusLabel.text = [status orderStatus];
    self.confirmButton.hidden = ![status isEqualToString:@"NOTRECEIVED"];
    
    if ([status isEqualToString:@"WAITINGFORCOMMENTS"]) {
        [self.customerActionButton setTitle:@"评价" forState:UIControlStateNormal];
        self.actionType = ActionTypeWaitingForComments;
    } else {
        self.customerActionButton.hidden = YES;
    }
}

- (void)setIsCustomerOrder:(BOOL)isCustomerOrder
{
    _isCustomerOrder = isCustomerOrder;
    self.customerView.hidden = isCustomerOrder;
    self.customerActionButton.hidden = !isCustomerOrder;
}

- (void)setCustomerItem:(OrderModel *)order
{
    self.customerNameLabel.text = order.customer.customerName;
    self.customerPhoneLabel.text = order.customer.customerPhone;
    self.customerAddressLabel.text = order.customer.customerAddress;
    self.expectedTimeLabel.text = [NSString stringByDate:order.expectedTime];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)confirm:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(confirmOrderWithIndexPath:)]) {
        [self.delegate confirmOrderWithIndexPath:self.indexPath];
    }
}

- (IBAction)call:(id)sender
{
    [ContactHelper callTo:self.customerPhoneLabel.text name:self.customerNameLabel.text view:self.superViewController.view];
}

- (IBAction)message:(id)sender
{
    [ContactHelper messageTo:self.customerPhoneLabel.text viewcontroller:self.superViewController];
}

- (IBAction)action:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(customeAction:WithIndexPath:)]) {
        [self.delegate customeAction:self.actionType WithIndexPath:self.indexPath];
    }
}

@end
