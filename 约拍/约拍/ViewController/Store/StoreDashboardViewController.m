//
//  StoreDashboardViewController.m
//  约拍
//
//  Created by apple on 16/4/12.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "StoreDashboardViewController.h"
#import "StoreManagerViewController.h"
#import "MyProductsViewController.h"

@interface StoreDashboardViewController ()

@property (nonatomic, weak) IBOutlet UIButton *storeButton;
@property (nonatomic, weak) IBOutlet UIButton *productButton;
@property (nonatomic, weak) IBOutlet UIButton *orderButton;
@property (nonatomic, weak) IBOutlet UIButton *exitButton;
@property (nonatomic, weak) IBOutlet UILabel *badgeLabel;

@end

@implementation StoreDashboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setContentStyle];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setContentStyle
{
    self.storeButton.layer.borderWidth = 2.0;
    self.storeButton.layer.borderColor = [UIColor brownColor].CGColor;
    self.storeButton.layer.cornerRadius = 8.0;
    
    self.productButton.layer.borderWidth = 2.0;
    self.productButton.layer.borderColor = [UIColor brownColor].CGColor;
    self.productButton.layer.cornerRadius = 8.0;
    
    self.orderButton.layer.borderWidth = 2.0;
    self.orderButton.layer.borderColor = [UIColor brownColor].CGColor;
    self.orderButton.layer.cornerRadius = 8.0;
    
    self.exitButton.layer.borderWidth = 2.0;
    self.exitButton.layer.borderColor = [UIColor brownColor].CGColor;
    self.exitButton.layer.cornerRadius = 8.0;
    
    [self.badgeLabel sizeToFit];
    self.badgeLabel.center = CGPointMake(self.productButton.frame.origin.x + self.productButton.frame.size.width, self.productButton.frame.origin.y);
    self.badgeLabel.layer.cornerRadius = self.badgeLabel.frame.size.height / 2;
}

#pragma mark -Actions

- (IBAction)exit:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *viewController = segue.destinationViewController;
    if ([viewController isKindOfClass:[StoreManagerViewController class]]) {
        ((StoreManagerViewController *)viewController).action = self.action;
    } else if ([viewController isKindOfClass:[MyProductsViewController class]]) {
        ((MyProductsViewController *)viewController).storeId = self.action.storeId;
    }
}

@end
