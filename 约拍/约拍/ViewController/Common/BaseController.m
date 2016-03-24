//
//  BaseController.m
//  约拍
//
//  Created by apple on 16/3/20.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "BaseController.h"

@implementation BaseController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    //[[UIBarButtonItem alloc] initWithTitle:@”返回“style:UIBarButtonItemStyleBorderedtarget:nilaction:nil];
}

@end
