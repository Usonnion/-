//
//  StoreCell.m
//  约拍
//
//  Created by apple on 16/1/31.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "StoreCell.h"
#import "UIImageView+WebCache.h"

@interface StoreCell ()

@property (nonatomic, weak) IBOutlet UILabel *storeNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *storeAddressLabel;
@property (nonatomic, weak) IBOutlet UIImageView *storeImage;

@end

@implementation StoreCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setContentWithStore:(StoreModel *)store
{
    self.storeNameLabel.text = store.storeName;
    self.storeAddressLabel.text = store.storeAddress;
    [self.storeImage sd_setImageWithURL:[NSURL URLWithString:store.storeImage]];
}

@end
