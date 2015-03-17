//
//  ForgetPswViewController.m
//  ideabutton
//
//  Created by Li Xiang on 15/3/17.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import "ForgetPswViewController.h"

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
    
    [self setrightbaritem_imgname:@"icon_more_all" title:nil];
    
    [self createInputView];
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
    [getIdentifyCodeBtn setBackgroundImage:[UIImage imageNamed:@"all_btn_hqyzm"] forState:UIControlStateNormal];
    [groundView addSubview:getIdentifyCodeBtn];
    
    getIdentifyCodeTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 210, 240, 40)];
    getIdentifyCodeTextField.layer.cornerRadius = 5;
    getIdentifyCodeTextField.backgroundColor = [UIColor whiteColor];
    getIdentifyCodeTextField.placeholder = @"请输入验证码";
    [groundView addSubview:getIdentifyCodeTextField];
    
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
    [ReSetPSWBtn setBackgroundImage:[UIImage imageNamed:@"all_btn_czmm"] forState:UIControlStateNormal];
    [ReSetPSWBtn addTarget:self action:@selector(resetPassword) forControlEvents:UIControlEventTouchUpInside];
    [groundView addSubview:ReSetPSWBtn];
}

-(void)resetPassword
{
    CGRect frame = CGRectMake(90,380,150,20);
    
    if(getIdentifyCodeTextField.text.length == 0)
    {
        [self showalertview_text:@"请输入验证码" frame:frame autoHiden:YES];
        return;
    }
    
    if(newPSWTextField.text.length == 0)
    {
        [self showalertview_text:@"请输入新的密码" frame:frame autoHiden:YES];
        return;
    }
    
    if(![confirmPSWTextField.text isEqualToString:newPSWTextField.text])
    {
        [self showalertview_text:@"两次输入的密码不一致" frame:frame autoHiden:YES];
        return;
    }
}
@end
