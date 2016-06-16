//
//  CommentsViewController.m
//  约拍
//
//  Created by apple on 16/5/23.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "CommentViewController.h"
#import "Star.h"
#import "CommentModel.h"
#import "CommentsBLL.h"

@interface CommentViewController() <UITextViewDelegate>

@property (nonatomic, weak) IBOutlet UIView *startsView;
@property (nonatomic, weak) IBOutlet UITextView *commentsTextView;

@property (nonatomic, weak) Star *star;

@end

@implementation CommentViewController

- (void)viewDidLoad
{
    Star *star = [[Star alloc] initWithFrame:CGRectMake(0, 0, 200.0f, 40.0f)];
    star.show_star = 100;
    star.isSelect = YES;
    star.font_size = 40;
    [self.startsView addSubview:star];
    self.star = star;
    
    UIColor *color = separatorLineColor;
    self.commentsTextView.layer.borderColor = color.CGColor;
    self.commentsTextView.layer.borderWidth = 1;
    self.commentsTextView.layer.cornerRadius = 5;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self.commentsTextView action:@selector(resignFirstResponder)];
    [self.view addGestureRecognizer:tapGesture];
}

- (IBAction)cancel:(id)sender
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"当前正在评价，确认取消评价？" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:nil]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)submit:(id)sender
{
    CommentModel *comment = [[CommentModel alloc] init];
    comment.score = self.star.show_star;
    comment.comment = self.commentsTextView.text;
    comment.customer = self.order.customer;
    comment.product = self.order.product;
    comment.orderId = self.order.orderId;
    
    [[LoadingManager sharedManager] showLoadingWithBlockUI:self.view description:nil];
    [[[CommentsBLL alloc] init] createdComment:comment success:^{
        [[LoadingManager sharedManager] hideLoadingWithmessage:@"感谢您的评价，祝您生活愉快！" success:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^{
        [[LoadingManager sharedManager] hideLoadingWithmessage:@"评价失败，请稍后重试！" success:NO];
    }];
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length > 200) {
        textView.text = [textView.text substringToIndex:200];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

@end
