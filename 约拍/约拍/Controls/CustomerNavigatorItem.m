//
//  CustomerNavigatorItem.m
//  约拍
//
//  Created by apple on 16/1/27.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "CustomerNavigatorItem.h"

@implementation CustomerNavigatorItem

+ (CustomerNavigatorItem *)customerNavigatorItemWithFrame:(CGRect)frame
{
//    NSBundle *bundle = [NSBundle bundleWithIdentifier:@"Controls"];
    UINib *nib = [UINib nibWithNibName:@"CustomerNavigatorItem" bundle:nil];
    CustomerNavigatorItem *customerNavigatorItem = [nib instantiateWithOwner:self options:nil][0];
    customerNavigatorItem.frame = frame;
    return customerNavigatorItem;
    
}

- (void)setOffset:(CGFloat)offset
{
    [self setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:offset]];
}

- (IBAction)backButtonPressed:(id)sender
{
    [self.delegate backButtonPressed];
}

@end
