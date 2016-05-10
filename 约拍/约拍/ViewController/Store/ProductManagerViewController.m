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
#import "DNImagePickerController.h"
#import "DNAsset.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "DNImageFlowViewController.h"
#import "FileUploadBLL.h"
#import "HTTPSessionManager.h"
#import "ProductBLL.h"
#import "ProductTypeModel.h"

@interface ProductManagerViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate, DNImagePickerControllerDelegate, UITextFieldDelegate, ImageEditCellDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *collectionViewHeightConstraint;
@property (nonatomic, weak) IBOutlet UITextView *productDescriptionTextVIew;
@property (nonatomic, weak) IBOutlet UITextField *productPriceTexrField;
@property (nonatomic, weak) IBOutlet UILabel *productTypeLabel;
@property (nonatomic, weak) IBOutlet UIPickerView *prickView;
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet UIView *placeHolderView;

@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSArray *productTypes;
@property (nonatomic, strong) NSIndexPath *sourceIndex;
@property (nonatomic, strong) UIView *snapshot;
@property (nonatomic, assign) float moving;
@property (nonatomic, assign) BOOL isFullImage;
@property (nonatomic, strong) NSMutableArray *imageURLs;
@property (nonatomic, assign) NSInteger successCount;
@property (nonatomic, assign) NSInteger failedCount;
@property (nonatomic, strong) FileUploadBLL *fileUploadBLLInstance;

@end

@implementation ProductManagerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setContentData];
    [self setContentStyle];
    
    self.fileUploadBLLInstance = [[FileUploadBLL alloc] init];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ImageEdittingCell" bundle:nil] forCellWithReuseIdentifier:@"ImageEdittingCell"];
    
    UIBarButtonItem *completedBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(completeEditting)];
    self.navigationItem.rightBarButtonItem = completedBarButtonItem;
    
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [self.collectionView addGestureRecognizer:longPressGesture];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditting:)];
    [self.placeHolderView addGestureRecognizer:tapGestureRecognizer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
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
    id cellData = self.images[indexPath.row];
    imageEdittingCell.indexPath = indexPath;
    imageEdittingCell.delegate = self;
    imageEdittingCell.showDelete = indexPath.row != self.images.count - 1;
    if ([cellData isKindOfClass:[UIImage class]]) {
        [imageEdittingCell setImage:self.images[indexPath.row]];
    } else if ([cellData isKindOfClass:[NSString class]]) {
        [imageEdittingCell setImageUrl:cellData];
    } else if ([cellData isKindOfClass:[DNAsset class]]) {
        DNAsset *dnasset = cellData;
        
        ALAssetsLibrary *lib = [ALAssetsLibrary new];
        __block ImageEdittingCell *blockCell = imageEdittingCell;
        [lib assetForURL:dnasset.url resultBlock:^(ALAsset *asset){
            if (asset) {
                UIImage *image = [UIImage imageWithCGImage:asset.thumbnail];
                [blockCell setImage:image];
            } else {
                // On iOS 8.1 [library assetForUrl] Photo Streams always returns nil. Try to obtain it in an alternative way
                [lib enumerateGroupsWithTypes:ALAssetsGroupPhotoStream
                                   usingBlock:^(ALAssetsGroup *group, BOOL *stop)
                 {
                     [group enumerateAssetsWithOptions:NSEnumerationReverse
                                            usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                                                
                                                if([[result valueForProperty:ALAssetPropertyAssetURL] isEqual:dnasset.url])
                                                {
                                                    UIImage *image = [UIImage imageWithCGImage:asset.thumbnail];
                                                    [blockCell setImage:image];
                                                    *stop = YES;
                                                }
                                            }];
                 }
                                 failureBlock:^(NSError *error)
                 {
                     UIImage *image = [UIImage imageWithCGImage:asset.thumbnail];
                     [blockCell setImage:image];
                 }];
            }
            
        } failureBlock:^(NSError *error){

        }];
    }
    return imageEdittingCell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.images.count - 1) {
        if (self.images.count >= 10) {
            [[LoadingManager sharedManager] showError:@"不得超过9张图片" toView:self.view];
        } else {
            [ImagePickHelper imagePickup:self allowsEditing:NO singleSelected:NO];
            [LoadingManager sharedManager].maxLoadingImageCount = 10 - self.images.count;
        }
    }
}

#pragma mark - UIImagePickerControllerDelegate

- (void)dnImagePickerController:(DNImagePickerController *)imagePicker
                     sendImages:(NSArray *)imageAssets
                    isFullImage:(BOOL)fullImage
{
    NSMutableArray *mutableImages = [self.images mutableCopy];
    NSRange range = NSMakeRange(0, imageAssets.count);
    NSIndexSet *indexset = [NSIndexSet indexSetWithIndexesInRange:range];
    [mutableImages insertObjects:imageAssets atIndexes:indexset];
    self.images = mutableImages;
    [self.collectionView reloadData];

    [self.collectionView reloadData];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.productTypes.count;
}

