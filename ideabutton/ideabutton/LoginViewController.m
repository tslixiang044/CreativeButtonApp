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

@interface LoginViewController ()<UITextFieldDelegate>

@property(nonatomic, strong)UITextField* loginNameTextField;
@property(nonatomic, strong)UITextField* loginPSWTextField;

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
-(void)btnright
{
    [self showMenuView];
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
    User* user = [[DB sharedInstance]queryUser];
    
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
    
    self.loginNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 5, 145, 30)];
    _loginNameTextField.delegate = self;
    _loginNameTextField.placeholder = @"邮箱/手机/QQ";
    _loginNameTextField.keyboardType = UIKeyboardTypeDefault;
    
    DB *db = [DB sharedInstance];
    NSData *lastLoginNameData = [db.indb dataForKey:@"ctrler:login:last-login-name"];
    NSString *lastLoginName = [[NSString alloc]initWithData:lastLoginNameData encoding:NSUTF8StringEncoding];
    _loginNameTextField.text = lastLoginName;
    
    [loginNameView addSubview:_loginNameTextField];
    
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
    
    self.loginPSWTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 5, 145, 30)];
    _loginPSWTextField.delegate = self;
    _loginPSWTextField.secureTextEntry = YES;
    if (user)
    {
        self.agreementChecked = user.rememberPSW;
        
        if (self.agreementChecked)
        {
            self.loginPSWTextField.text = user.password;
        }
    }
    [loginPSWView addSubview:_loginPSWTextField];
    
    UIButton *checkboxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    checkboxBtn.frame = CGRectMake(20, 140, 20, 20);
    if (!self.agreementChecked)
    {
        [checkboxBtn setImage:[UIImage imageNamed:@"checkbox-unchecked"] forState:UIControlStateNormal];
        [checkboxBtn addTarget:self action:@selector(checkboxClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        [checkboxBtn setImage:[UIImage imageNamed:@"checkbox-checked"] forState:UIControlStateNormal];
        [checkboxBtn addTarget:self action:@selector(checkboxClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
//    [loginView addSubview:checkboxBtn];   //暂时屏蔽
    
    UILabel* rememberPSWLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 138, 60, 25)];
    rememberPSWLabel.textColor = [UIColor whiteColor];
    rememberPSWLabel.font = [UIFont systemFontOfSize:14];
    rememberPSWLabel.text = @"记住密码";
//    [loginView addSubview:rememberPSWLabel];  //暂时屏蔽
    
    UIButton* forgetPSWBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetPSWBtn.frame = CGRectMake(200, 138, 60, 25);
    forgetPSWBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [forgetPSWBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetPSWBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginView addSubview:forgetPSWBtn];
    
    UIButton* loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(90, 200, 100, 50)];
    loginBtn.layer.cornerRadius = 5;
    loginBtn.backgroundColor = COLOR(124, 96, 33);
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [loginView addSubview:loginBtn];
    
    UIImageView* line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line"]];
    line.frame = CGRectMake(0, 280, 280, 5);
    [loginView addSubview:line];
    
    UIButton* cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 310, 100, 50)];
    cancelBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    cancelBtn.layer.borderWidth = 1.0;
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [loginView addSubview:cancelBtn];
    
    UIButton* registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(160, 310, 100, 50)];
    registerBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    registerBtn.layer.borderWidth = 1.0;
    [registerBtn setTitle:@"我要注册" forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(showRegisterViewController) forControlEvents:UIControlEventTouchUpInside];
    [loginView addSubview:registerBtn];
}

-(void)showRegisterViewController
{
    RegisterViewController* registerView = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerView animated:YES];
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)login:(id)sender
{
    [self.loginNameTextField resignFirstResponder];
    [self.loginPSWTextField resignFirstResponder];
    
    if (self.loginNameTextField.text.length == 0)
    {
        [self showalertview_text:@"用户名不能为空" imgname:@"error" autoHiden:YES];
        return;
    }
    
    if (self.loginPSWTextField.text.length == 0)
    {
        [self showalertview_text:@"密码不能为空" imgname:@"error" autoHiden:YES];
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
            
            if (self.agreementChecked)
            {
                user.rememberPSW = YES;
                user.password = self.loginPSWTextField.text;
            }
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
                IAlsoPressViewController *press=[[IAlsoPressViewController alloc]init];
                [self.navigationController pushViewController:press animated:YES];
                
            }
            else
            {
                [self showalertview_text:[API sharedInstance].msg imgname:@"error" autoHiden:YES];
            }
        });
    });
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