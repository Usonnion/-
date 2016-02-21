//
//  StoreManagerViewController.m
//  约拍
//
//  Created by apple on 16/2/14.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "StoreManagerViewController.h"
#import "StoreModel.h"
#import "UIImageView+WebCache.h"
#import "ImagePickHelper.h"

@interface StoreManagerViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, weak) IBOutlet UITextField *storeNameTextField;
@property (nonatomic, weak) IBOutlet UITextField *storeAddressTextField;
@property (nonatomic, weak) IBOutlet UITextField *storePhoneTextField;
@property (nonatomic, weak) IBOutlet UIButton *editStorePhotoButton;
@property (nonatomic, weak) IBOutlet UIButton *photoGroupButton;
@property (nonatomic, weak) IBOutlet UIImageView *storeImageView;
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) StoreModel *store;

@end

@implementation StoreManagerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    self.store = [[DiskCacheManager sharedManager] getStoreByStoreId:self.action.storeId];

    [self endEditting];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

#pragma mark - Actions

- (IBAction)editIconButtonPressed:(id)sender
{
    [ImagePickHelper imagePickup:self];
}

- (IBAction)photoGroupButtonPressed:(id)sender
{
    
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo
{
    [self.storeImageView setImage:image];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Private methods

- (void)BeginEditting
{
    self.storeNameTextField.enabled = YES;
    self.storeAddressTextField.enabled = YES;
    self.storePhoneTextField.enabled = YES;
    self.editStorePhotoButton.hidden = NO;
    self.photoGroupButton.enabled = YES;
    self.storeNameTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.storeAddressTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.storePhoneTextField.borderStyle = UITextBorderStyleRoundedRect;
    
    UIBarButtonItem *completedBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(completeEditting)];
    self.navigationItem.rightBarButtonItem = completedBarButtonItem;
    UIBarButtonItem *cancelBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(endEditting)];
    self.navigationItem.leftBarButtonItem = cancelBarButtonItem;
}

- (void)endEditting
{
    self.storeNameTextField.enabled = NO;
    self.storeAddressTextField.enabled = NO;
    self.storePhoneTextField.enabled = NO;
    self.editStorePhotoButton.hidden = YES;
    self.photoGroupButton.enabled = NO;
    self.storeNameTextField.borderStyle = UITextBorderStyleNone;
    self.storeAddressTextField.borderStyle = UITextBorderStyleNone;
    self.storePhoneTextField.borderStyle = UITextBorderStyleNone;
    
    self.storeNameTextField.text = self.store.storeName;
    self.storeAddressTextField.text = self.store.storeAddress;
    self.storePhoneTextField.text = self.store.phoneNumber;
    [self.storeImageView sd_setImageWithURL:[NSURL URLWithString:self.store.storeImage] placeholderImage:[UIImage imageNamed:@"DefaultStore"]];
    
    UIBarButtonItem *editBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(BeginEditting)];
    self.navigationItem.leftBarButtonItem = editBarButtonItem;
    self.navigationItem.rightBarButtonItem = nil;
}

- (void)completeEditting
{
    self.store.storeName = self.storeNameTextField.text;
    self.store.storeAddress = self.storeAddressTextField.text;
    self.store.phoneNumber = self.storePhoneTextField.text;
    [[DiskCacheManager sharedManager] updateStoreInformation:self.store];
    
    [self endEditting];
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
