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

@interface ProductManagerViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *collectionViewHeightConstraint;
@property (nonatomic, weak) IBOutlet UITextView *productDescriptionTextVIew;
@property (nonatomic, weak) IBOutlet UITextField *productPriceTexrField;
@property (nonatomic, weak) IBOutlet UILabel *productTypeLabel;
@property (nonatomic, weak) IBOutlet UIPickerView *prickView;
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;

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
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
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
    [imageEdittingCell setImage:self.images[indexPath.row]];
    return imageEdittingCell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.images.count - 1) {
        [ImagePickHelper imagePickup:self allowsEditing:NO];
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
//    self.collectionViewHeightConstraint.constant = self.collectionView.contentSize.height;
    [self.view layoutIfNeeded];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
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
    self.prickView.hidden = NO;
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
    self.product.productType = self.productTypeLabel.text;
    [self.myProductsViewController editProductSuccess:self.product];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)mockData
{
    self.productTypes = @[@"儿童摄影", @"婚纱摄影", @"个人写真", @"其他"];
}

//- (CGFloat)collectionViewEstimateHeight
//{
//    CGFloat collectionViewWidth = screenBounds.size.width - 32.0;
//    NSInteger oneRowCount = collectionViewWidth / 54;
//    return ceil(self.images.count / oneRowCount ) * 52.0;
//}

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
}

- (void)keyboardWillShow:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    [self.scrollView setContentInset:UIEdgeInsetsMake(0, 0, kbSize.height + 10, 0)];

    if (self.productDescriptionTextVIew.isFirstResponder) {
        [self.scrollView setContentOffset:CGPointMake(0.0, 240.0) animated:YES];
    }
}

- (void)keyboardWillHide:(NSNotification*)aNotification
{
    [self.scrollView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
}

@end
