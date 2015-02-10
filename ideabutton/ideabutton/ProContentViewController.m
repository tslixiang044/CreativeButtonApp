//
//  ProContentViewController.m
//  ideabutton
//
//  Created by Li Xiang on 15/2/10.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProContentViewController.h"

#define Height  45

@interface ProContentViewController()<UITextFieldDelegate>

@property(nonatomic, strong)UIScrollView *mainScroll;

@property(nonatomic, assign)CGFloat lastScrollOffset;
@property(nonatomic, strong)UITextField *inFocusTextField;

@end


@implementation ProContentViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setrightbaritem_imgname:@"icon_more_all" title:nil];
    
    CGFloat contentHeight = 380;
    UIScrollView *mainScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    mainScroll.contentSize = CGSizeMake(320, contentHeight);
    self.mainScroll = mainScroll;
    [self.view addSubview:mainScroll];
    
    UIView *editingView = [self createInputView];
    editingView.frame = CGRectMake(20, 60, 280, contentHeight);
    [mainScroll addSubview:editingView];
    
    //注册键盘通知获取键盘高度
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:self.view.window];
}

- (void)keyboardWillShow:(NSNotification *)noti
{
    NSDictionary* userInfo = [noti userInfo];
    
    CGFloat keyboardHeight = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height+50;
    self.lastScrollOffset = self.mainScroll.contentOffset.y;
    
    CGRect inputRect = [self.inFocusTextField.superview convertRect:CGRectMake(0, 0, 320, Height) toView:self.view];
    CGFloat inputRectBottomHeight = self.view.frame.size.height - (inputRect.origin.y + Height);
    CGFloat heightDiff = inputRectBottomHeight - keyboardHeight;
    if(heightDiff<0)
    {
        CGFloat newScrollOffset = self.mainScroll.contentOffset.y-heightDiff;
        [self.mainScroll setContentOffset:CGPointMake(0, newScrollOffset) animated:YES];
    }
}

-(UIView*)createInputView
{
    UIView* contentView = [[UIView alloc] initWithFrame:CGRectMake(20, 60, 280, 380)];
    contentView.backgroundColor = COLOR(21, 21, 22);
    [self.view addSubview:contentView];
    
    UIImageView *inputView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"input_bai"]];
    inputView.userInteractionEnabled = YES;
    inputView.frame = CGRectMake(20, 40, 240, 40);
    [contentView addSubview:inputView];
    
    UITextField* textfield = [[UITextField alloc] initWithFrame:inputView.frame];
    textfield.delegate = self;
    textfield.placeholder = @"品牌/子品牌";
    [contentView addSubview:textfield];
    
    UIImageView *inputView1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"input_bai"]];
    inputView1.userInteractionEnabled = YES;
    inputView1.frame = CGRectMake(20, 100, 240, 40);
    [contentView addSubview:inputView1];
    
    UITextField* textfield1 = [[UITextField alloc] initWithFrame:inputView1.frame];
    textfield1.delegate = self;
    textfield1.placeholder = @"品类/产品";
    [contentView addSubview:textfield1];
    
    UIImageView *inputView2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"input_bai"]];
    inputView2.userInteractionEnabled = YES;
    inputView2.frame = CGRectMake(20, 160, 240, 40);
    [contentView addSubview:inputView2];
    
    UITextField* textfield2 = [[UITextField alloc] initWithFrame:inputView2.frame];
    textfield2.delegate = self;
    textfield2.placeholder = @"诉求点";
    [contentView addSubview:textfield2];
    
    UIImageView* line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line"]];
    line.frame = CGRectMake(0, 230, 280, 5);
    [contentView addSubview:line];
    
    UIButton* ideaButton = [UIButton buttonWithType:UIButtonTypeCustom];
    ideaButton.frame = CGRectMake(100, 270, 70, 70);
    [ideaButton setBackgroundImage:[UIImage imageNamed:@"btn_logo"] forState:UIControlStateNormal];
    [contentView addSubview:ideaButton];

    return contentView;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.inFocusTextField = textField;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    [self.mainScroll setContentOffset:CGPointMake(0, self.lastScrollOffset) animated:YES];
    
    return YES;
}

@end