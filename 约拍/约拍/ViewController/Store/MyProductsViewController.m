//
//  MyProductsViewController.m
//  约拍
//
//  Created by apple on 16/2/18.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "MyProductsViewController.h"
#import "ProductModel.h"
#import "BaseTableViewCell.h"
#import "ProductManagerViewController.h"

@interface MyProductsViewController ()

@property (nonatomic, weak) IBOutlet UILabel *noProductsLabel;
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray <ProductModel *> *products;
@property (nonatomic, assign) NSInteger editProductIndex;

@end

@implementation MyProductsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"所有商品";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MyProductCell" bundle:nil] forCellReuseIdentifier:@"MyProductCell"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.products = [[DiskCacheManager sharedManager] getProductByStoreId:self.storeId];
    self.noProductsLabel.hidden = self.products.count;
    [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(nullable id)sender
{
    ProductManagerViewController *controller = segue.destinationViewController;
    controller.product = sender;
    controller.myProductsViewController = self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyProductCell"];
    [cell setContentData:self.products[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 196.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    self.editProductIndex = indexPath.row;
    [self performSegueWithIdentifier:@"ShowProductManagerSegue" sender:self.products[indexPath.row]];
}

#pragma mark - Actions

- (IBAction)addProductButtonPressed:(id)sender
{
    ProductModel *product = [[ProductModel alloc] init];
    product.storeId = self.storeId;
    NSMutableArray *mutableProducts = [self.products mutableCopy];
    [mutableProducts insertObject:product atIndex:0];
    self.editProductIndex = 0;
    self.products = mutableProducts;
    [self performSegueWithIdentifier:@"ShowProductManagerSegue" sender:product];
}

- (void)editProductSuccess:(ProductModel *)product
{
    NSMutableArray *mutableProducts = [self.products mutableCopy];
    [mutableProducts replaceObjectAtIndex:self.editProductIndex withObject:product];
    self.products = mutableProducts;
    [self.tableView reloadData];
    self.noProductsLabel.hidden = YES;
}

@end
