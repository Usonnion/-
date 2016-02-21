//
//  ProductManagerViewController.m
//  约拍
//
//  Created by apple on 16/2/18.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "ProductManagerViewController.h"
#import "ImageEdittingCell.h"
#import "ImagePickHelper.h"

@interface ProductManagerViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *collectionViewHeightConstraint;
@property (nonatomic, weak) IBOutlet UITextView *productDescriptionTextVIew;
@property (nonatomic, weak) IBOutlet UITextField *productPriceTexrField;

@property (nonatomic, strong) NSArray *images;

@end

@implementation ProductManagerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setContentData];
    [self setContentStyle];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ImageEdittingCell" bundle:nil] forCellWithReuseIdentifier:@"ImageEdittingCell"];
    self.images = @[[UIImage imageNamed:@"DefaultStore"]];
    [self.collectionView reloadData];
    
    UIBarButtonItem *completedBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(completeEditting)];
    self.navigationItem.rightBarButtonItem = completedBarButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageEdittingCell *imageEdittingCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageEdittingCell" forIndexPath:indexPath];
    [imageEdittingCell setImage:self.images[indexPath.row]];
    return imageEdittingCell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.images.count - 1) {
        [ImagePickHelper imagePickup:self];
    }
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo
{
    NSMutableArray *mutableImages = [self.images mutableCopy];
    NSRange range = NSMakeRange(0, 1);
    NSIndexSet *indexset = [NSIndexSet indexSetWithIndexesInRange:range];
    [mutableImages insertObjects:@[image] atIndexes:indexset];
    self.images = mutableImages;
    [self.collectionView reloadData];
    self.collectionViewHeightConstraint.constant = self.collectionView.contentSize.height + 10;
    [self.view layoutIfNeeded];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Private Methods

- (void)setContentStyle
{
    UIColor *color = separatorLineColor;
    self.productDescriptionTextVIew.layer.borderColor = color.CGColor;
    self.productDescriptionTextVIew.layer.borderWidth = 1;
    
    self.productPriceTexrField.layer.borderColor = color.CGColor;
    self.productPriceTexrField.layer.borderWidth = 1;
}

- (void)setContentData
{
    self.title = @"商品编辑";
    self.images = self.product.images;
    self.productDescriptionTextVIew.text = self.product.productDescription;
    self.productPriceTexrField.text = [NSString stringWithFormat:@"%@", self.product.price ? @(self.product.price) : @""];
}

- (void)completeEditting
{
    self.product.price = [self.productPriceTexrField.text doubleValue];
    self.product.productDescription = self.productDescriptionTextVIew.text;
    self.product.images = self.images;
    [self.myProductsViewController editProductSuccess:self.product];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
