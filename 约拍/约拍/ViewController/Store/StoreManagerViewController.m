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
#import "FileUploadBLL.h"
#import "HTTPSessionManager.h"
#import "StoreBLL.h"
#import "DNImagePickerController.h"
#import "MyProductsViewController.h"

@interface StoreManagerViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, DNImagePickerControllerDelegate>

@property (nonatomic, weak) IBOutlet UITextField *storeNameTextField;
@property (nonatomic, weak) IBOutlet UITextField *storeAddressTextField;
@property (nonatomic, weak) IBOutlet UITextField *storePhoneTextField;
@property (nonatomic, weak) IBOutlet UIButton *editStorePhotoButton;
@property (nonatomic, weak) IBOutlet UIButton *photoGroupButton;
@property (nonatomic, weak) IBOutlet UIImageView *storeImageView;
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) StoreModel *store;
@property (nonatomic, strong) id storeImage;

@end

@implementation StoreManagerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditting:)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    self.store = [[DiskCacheManager sharedManager] getStoreByStoreId:self.action.storeId];
    
    [self setStoreImage];
    [self endEditting];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Actions

- (IBAction)editIconButtonPressed:(id)sender
{
    [ImagePickHelper imagePickup:self allowsEditing:YES singleSelected:YES];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo
{
    [self.storeImageView setImage:image];
    self.storeImage = image;
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
    [self setStoreImage];
    
    UIBarButtonItem *editBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(BeginEditting)];
    self.navigationItem.rightBarButtonItem = editBarButtonItem;
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
}

- (void)completeEditting
{
    self.store.storeName = self.storeNameTextField.text;
    self.store.storeAddress = self.storeAddressTextField.text;
    self.store.phoneNumber = self.storePhoneTextField.text;
    
    if (![self checkEditting]) {
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    [[LoadingManager sharedManager] showLoadingWithBlockUI:self.navigationController.view description:@"上传图片中"];
    [[[FileUploadBLL alloc] init] uploadImage:UIImageJPEGRepresentation(self.storeImageView.image, 0.1) imageIndex:0 success:^(NSDictionary *json, NSInteger index) {
        NSString *url = [NSString stringWithFormat:@"%@/Images/%@", [HTTPSessionManager sharedManager].baseUrlStr, json[@"filename"]];
        weakSelf.store.storeImage = url;
        [[[StoreBLL alloc] init] updateStore:weakSelf.store success:^(NSDictionary *json) {
            [[DiskCacheManager sharedManager] updateStoreInformation:weakSelf.store ];
            [[LoadingManager sharedManager] hideLoadingWithmessage:@"恭喜您，更新成功" success:YES];
        } failure:^{
            [[LoadingManager sharedManager] hideLoadingWithmessage:@"对不起，更新失败，请从新尝试" success:NO];
        }];
        [[DiskCacheManager sharedManager] updateStoreInformation:weakSelf.store];
        [weakSelf endEditting];
    } failure:^{
        [[LoadingManager sharedManager] hideLoadingWithmessage:@"对不起，上传图片失败，请从新尝试" success:NO];
        [weakSelf endEditting];
    }];
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
}

- (void)keyboardWillHide:(NSNotification*)aNotification
{
    [self.scrollView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
}

- (void)setStoreImage
{
    if (![NSString isNilOrEmpty:self.store.storeImage]) {
        [self.storeImageView sd_setImageWithURL:[NSURL URLWithString:self.store.storeImage] placeholderImage:[UIImage imageNamed:@"DefaultStore"]];
    }
    self.storeImage = self.store.storeImage;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(nullable id)sender
{
    [super prepareForSegue:segue sender:sender];
    UIViewController *viewController = segue.destinationViewController;
    if ([viewController isKindOfClass:[MyProductsViewController class]]) {
        ((MyProductsViewController *)viewController).storeId = self.store.storeId;
    }
}

- (BOOL)checkEditting
{
    [self.view endEditing:YES];
    if (!self.storeImage) {
        [[LoadingManager sharedManager] showError:@"请选择图片" toView:self.view];
        return NO;
    }
    
    if ([self.storeImage isKindOfClass:[NSString class]] && [NSString isNilOrEmpty:self.storeImage]) {
        [[LoadingManager sharedManager] showError:@"请选择图片" toView:self.view];
        return NO;
    }
    
    if ([NSString isNilOrEmpty:self.store.storeName]) {
        [[LoadingManager sharedManager] showError:@"请填写店名" toView:self.view];
        return NO;
    }
    
    if ([NSString isNilOrEmpty:self.store.storeAddress]) {
        [[LoadingManager sharedManager] showError:@"请填写地址" toView:self.view];
        return NO;
    }
    
    if ([NSString isNilOrEmpty:self.store.phoneNumber]) {
        [[LoadingManager sharedManager] showError:@"请选择电话" toView:self.view];
        return NO;
    }
    
    if (![NSString validatePhone:self.store.phoneNumber]) {
        [[LoadingManager sharedManager] showError:@"请填写正确的手机号" toView:self.view];
        return NO;
    }
    
    return YES;
}

@end
