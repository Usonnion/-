//
//  CustomerCell.m
//  约拍
//
//  Created by apple on 16/3/26.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "CustomerCell.h"

@interface CustomerCell ()

@property (nonatomic, weak) IBOutlet UILabel *customerNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *customerPhoneLabel;
@property (nonatomic, weak) IBOutlet UILabel *customerAddressLabel;
@property (nonatomic, weak) IBOutlet UIImageView *selectedImageView;

@end

@implementation CustomerCell

- (void)awakeFromNib {
}

- (void)setCustomer:(CustomerModel *)customer
{
    self.customerNameLabel.text = customer.customerName;
    self.customerPhoneLabel.text = customer.customerPhone;
    self.customerAddressLabel.text = customer.customerAddress;
}

- (void)setCustomerSelected:(BOOL)selected
{
    self.selectedImageView.hidden = !selected;
}

@end