#pragma mark - UIPickerViewDelegate

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.productTypes[row];
}

#pragma mark - Actions

- (IBAction)productTypeEditted:(id)sender
{
    [self.view endEditing:YES];
    self.prickView.hidden = NO;
    [self.scrollView setContentInset:UIEdgeInsetsMake(0, 0, 216, 0)];
    CGFloat contentOffset = 216 + 490 - screenBounds.size.height + 64;
    [self.scrollView setContentOffset:CGPointMake(0, MAX(contentOffset, 0)) animated:YES];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.productTypeLabel.text = self.productTypes[row];
}

#pragma mark - ImageEditCellDelegate

- (void)deleteImageWithPath:(NSInteger)index
{
    NSMutableArray *imageArray = [self.images mutableCopy];
    [imageArray removeObjectAtIndex:index];
    self.images = imageArray;
    [self.collectionView reloadData];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    textField.text = [NSString stringWithFormat:@"%0.1f", [textField.text doubleValue]];
}

#pragma mark - Private Methods

- (void)setContentStyle
{
    UIColor *color = separatorLineColor;
    self.productDescriptionTextVIew.layer.borderColor = color.CGColor;
    self.productDescriptionTextVIew.layer.borderWidth = 1;
    self.productDescriptionTextVIew.layer.cornerRadius = 5;

    self.productPriceTexrField.layer.borderColor = color.CGColor;
    self.productPriceTexrField.layer.borderWidth = 1;
    self.productPriceTexrField.layer.cornerRadius = 5;
    
    self.productPriceTexrField.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 10)];
    self.productPriceTexrField.rightViewMode = UITextFieldViewModeAlways;
    self.productPriceTexrField.delegate = self;
}

- (void)setContentData
{
    NSMutableArray *productTypes = [NSMutableArray new];
    for (ProductTypeModel *productType in [DiskCacheManager sharedManager].productTypes) {
        [productTypes addObject:productType.productTypeName];
    }
    self.productTypes = productTypes;
    
    self.title = @"商品编辑";
    self.images = self.product.images;
    self.productDescriptionTextVIew.text = self.product.productDescription;
    self.productPriceTexrField.text = [NSString stringWithFormat:@"%@", self.product.price ? @(self.product.price) : @""];
    self.productTypeLabel.text = self.product.productType;
    self.images = [self.product.images ? self.product.images : @[]  arrayByAddingObject:[UIImage imageNamed:@"Add"]];
    [self.collectionView reloadData];
}

- (void)completeEditting
{
    self.product.price = [self.productPriceTexrField.text doubleValue];
    self.product.productDescription = self.productDescriptionTextVIew.text;
//    self.product.images = self.images;
    self.product.productType = self.productTypeLabel.text;
    
    if (![self checkEditting]) {
        return;
    }
    
    self.successCount = 0;
    self.failedCount = 0;
    self.imageURLs = [self.images mutableCopy];
    [[LoadingManager sharedManager] showLoadingWithBlockUI:self.view description:@"正在更新，请耐心等待"];
    for (NSInteger index = 0; index < self.images.count - 1; index++) {
        [self imageByIndex:index];
    }
}

- (void)longPress:(UILongPressGestureRecognizer *)recognizer;
{
    if (self.editing) {
        return;
    }
    
    CGPoint snapshotLocation = [recognizer locationInView:self.view];
    CGPoint location = [recognizer locationInView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:location];
    
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        if (indexPath.row == self.images.count -1) {
            return;
        }
        self.sourceIndex = indexPath;
        ImageEdittingCell *cell = (ImageEdittingCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
        self.snapshot = cell.snapshot;
        [self updateSnapshotView:snapshotLocation transform:CGAffineTransformIdentity alpha:0.0];
        [self.view addSubview:self.snapshot];
        [UIView animateWithDuration:0.25 animations:^{
            [self updateSnapshotView:snapshotLocation transform:CGAffineTransformMakeScale(1.05, 1.05) alpha:0.95];
            cell.moving = YES;
        }];
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        self.snapshot.center = snapshotLocation;
        if (indexPath && indexPath.row != self.images.count - 1) {
            NSMutableArray *images = [self.images mutableCopy];
            [images exchangeObjectAtIndex:self.sourceIndex.row withObjectAtIndex:indexPath.row];
            self.images = images;
            [self.collectionView moveItemAtIndexPath:self.sourceIndex toIndexPath:indexPath];
            self.sourceIndex = indexPath;
        }
    } else {
        ImageEdittingCell *cell = (ImageEdittingCell *)[self.collectionView cellForItemAtIndexPath:indexPath && indexPath.row != self.images.count - 1 ? indexPath : self.sourceIndex];
        [UIView animateWithDuration:0.25 animations:^{
            [self updateSnapshotView:cell.center transform:CGAffineTransformIdentity alpha:0.0];
            cell.moving = NO;
        } completion:^(BOOL finished) {
            [self.snapshot removeFromSuperview];
            self.snapshot = nil;
        }];
    }
}

