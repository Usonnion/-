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

@interface ProductManagerViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate, DNImagePickerControllerDelegate>

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

@end

@implementation ProductManagerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self mockData];
    [self setContentData];
    [self setContentStyle];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ImageEdittingCell" bundle:nil] forCellWithReuseIdentifier:@"ImageEdittingCell"];
    self.images = @[[UIImage imageNamed:@"DefaultStore"]];
    [self.collectionView reloadData];
    
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
    if ([cellData isKindOfClass:[UIImage class]]) {
        [imageEdittingCell setImage:self.images[indexPath.row]];
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

//
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo
//{
//    NSMutableArray *mutableImages = [self.images mutableCopy];
//    NSRange range = NSMakeRange(0, 1);
//    NSIndexSet *indexset = [NSIndexSet indexSetWithIndexesInRange:range];
//    [mutableImages insertObjects:@[image] atIndexes:indexset];
//    self.images = mutableImages;
//    [self.collectionView reloadData];
////    self.collectionViewHeightConstraint.constant = self.collectionView.contentSize.height;
//    [self.view layoutIfNeeded];
//    
//    [picker dismissViewControllerAnimated:YES completion:nil];
//}

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
//    NSInteger scrollViewContentHeight = 490;
//    [self.productTypeLabel becomeFirstResponder];
    CGFloat contentOffset = 216 + 490 - screenBounds.size.height + 64;
    [self.scrollView setContentOffset:CGPointMake(0, MAX(contentOffset, 0))];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.productTypeLabel.text = self.productTypes[row];
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
    self.product.productType = self.productTypeLabel.text;
    [self.myProductsViewController editProductSuccess:self.product];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)mockData
{
    self.productTypes = @[@"儿童摄影", @"婚纱摄影", @"个人写真", @"其他"];
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
        if (indexPath) {
            NSMutableArray *images = [self.images mutableCopy];
            [images exchangeObjectAtIndex:self.sourceIndex.row withObjectAtIndex:indexPath.row];
            self.images = images;
            [self.collectionView moveItemAtIndexPath:self.sourceIndex toIndexPath:indexPath];
            self.sourceIndex = indexPath;
        }
    } else {
        ImageEdittingCell *cell = (ImageEdittingCell *)[self.collectionView cellForItemAtIndexPath:indexPath ? indexPath : self.sourceIndex];
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

@end
