//
//  RegisterViewController.m
//  ideabutton
//
//  Created by Li Xiang on 15/2/9.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegisterViewController.h"
#import "SVProgressHUD.h"
#import "API.h"
#import "DB.h"
#import "APLevelDB.h"

#define Height  45

@interface RegisterViewController()<UITextFieldDelegate>

@property(nonatomic, strong)UIScrollView *mainScroll;

@property(nonatomic, assign)CGFloat lastScrollOffset;
@property(nonatomic, strong)UITextField *inFocusTextField;

@property(nonatomic, strong)UITextField* registerNameTextField;
@property(nonatomic, strong)UITextField* nickNameTextField;
@property(nonatomic, strong)UITextField* registerPSWTextField;
@property(nonatomic, strong)UITextField* confirmPSWTextField;

@end


@implementation RegisterViewController

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
-(void)btnright
{
    [self showMenuView];
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
    UIView* registerView = [[UIView alloc] initWithFrame:CGRectMake(20, 60, 280, 380)];
    registerView.backgroundColor = [UIColor colorWithRed:21/255.0 green:21/255.0 blue:22/255.0 alpha:1.0];
    
    UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"zhuce_icon"]];
    imageView.frame = CGRectMake(110, 20, 50, 50);
    [registerView addSubview:imageView];
    
    UIImageView* line = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line"]];
    line.frame = CGRectMake(0, 80, 280, 2);
    [registerView addSubview:line];
    
    UIImageView *nickNameView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"input_bai"]];
    nickNameView.userInteractionEnabled = YES;
    nickNameView.frame = CGRectMake(20, 100, 240, 40);
    [registerView addSubview:nickNameView];
    
    UIImageView* nickNameImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_admin"]];
    nickNameImg.frame = CGRectMake(10, 5, 30, 30);
    [nickNameView addSubview:nickNameImg];
    
    UILabel* nickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, 35, 30)];
    nickNameLabel.text = @"昵称";
    [nickNameView addSubview:nickNameLabel];
    
    self.nickNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(90, 5, 145, 30)];
    _nickNameTextField.delegate = self;
    [nickNameView addSubview:_nickNameTextField];
    
    UIImageView *registerNameView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"input_bai"]];
    registerNameView.userInteractionEnabled = YES;
    registerNameView.frame = CGRectMake(20, 150, 240, 40);
    [registerView addSubview:registerNameView];
    
    UIImageView* registerNameImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_mail"]];
    registerNameImg.frame = CGRectMake(10, 5, 30, 30);
    [registerNameView addSubview:registerNameImg];
    
    UILabel* registerNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, 35, 30)];
    registerNameLabel.text = @"帐号";
    [registerNameView addSubview:registerNameLabel];
    
    self.registerNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(90, 5, 145, 30)];
    _registerNameTextField.delegate = self;
    _registerNameTextField.placeholder = @"邮箱/手机/QQ";
    [registerNameView addSubview:_registerNameTextField];
    
    UIImageView *registerPSWView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"input_bai"]];
    registerPSWView.userInteractionEnabled = YES;
    registerPSWView.frame = CGRectMake(20, 200, 240, 40);
    [registerView addSubview:registerPSWView];
    
    UIImageView* registerPSWImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_mima"]];
    registerPSWImg.frame = CGRectMake(10, 5, 30, 30);
    [registerPSWView addSubview:registerPSWImg];
    
    UILabel* registerPSWLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 5, 35, 30)];
    registerPSWLabel.text = @"密码";
    [registerPSWView addSubview:registerPSWLabel];
    
    self.registerPSWTextField = [[UITextField alloc] initWithFrame:CGRectMake(85, 5, 150, 30)];
    _registerPSWTextField.delegate = self;
    _registerPSWTextField.secureTextEntry = YES;
    [registerPSWView addSubview:_registerPSWTextField];
    
    UIImageView *confirmPSWView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"input_bai"]];
    confirmPSWView.userInteractionEnabled = YES;
    confirmPSWView.frame = CGRectMake(20, 250, 240, 40);
    [registerView addSubview:confirmPSWView];
    
    UIImageView* confirmPSWImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_mima"]];
    confirmPSWImg.frame = CGRectMake(10, 5, 30, 30);
    [confirmPSWView addSubview:confirmPSWImg];
    
    UILabel* confirmPSWLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 5, 70, 30)];
    confirmPSWLabel.text = @"确认密码";
    [confirmPSWView addSubview:confirmPSWLabel];
    
    self.confirmPSWTextField = [[UITextField alloc] initWithFrame:CGRectMake(120, 5, 115, 30)];
    _confirmPSWTextField.delegate = self;
    _confirmPSWTextField.secureTextEntry = YES;
    [confirmPSWView addSubview:_confirmPSWTextField];
    
    UIButton* registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(90, 320, 100, 50)];
    registerBtn.layer.cornerRadius = 5;
    registerBtn.backgroundColor = COLOR(124, 96, 33);
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(registerAccount) forControlEvents:UIControlEventTouchUpInside];
    [registerView addSubview:registerBtn];
    
    return registerView;
}

-(void)registerAccount
{
    NSDictionary *params = [self invalidateInput];
    if(!params)
    {
        return;
    }
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    
    dispatch_queue_t currentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(currentQueue, ^{
        User *user = [[API sharedInstance]newUser:params];
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        dispatch_async(mainQueue, ^{
            [SVProgressHUD dismiss];
            if(user)
            {
                DB *db = [DB sharedInstance];
                [db saveUser:user];
                [db.indb setData:[user.userName dataUsingEncoding:NSUTF8StringEncoding] forKey:@"ctrler:login:last-login-name"];
                
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            else
            {
                [self showalertview_text:[API sharedInstance].msg imgname:@"error" autoHiden:YES];
            }
        });
    });
}

-(NSDictionary*)invalidateInput
{
    if (self.nickNameTextField.text == 0)
    {
        [self showalertview_text:@"昵称不能为空" imgname:@"error" autoHiden:YES];
        return nil;
    }
    
    if (self.registerNameTextField.text == 0)
    {
        [self showalertview_text:@"账号不能为空" imgname:@"error" autoHiden:YES];
        return nil;
    }
    
    if (self.registerPSWTextField.text == 0)
    {
        [self showalertview_text:@"密码不能为空" imgname:@"error" autoHiden:YES];
        return nil;
    }
    
    if (![self.registerPSWTextField.text isEqualToString:self.confirmPSWTextField.text])
    {
        [self showalertview_text:@"两次输入的密码不一致" imgname:@"error" autoHiden:YES];
        return nil;
    }
    
    return @{@"nickname":self.nickNameTextField.text,@"userName":self.registerNameTextField.text,@"password":self.registerPSWTextField.text};
}

@end