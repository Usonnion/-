//
//  StroeDescription.m
//  约拍
//
//  Created by apple on 16/1/31.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "StoreDescription.h"

@interface StoreDescription()

@property (nonatomic, weak) IBOutlet UILabel *storeDescriptionLabel;
@property (nonatomic, weak) IBOutlet UILabel *storeAddressLabel;
@property (nonatomic, weak) IBOutlet UILabel *storePhoneLabel;

@end

@implementation StoreDescription

+ (StoreDescription *)StoreDescriptionWithStore:(StoreModel *)store
{
    UINib *nib = [UINib nibWithNibName:@"StoreDescription" bundle:nil];
    StoreDescription *stroeDescription = [nib instantiateWithOwner:self options:nil][0];
    [stroeDescription setContentWithStore:store];
    return stroeDescription;
}

- (void)setContentWithStore:(StoreModel *)store
{
    self.storeDescriptionLabel.text = store.storeName;
    self.storeAddressLabel.text = store.storeAddress;
    self.storePhoneLabel.text = store.phoneNumber;
}

- (IBAction)call:(id)sender
{
    [ContactHelper callTo:self.storePhoneLabel.text name:self.storeDescriptionLabel.text view:self.superViewController.view];
}

- (IBAction)message:(id)sender
{
    [ContactHelper messageTo:self.storePhoneLabel.text viewcontroller:self.superViewController];
}

@end