- (void)updateSnapshotView:(CGPoint)center transform:(CGAffineTransform)transform alpha:(CGFloat)alpha
{
    self.snapshot.center = center;
    self.snapshot.transform = transform;
    self.snapshot.alpha = alpha;
}

- (void)endEditting:(UIGestureRecognizer *)recognizer
{
    [self.view endEditing:YES];
    self.prickView.hidden = YES;
    [self.scrollView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
}

- (void)keyboardWillShow:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    [self.scrollView setContentInset:UIEdgeInsetsMake(0, 0, kbSize.height + 10, 0)];
}

- (void)keyboardWillHide:(NSNotification*)aNotification
{
    [self.scrollView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
}

- (void)imageByIndex:(NSInteger)index
{
    DNAsset *dnasset = self.images[index];
    if (![dnasset isKindOfClass:[DNAsset class]]) {
        self.successCount ++;
        [self updateProcessStatus];
        return;
    }
    __block UIImage *image;
    ALAssetsLibrary *lib = [ALAssetsLibrary new];
    __weak typeof(self) weakSelf = self;
    [lib assetForURL:dnasset.url resultBlock:^(ALAsset *asset){
        if (asset) {
            image = [self imageByasset:asset];
        } else {
            // On iOS 8.1 [library assetForUrl] Photo Streams always returns nil. Try to obtain it in an alternative way
            [lib enumerateGroupsWithTypes:ALAssetsGroupPhotoStream
                               usingBlock:^(ALAssetsGroup *group, BOOL *stop)
             {
                 [group enumerateAssetsWithOptions:NSEnumerationReverse
                                        usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                                            
                                            if([[result valueForProperty:ALAssetPropertyAssetURL] isEqual:dnasset.url])
                                            {
                                                image = [self imageByasset:result];
                                                *stop = YES;
                                            }
                                        }];
             }
                             failureBlock:^(NSError *error)
             {
                 image = [self imageByasset:asset];
             }];
        }
        
        [self.fileUploadBLLInstance uploadImage:UIImageJPEGRepresentation(image, 0.3) imageIndex:index success:^(NSDictionary *json, NSInteger index) {
            NSString *url = [NSString stringWithFormat:@"%@/Images/%@", [HTTPSessionManager sharedManager].baseUrlStr, json[@"filename"]];
            [weakSelf.imageURLs setObject:url atIndexedSubscript:index];
            weakSelf.successCount ++;
            [weakSelf updateProcessStatus];
        } failure:^{
            [weakSelf.imageURLs setObject:@"" atIndexedSubscript:index];
            weakSelf.failedCount ++;
            [weakSelf updateProcessStatus];
        }];

        
    } failureBlock:^(NSError *error){
        weakSelf.failedCount ++;
    }];
}

- (UIImage *)imageByasset:(ALAsset *)asset
{
    
    if (!asset) {
        return [UIImage imageNamed:@"assets_placeholder_picture"];
    }
    return [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
}

- (void)updateProcessStatus
{
    if (self.successCount + self.failedCount == self.images.count - 1) {
        [self.imageURLs removeLastObject];
        self.product.images = self.imageURLs;
        [[[ProductBLL alloc] init] updateProduct:self.product success:^(NSDictionary *json) {
            self.product = [ProductModel fromDictionary:json];
            [[DiskCacheManager sharedManager] updateProductInformation:self.product];
            [[LoadingManager sharedManager] hideLoadingWithmessage:@"更新成功" success:YES];
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^{
            [[LoadingManager sharedManager] hideLoadingWithmessage:@"更新失败" success:YES];
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
    } else {
    }
}

- (BOOL)checkEditting
{
    if (self.images.count <= 1) {
        [[LoadingManager sharedManager] showError:@"请添加图片" toView:self.view];
        return NO;
    }
    
    if ([NSString isNilOrEmpty:self.product.productDescription]) {
        [[LoadingManager sharedManager] showError:@"请填写商品描述" toView:self.view];
        return NO;
    }
    
    if (self.product.price == 0.0) {
        [[LoadingManager sharedManager] showError:@"请填写金额" toView:self.view];
        return NO;
    }
    
    if ([NSString isNilOrEmpty:self.product.productType]) {
        [[LoadingManager sharedManager] showError:@"请选择分类" toView:self.view];
        return NO;
    }
    
    return YES;
}

@end
