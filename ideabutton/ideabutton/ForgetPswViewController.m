//
//  ForgetPswViewController.m
//  ideabutton
//
//  Created by Li Xiang on 15/3/17.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import "ForgetPswViewController.h"
#import "SVProgressHUD.h"

@implementation ForgetPswViewController
{
    UITextField* mailPhoneTextField;
    UITextField* getIdentifyCodeTextField;
    UITextField* newPSWTextField;
    UITextField* confirmPSWTextField;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = kgettitle;
    
    [self setrightbaritem_imgname:@"icon_more_all" title:nil];
    
    [self createInputView];
}
-(void)btnright
{
    [self showMenuView];
}
-(void)createInputView
{
    UIView* groundView = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 280, 470)];
    groundView.backgroundColor = COLOR(21, 21, 22);
    [self.view addSubview:groundView];
    
    UILabel* titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(105, 10, 100, 30)];
    titleLabel.text = @"找回密码";
    titleLabel.textColor = [UIColor whiteColor];
    [groundView addSubview:titleLabel];
    
    mailPhoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 50, 240, 40)];
    mailPhoneTextField.layer.cornerRadius = 5;
    mailPhoneTextField.backgroundColor = [UIColor whiteColor];
    mailPhoneTextField.placeholder = @"请输入你注册时使用的邮箱/手机";
    mailPhoneTextField.font = [UIFont systemFontOfSize:16];
    [groundView addSubview:mailPhoneTextField];
    
    UILabel* noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(22, 95, 240, 20)];
    noticeLabel.text = @"密码重置验证码将发送到你注册时使用的邮箱/手机";
    noticeLabel.textColor = [UIColor whiteColor];
    noticeLabel.font = [UIFont systemFontOfSize:10.5];
    [groundView addSubview:noticeLabel];
    
    UIButton* getIdentifyCodeBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 120, 70, 70)];
    [getIdentifyCodeBtn setBackgroundImage:[UIImage imageNamed:@"forgetPSW/all_btn_hqyzm"] forState:UIControlStateNormal];
    [groundView addSubview:getIdentifyCodeBtn];
    
    UIImageView* line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"public/line"]];
    line.frame = CGRectMake(0, 195, 280, 3);
    [groundView addSubview:line];
    
    getIdentifyCodeTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 210, 240, 40)];
    getIdentifyCodeTextField.layer.cornerRadius = 5;
    getIdentifyCodeTextField.backgroundColor = [UIColor whiteColor];
    getIdentifyCodeTextField.placeholder = @"请输入验证码";
    [groundView addSubview:getIdentifyCodeTextField];
    
    UIImageView* line1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"public/line"]];
    line1.frame = CGRectMake(0, 260, 280, 3);
    [groundView addSubview:line1];
    
    newPSWTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 280, 240, 40)];
    newPSWTextField.layer.cornerRadius = 5;
    newPSWTextField.backgroundColor = [UIColor whiteColor];
    newPSWTextField.placeholder = @"请输入新的密码";
    [groundView addSubview:newPSWTextField];
    
    confirmPSWTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 330, 240, 40)];
    confirmPSWTextField.layer.cornerRadius = 5;
    confirmPSWTextField.backgroundColor = [UIColor whiteColor];
    confirmPSWTextField.placeholder = @"请再次输入新的密码";
    [groundView addSubview:confirmPSWTextField];
    
    UIButton* ReSetPSWBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 390, 70, 70)];
    [ReSetPSWBtn setBackgroundImage:[UIImage imageNamed:@"forgetPSW/all_btn_czmm"] forState:UIControlStateNormal];
    [ReSetPSWBtn addTarget:self action:@selector(resetPassword) forControlEvents:UIControlEventTouchUpInside];
    [groundView addSubview:ReSetPSWBtn];
}

-(void)resetPassword
{
    if(getIdentifyCodeTextField.text.length == 0)
    {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return;
    }
    
    if(newPSWTextField.text.length == 0)
    {
        [SVProgressHUD showErrorWithStatus:@"请输入新的密码"];
        return;
    }
    
    if(![confirmPSWTextField.text isEqualToString:newPSWTextField.text])
    {
        [SVProgressHUD showErrorWithStatus:@"两次输入的密码不一致"];
        return;
    }
}
@end
