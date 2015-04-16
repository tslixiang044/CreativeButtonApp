//
//  LoginView.m
//  ideabutton
//
//  Created by Li Xiang on 15/2/9.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import "SVProgressHUD.h"
#import "API.h"
#import "DB.h"
#import "APLevelDB.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "IAlsoPressViewController.h"
#import "ForgetPswViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>

@property(nonatomic, strong)UITextField* loginNameTextField;
@property(nonatomic, strong)UITextField* loginPSWTextField;

@property(nonatomic, assign)BOOL agreementChecked;

@end

@implementation LoginViewController
@synthesize delegate;


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

-(void)btnright
{
    [self showMenuView];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.tag == 1111)
    {
        if (self.agreementChecked)
        {
            [[DB sharedInstance] saveArbitraryObject:self.loginPSWTextField.text withKey:@"LoginPSW"];
        }
    }
    [textField resignFirstResponder];
    
    return YES;
}

- (void)checkboxClicked:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    if(self.agreementChecked)
    {
        [btn setImage:[UIImage imageNamed:@"login/checkbox-unchecked"] forState:UIControlStateNormal];
        self.agreementChecked = NO;
        [[DB sharedInstance] saveArbitraryObject:nil withKey:@"LoginPSW"];
    }
    else
    {
        [btn setImage:[UIImage imageNamed:@"login/checkbox-checked"] forState:UIControlStateNormal];
        self.agreementChecked = YES;
        if (self.loginNameTextField.text.length > 0)
        {
            [[DB sharedInstance] saveArbitraryObject:self.loginPSWTextField.text withKey:@"LoginPSW"];
        }
    }
}

-(void)createInputView
{
    UIView* loginView = [[UIView alloc] initWithFrame:CGRectMake(20, 80, 280, 350)];
    loginView.backgroundColor = COLOR(21, 21, 22);
    [self.view addSubview:loginView];
    
    UIImageView *loginNameView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"public/input_bai"]];
    loginNameView.userInteractionEnabled = YES;
    loginNameView.frame = CGRectMake(15, 50, 252, 40);
    [loginView addSubview:loginNameView];
    
    UILabel* loginNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 35, 30)];
    loginNameLabel.text = @"帐号";
    [loginNameView addSubview:loginNameLabel];
    
    self.loginNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(60, 5, 180, 30)];
    _loginNameTextField.delegate = self;
    _loginNameTextField.placeholder = @"昵称/邮箱/手机";
    _loginNameTextField.keyboardType = UIKeyboardTypeDefault;
    
    DB *db = [DB sharedInstance];
    NSData *lastLoginNameData = [db.indb dataForKey:@"ctrler:login:last-login-name"];
    NSString *lastLoginName = [[NSString alloc]initWithData:lastLoginNameData encoding:NSUTF8StringEncoding];
    _loginNameTextField.text = lastLoginName;
    
    [loginNameView addSubview:_loginNameTextField];
    
    UIImageView *loginPSWView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"public/input_bai"]];
    loginPSWView.userInteractionEnabled = YES;
    loginPSWView.frame = CGRectMake(15, 110, 252, 40);
    [loginView addSubview:loginPSWView];
    
    UILabel* loginPSWLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 35, 30)];
    loginPSWLabel.text = @"密码";
    [loginPSWView addSubview:loginPSWLabel];
    
    self.loginPSWTextField = [[UITextField alloc] initWithFrame:CGRectMake(60, 5, 180, 30)];
    _loginPSWTextField.delegate = self;
    _loginPSWTextField.secureTextEntry = YES;
    _loginPSWTextField.tag = 1111;
    NSString* password = [[DB sharedInstance] queryArbitraryObjectWithKey:@"LoginPSW"];
    if (password)
    {
        self.loginPSWTextField.text = password;
        self.agreementChecked = YES;
    }
    [loginPSWView addSubview:_loginPSWTextField];
    
    UIButton *checkboxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    checkboxBtn.frame = CGRectMake(15, 160, 20, 20);
    if (!self.agreementChecked)
    {
        [checkboxBtn setImage:[UIImage imageNamed:@"login/checkbox-unchecked"] forState:UIControlStateNormal];
        [checkboxBtn addTarget:self action:@selector(checkboxClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        [checkboxBtn setImage:[UIImage imageNamed:@"login/checkbox-checked"] forState:UIControlStateNormal];
        [checkboxBtn addTarget:self action:@selector(checkboxClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    [loginView addSubview:checkboxBtn];
    
    UILabel* rememberPSWLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 158, 60, 25)];
    rememberPSWLabel.textColor = [UIColor whiteColor];
    rememberPSWLabel.font = [UIFont systemFontOfSize:14];
    rememberPSWLabel.text = @"记住密码";
    [loginView addSubview:rememberPSWLabel];
    
    UIButton* forgetPSWBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetPSWBtn.frame = CGRectMake(200, 158, 60, 25);
    forgetPSWBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [forgetPSWBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetPSWBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [forgetPSWBtn addTarget:self action:@selector(retrievePSW) forControlEvents:UIControlEventTouchUpInside];
    [loginView addSubview:forgetPSWBtn];
    
    UIImageView* line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"public/line"]];
    line.frame = CGRectMake(0, 210, 280, 3);
    [loginView addSubview:line];
    
    UIButton* loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, 251, 70, 70)];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"login/all_btn_dl"] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [loginView addSubview:loginBtn];
    
    UIButton* registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(160, 251, 70, 70)];
    [registerBtn setBackgroundImage:[UIImage imageNamed:@"public/all_btn_zc"] forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(showRegisterViewController) forControlEvents:UIControlEventTouchUpInside];
    [loginView addSubview:registerBtn];
}

