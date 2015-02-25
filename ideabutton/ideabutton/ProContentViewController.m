//
//  ProContentViewController.m
//  ideabutton
//
//  Created by Li Xiang on 15/2/10.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProContentViewController.h"
#import "InteractivePageViewController.h"
#import "SVProgressHUD.h"

#define Height  45

@interface ProContentViewController()<UITextFieldDelegate>

@property(nonatomic, strong)UIScrollView *mainScroll;

@property(nonatomic, assign)CGFloat lastScrollOffset;
@property(nonatomic, strong)UITextField *inFocusTextField;
@property(nonatomic, strong)NSMutableDictionary* myDict;

@property(nonatomic, strong)UITextField* brandTextField;
@property(nonatomic, strong)UITextField* productTextField;
@property(nonatomic, strong)UITextField* appealTextField;

@end


@implementation ProContentViewController

-(id)initWithDict:(NSDictionary*)dict
{
    self = [super init];
    if (self)
    {
        self.myDict = [[NSMutableDictionary alloc] initWithDictionary:dict];
    }
    
    return self;
}

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
    
    self.brandTextField = [[UITextField alloc] initWithFrame:inputView.frame];
    self.brandTextField.delegate = self;
    self.brandTextField.placeholder = @"品牌/子品牌";
    [contentView addSubview:self.brandTextField];
    
    UIImageView *inputView1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"input_bai"]];
    inputView1.userInteractionEnabled = YES;
    inputView1.frame = CGRectMake(20, 100, 240, 40);
    [contentView addSubview:inputView1];
    
    self.productTextField = [[UITextField alloc] initWithFrame:inputView1.frame];
    self.productTextField.delegate = self;
    self.productTextField.placeholder = @"品类/产品";
    [contentView addSubview:self.productTextField];
    
    UIImageView *inputView2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"input_bai"]];
    inputView2.userInteractionEnabled = YES;
    inputView2.frame = CGRectMake(20, 160, 240, 40);
    [contentView addSubview:inputView2];
    
    self.appealTextField = [[UITextField alloc] initWithFrame:inputView2.frame];
    self.appealTextField.delegate = self;
    self.appealTextField.placeholder = @"诉求点";
    [contentView addSubview:self.appealTextField];
    
    UIImageView* line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line"]];
    line.frame = CGRectMake(0, 230, 280, 5);
    [contentView addSubview:line];
    
    UIButton* ideaButton = [UIButton buttonWithType:UIButtonTypeCustom];
    ideaButton.frame = CGRectMake(100, 270, 70, 70);
    [ideaButton setBackgroundImage:[UIImage imageNamed:@"btn_logo"] forState:UIControlStateNormal];
    [ideaButton addTarget:self action:@selector(showNextPage) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:ideaButton];

    return contentView;
}

-(void)showNextPage
{
    if (self.brandTextField.text.length == 0 )
    {
        [SVProgressHUD showErrorWithStatus:@"品牌/子品牌不能为空"];
        return;
    }
    
    if (self.productTextField.text.length == 0)
    {
        [SVProgressHUD showErrorWithStatus:@"品类/产品不能为空"];
        return;
    }
    
    if (self.appealTextField.text.length == 0)
    {
        [SVProgressHUD showErrorWithStatus:@"诉求点不能为空"];
        return;
    }
    [self.myDict setValue:self.brandTextField.text forKey:@"brand"];
    [self.myDict setValue:self.productTextField.text forKey:@"product"];
    [self.myDict setValue:self.appealTextField.text forKey:@"appeal"];
    
    InteractivePageViewController* interactivePage = [[InteractivePageViewController alloc] initWithDict:self.myDict];
    [self.navigationController pushViewController:interactivePage animated:YES];
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