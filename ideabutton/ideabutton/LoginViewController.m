//
//  LoginView.m
//  ideabutton
//
//  Created by Li Xiang on 15/2/9.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "Config.h"

@interface LoginViewController ()<UITextFieldDelegate>
{

}

@property(nonatomic, assign)BOOL agreementChecked;

@end

@implementation LoginViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        self.agreementChecked = NO;
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setrightbaritem_imgname:@"icon_more_all" title:nil];
    
    [self createInputView];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (void)checkboxClicked:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    if(self.agreementChecked)
    {
        [btn setImage:[UIImage imageNamed:@"checkbox-unchecked"] forState:UIControlStateNormal];
        self.agreementChecked = NO;
    }
    else
    {
        [btn setImage:[UIImage imageNamed:@"checkbox-checked"] forState:UIControlStateNormal];
        self.agreementChecked = YES;
    }
}

-(void)createInputView
{
    UIView* loginView = [[UIView alloc] initWithFrame:CGRectMake(20, 60, 280, 380)];
    loginView.backgroundColor = COLOR(21, 21, 22);
    [self.view addSubview:loginView];
    
    UIImageView *loginNameView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"input_bai"]];
    loginNameView.userInteractionEnabled = YES;
    loginNameView.frame = CGRectMake(20, 30, 240, 40);
    [loginView addSubview:loginNameView];
    
    UIImageView* loginNameImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_mail"]];
    loginNameImg.frame = CGRectMake(10, 5, 30, 30);
    [loginNameView addSubview:loginNameImg];
    
    UILabel* loginNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, 35, 30)];
    loginNameLabel.text = @"帐号";
    [loginNameView addSubview:loginNameLabel];
    
    UITextField* loginNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(90, 5, 145, 30)];
    loginNameTextField.textAlignment = NSTextAlignmentCenter;
    loginNameTextField.placeholder = @"邮箱/手机/QQ";
    loginNameTextField.delegate = self;
    [loginNameView addSubview:loginNameTextField];
    
    UIImageView *loginPSWView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"input_bai"]];
    loginPSWView.userInteractionEnabled = YES;
    loginPSWView.frame = CGRectMake(20, 90, 240, 40);
    [loginView addSubview:loginPSWView];
    
    UIImageView* loginPSWImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_mima"]];
    loginPSWImg.frame = CGRectMake(10, 5, 30, 30);
    [loginPSWView addSubview:loginPSWImg];
    
    UILabel* loginPSWLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, 35, 30)];
    loginPSWLabel.text = @"密码";
    [loginPSWView addSubview:loginPSWLabel];
    
    UITextField* loginPSWTextField = [[UITextField alloc] initWithFrame:CGRectMake(90, 5, 145, 30)];
    loginPSWTextField.delegate = self;
    loginPSWTextField.secureTextEntry = YES;
//    loginPSWTextField.textAlignment = NSTextAlignmentCenter;
    [loginPSWView addSubview:loginPSWTextField];
    
    UIButton *checkboxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    checkboxBtn.frame = CGRectMake(20, 140, 20, 20);
    [checkboxBtn setImage:[UIImage imageNamed:@"checkbox-unchecked"] forState:UIControlStateNormal];
    [checkboxBtn addTarget:self action:@selector(checkboxClicked:) forControlEvents:UIControlEventTouchUpInside];
    [loginView addSubview:checkboxBtn];
    
    UILabel* rememberPSWLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 138, 60, 25)];
    rememberPSWLabel.textColor = [UIColor whiteColor];
    rememberPSWLabel.font = [UIFont systemFontOfSize:14];
    rememberPSWLabel.text = @"记住密码";
    [loginView addSubview:rememberPSWLabel];
    
    UILabel* forgetPSWLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 138, 60, 25)];
    forgetPSWLabel.textColor = [UIColor whiteColor];
    forgetPSWLabel.font = [UIFont systemFontOfSize:14];
    forgetPSWLabel.text = @"忘记密码";
    [loginView addSubview:forgetPSWLabel];
    
    UIButton* loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(90, 200, 100, 50)];
    loginBtn.layer.cornerRadius = 5;
    loginBtn.backgroundColor = COLOR(124, 96, 33);
//    [loginBtn setBackgroundImage:[UIImage imageNamed:@"btn_bg_login"] forState:UIControlStateNormal];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginView addSubview:loginBtn];
    
    UIImageView* line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line"]];
    line.frame = CGRectMake(0, 280, 280, 5);
    [loginView addSubview:line];
    
    UIButton* cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 310, 100, 50)];
    cancelBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    cancelBtn.layer.borderWidth = 1.0;
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [loginView addSubview:cancelBtn];
    
    UIButton* registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(160, 310, 100, 50)];
    registerBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    registerBtn.layer.borderWidth = 1.0;
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(showRegisterViewController) forControlEvents:UIControlEventTouchUpInside];
    [loginView addSubview:registerBtn];
}

-(void)showRegisterViewController
{
    RegisterViewController* registerView = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerView animated:YES];
}
@end