-(void)showRegisterViewController
{
    RegisterViewController* registerView = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerView animated:YES];
}

- (void)login:(id)sender
{
    [self.loginNameTextField resignFirstResponder];
    [self.loginPSWTextField resignFirstResponder];
    
    if (self.loginNameTextField.text.length == 0)
    {
        [self showalertview_text:@"账号不能为空" frame:CGRectMake(80, 300, 150, 20) autoHiden:YES];
        return;
    }
    
    if (self.loginPSWTextField.text.length == 0)
    {
        [self showalertview_text:@"密码不能为空" frame:CGRectMake(80, 300, 150, 20) autoHiden:YES];
        return;
    }
    [SVProgressHUD showWithStatus:@"登录中" maskType:SVProgressHUDMaskTypeClear];
    
    NSString *loginName = self.loginNameTextField.text;
    NSString *psw = self.loginPSWTextField.text;
    dispatch_queue_t currentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(currentQueue, ^{
        //后台处理代码, 一般 http 请求在这里发, 然后阻塞等待返回, 收到返回处理
        NSString *credential = [NSString stringWithFormat:@"%@:%@", loginName, [self MD5String:[self MD5String:psw]]];
        User *user = [[API sharedInstance] queryUser:@{@"Auth":credential}];
        if(user)
        {
            DB *db = [DB sharedInstance];

            [db saveUser:user];
            [db.indb setData:[loginName dataUsingEncoding:NSUTF8StringEncoding] forKey:@"ctrler:login:last-login-name"];
        }
        
        user = [[DB sharedInstance]queryUser];
        //处理完上面的后回到主线程去更新UI
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        dispatch_async(mainQueue, ^{
            [SVProgressHUD dismiss];
            if(user)
            {
                [self.navigationController popViewControllerAnimated:NO];
            }
            else
            {
                if ([API sharedInstance].msg)
                {
                    [self showalertview_text:[API sharedInstance].msg frame:CGRectMake(80, 300, 170, 20) autoHiden:YES];
                }
            }
        });
    });
}

-(void)retrievePSW
{
    ForgetPswViewController* forgetPSView = [[ForgetPswViewController alloc] init];
    [self.navigationController pushViewController:forgetPSView animated:YES];
}

- (NSString *)MD5String:(NSString *)toMD5Str
{
    const char *cstr = [toMD5Str UTF8String];
    unsigned char result[16];
    CC_MD5(cstr, strlen(cstr), result);
    
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

@end