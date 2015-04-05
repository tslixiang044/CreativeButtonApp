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
#import "ChooseCityViewController.h"

#define Height  45
#define AddHead     1
#define SelectMan   2
#define SelectWonman    3
#define NickNameTag   4
#define MailTag     5

@interface RegisterViewController()<UITextFieldDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    NSInteger gender;
    ChooseCityViewController* chooseCityViewController;
}

@property(nonatomic, strong)UIScrollView *mainScroll;

@property(nonatomic, assign)CGFloat lastScrollOffset;
@property(nonatomic, strong)UITextField *inFocusTextField;

@property(nonatomic, strong)UITextField* nickNameTextField;
@property(nonatomic, strong)UITextField* registerMailTextField;
@property(nonatomic, strong)UITextField* registerPSWTextField;
@property(nonatomic, strong)UITextField* confirmPSWTextField;
@property(nonatomic, strong)UITextField* registerAddressTextField;
@property(nonatomic, strong)UIButton* manBtn;
@property(nonatomic, strong)UIButton* womenBtn;
@property(nonatomic, strong)UILabel* manLabel;
@property(nonatomic, strong)UILabel* womenLabel;
@property(nonatomic, assign)BOOL manSelected;
@property(nonatomic, assign)BOOL womenSelected;

@property(nonatomic, strong)UIButton* nickNameCheckBtn;
@property(nonatomic, strong)UIButton* emailCheckBtn;

@end


@implementation RegisterViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.manSelected = NO;
    self.womenSelected = NO;
    gender = -1;
    
    [self setrightbaritem_imgname:@"icon_more_all" title:nil];
    
    CGFloat contentHeight = 470;
    UIScrollView *mainScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    mainScroll.contentSize = CGSizeMake(320, contentHeight);
    self.mainScroll = mainScroll;
    [self.view addSubview:mainScroll];
    
    UIView *editingView = [self createInputView];
    editingView.frame = CGRectMake(20, 20, 280, contentHeight);
    [mainScroll addSubview:editingView];
    
    //注册键盘通知获取键盘高度
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:self.view.window];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dissMissPickerController:) name:@"dissmissPicker" object:nil];
}
-(void)btnright
{
    [self showMenuView];
}

-(void)dissMissPickerController:(NSNotification*) notify
{
    NSDictionary* userInfo = [notify userInfo];
    
    self.registerAddressTextField.text = [userInfo objectForKey:@"location"];
    
    if (chooseCityViewController)
    {
        [chooseCityViewController.view removeFromSuperview];
        chooseCityViewController = nil;
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.inFocusTextField = textField;

    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.registerAddressTextField)
    {
        [self showCityPicker];
        [textField resignFirstResponder];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (textField.text.length > 0)
    {
        if (textField.tag == NickNameTag)
        {
            dispatch_queue_t currentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_async(currentQueue, ^{
                [[API sharedInstance] isEnabledNickname:@{@"nickname":textField.text}];
                dispatch_queue_t mainQueue = dispatch_get_main_queue();
                dispatch_async(mainQueue, ^{
                    
                    if ([[API sharedInstance].code integerValue] == 0)
                    {
                        [self.nickNameCheckBtn setImage:[UIImage imageNamed:@"register/icon_right"] forState:UIControlStateNormal];
                    }
                    else
                    {
                        [self.nickNameCheckBtn setImage:[UIImage imageNamed:@"register/icon_worong"] forState:UIControlStateNormal];
                    }
                });
            });
        }
        
        if (textField.tag == MailTag)
        {
            
            dispatch_queue_t currentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_async(currentQueue, ^{
                [[API sharedInstance] isEnabledEmail:@{@"email":textField.text}];
                dispatch_queue_t mainQueue = dispatch_get_main_queue();
                dispatch_async(mainQueue, ^{
                    
                    if ([[API sharedInstance].code integerValue] == 0)
                    {
                        [self.emailCheckBtn setImage:[UIImage imageNamed:@"register/icon_right"] forState:UIControlStateNormal];
                    }
                    else
                    {
                        [self.emailCheckBtn setImage:[UIImage imageNamed:@"register/icon_worong"] forState:UIControlStateNormal];
                    }
                });
            });
        }
    }
    
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
    
    if (self.inFocusTextField == self.confirmPSWTextField)
    {
        CGRect inputRect = [self.inFocusTextField.superview convertRect:CGRectMake(0, self.confirmPSWTextField.frame.origin.y, 320, Height) toView:self.view];
        CGFloat inputRectBottomHeight = self.view.frame.size.height - (inputRect.origin.y + Height);
        CGFloat heightDiff = inputRectBottomHeight - keyboardHeight;
        if(heightDiff<0)
        {
            CGFloat newScrollOffset = self.mainScroll.contentOffset.y-heightDiff;
            [self.mainScroll setContentOffset:CGPointMake(0, newScrollOffset) animated:YES];
        }
    }
}

-(UIView*)createInputView
{
    UIView* registerView = [[UIView alloc] init];
    registerView.backgroundColor = [UIColor colorWithRed:21/255.0 green:21/255.0 blue:22/255.0 alpha:1.0];
    
    UIImageView* imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"register/bg_admin_zc_add"]];
    imageView.userInteractionEnabled = YES;
    imageView.frame =  CGRectMake(30, 20, 220, 80);
    [registerView addSubview:imageView];
    
    UIButton* headBtn = [[UIButton alloc] initWithFrame:CGRectMake(25, 10, 65, 60)];
    [headBtn setBackgroundImage:[UIImage imageNamed:@"register/icon_use_add"] forState:UIControlStateNormal];
    [headBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    headBtn.tag = AddHead;
    [imageView addSubview:headBtn];
    
    self.manBtn = [[UIButton alloc] initWithFrame:CGRectMake(140, 20, 25, 25)];
    [self.manBtn setImage:[UIImage imageNamed:@"register/icon_use_man_secle"] forState:UIControlStateNormal];
    [self.manBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.manBtn.tag = SelectMan;
    [imageView addSubview:self.manBtn];
    
    self.manLabel = [[UILabel alloc] initWithFrame:CGRectMake(143, 45, 20, 20)];
    self.manLabel.text = @"男";
    [imageView addSubview:self.manLabel];
    
    self.womenBtn = [[UIButton alloc] initWithFrame:CGRectMake(175, 20, 25, 25)];
    [self.womenBtn setImage:[UIImage imageNamed:@"register/icon_use_women_secle"] forState:UIControlStateNormal];
    [self.womenBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.womenBtn.tag = SelectWonman;
    [imageView addSubview:self.womenBtn];
    
    self.womenLabel = [[UILabel alloc] initWithFrame:CGRectMake(178, 45, 20, 20)];
    self.womenLabel.text = @"女";
    [imageView addSubview:self.womenLabel];
    
    self.nickNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 115, 220, 40)];
    self.nickNameTextField.placeholder = @"昵称(不可修改)";
    self.nickNameTextField.backgroundColor = [UIColor whiteColor];
    self.nickNameTextField.layer.cornerRadius = 5;
    _nickNameTextField.delegate = self;
    self.nickNameTextField.tag = NickNameTag;
    [registerView addSubview:_nickNameTextField];
    
    self.nickNameCheckBtn = [[UIButton alloc] initWithFrame:CGRectMake(255, 125, 20, 20)];
    [registerView addSubview:self.nickNameCheckBtn];
    
    self.registerMailTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 170, 220, 40)];
    _registerMailTextField.delegate = self;
    _registerMailTextField.placeholder = @"邮箱";
    self.registerMailTextField.backgroundColor = [UIColor whiteColor];
    self.registerMailTextField.layer.cornerRadius = 5;
    self.registerMailTextField.tag = MailTag;
    [registerView addSubview:_registerMailTextField];
    
    self.emailCheckBtn = [[UIButton alloc] initWithFrame:CGRectMake(255, 185, 20, 20)];
    [registerView addSubview:self.emailCheckBtn];
    
    self.registerPSWTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 225, 220, 40)];
    _registerPSWTextField.delegate = self;
    _registerPSWTextField.secureTextEntry = YES;
    self.registerPSWTextField.placeholder = @"密码";
    self.registerPSWTextField.backgroundColor = [UIColor whiteColor];
    self.registerPSWTextField.layer.cornerRadius = 5;
    [registerView addSubview:_registerPSWTextField];
    
    self.confirmPSWTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 280, 220, 40)];
    _confirmPSWTextField.delegate = self;
    _confirmPSWTextField.secureTextEntry = YES;
    self.confirmPSWTextField.placeholder = @"确认密码";
    self.confirmPSWTextField.backgroundColor = [UIColor whiteColor];
    self.confirmPSWTextField.layer.cornerRadius = 5;
    [registerView addSubview:_confirmPSWTextField];
    
    self.registerAddressTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 335, 220, 40)];
    self.registerAddressTextField.delegate = self;
    self.registerAddressTextField.placeholder = @"所在地";
    self.registerAddressTextField.backgroundColor = [UIColor whiteColor];
    self.registerAddressTextField.layer.cornerRadius = 5;
    [self.registerAddressTextField addTarget:self action:@selector(showCityPicker) forControlEvents:UIControlEventTouchUpInside];
    [registerView addSubview:self.registerAddressTextField];
    
    UIButton* registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 390, 70, 70)];
    [registerBtn setBackgroundImage:[UIImage imageNamed:@"public/all_btn_zc"] forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(registerAccount) forControlEvents:UIControlEventTouchUpInside];
    [registerView addSubview:registerBtn];
    
    return registerView;
}

-(void)showCityPicker
{
    chooseCityViewController = [[ChooseCityViewController alloc] init];
    [self addChildViewController:chooseCityViewController];
    [self.view addSubview:chooseCityViewController.view];
}

-(void)buttonClicked:(UIButton*)sender
{
    switch (sender.tag)
    {
        case AddHead:
        {
            UIActionSheet *sheet=[[UIActionSheet alloc]initWithTitle:@"上传图像" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil ];
            
            [sheet addButtonWithTitle:@"相册"];
            [sheet addButtonWithTitle:@"拍照"];
            
            [sheet addButtonWithTitle:@"取消"];
            
            sheet.cancelButtonIndex=sheet.numberOfButtons-1;
            
            [sheet showInView:[UIApplication sharedApplication].keyWindow];
            
            
        }
            break;
        case SelectMan:
            if (self.womenSelected)
            {
                self.womenSelected = NO;
                [self.womenBtn setImage:[UIImage imageNamed:@"register/icon_use_women_secle"] forState:UIControlStateNormal];
                [self.womenLabel setTextColor:[UIColor blackColor]];
            }
            
            if (self.manSelected)
            {
                self.manSelected = NO;
                [self.manBtn setImage:[UIImage imageNamed:@"register/icon_use_man_secle"] forState:UIControlStateNormal];
                [self.manLabel setTextColor:[UIColor blackColor]];
            }
            else
            {
                gender = 1;
                self.manSelected = YES;
                [self.manBtn setImage:[UIImage imageNamed:@"register/icon_use_man_secle_on"] forState:UIControlStateNormal];
                [self.manLabel setTextColor:[UIColor redColor]];
            }
            break;
        case SelectWonman:
            if (self.manSelected)
            {
                self.manSelected = NO;
                [self.manBtn setImage:[UIImage imageNamed:@"register/icon_use_man_secle"] forState:UIControlStateNormal];
                [self.manLabel setTextColor:[UIColor blackColor]];
            }
            
            if (self.womenSelected)
            {
                self.womenSelected = NO;
                [self.womenBtn setImage:[UIImage imageNamed:@"register/icon_use_women_secle"] forState:UIControlStateNormal];
                [self.womenLabel setTextColor:[UIColor blackColor]];
            }
            else
            {
                gender = 0;
                self.womenSelected = YES;
                [self.womenBtn setImage:[UIImage imageNamed:@"register/icon_use_women_secle_on"] forState:UIControlStateNormal];
                [self.womenLabel setTextColor:[UIColor redColor]];
            }
            break;
        default:
            break;
    }
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"index=%i",buttonIndex);
    if(buttonIndex==0)
    {
        UIImagePickerController *picker=[[UIImagePickerController alloc] init];
        picker.delegate=self;
        picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:picker animated:YES completion:nil];
    }
    else if(buttonIndex==1)
    {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        {
            UIImagePickerController *picker=[[UIImagePickerController alloc] init];
            picker.delegate=self;
            picker.sourceType=UIImagePickerControllerSourceTypeCamera;
            
            [self presentViewController:picker animated:YES completion:nil];
        }
    }
}
-(void)registerAccount
{
    CGRect frame = CGRectMake(90,380,150,20);
    
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
                [db.indb setData:[user.nickName dataUsingEncoding:NSUTF8StringEncoding] forKey:@"ctrler:login:last-login-name"];
                
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            else
            {
                if ([API sharedInstance].msg)
                {
                    [self showalertview_text:[API sharedInstance].msg frame:frame autoHiden:YES];
                }
            }
        });
    });
}

-(NSDictionary*)invalidateInput
{
    CGRect frame = CGRectMake(90,380,150,20);
    
    if (gender == -1)
    {
        [self showalertview_text:@"请选择性别" frame:frame autoHiden:YES];
        return nil;
    }
    
    if (self.nickNameTextField.text.length == 0)
    {
        [self showalertview_text:@"昵称不能为空" frame:frame autoHiden:YES];
        return nil;
    }
    
    if (self.registerMailTextField.text.length == 0)
    {
        [self showalertview_text:@"邮箱不能为空" frame:frame autoHiden:YES];
        return nil;
    }
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    if(![emailTest evaluateWithObject:self.registerMailTextField.text])
    {
        [self showalertview_text:@"请输入正确的邮箱地址" frame:CGRectMake(90,380,150,20) autoHiden:YES];
        [self.emailCheckBtn setImage:[UIImage imageNamed:@"register/icon_worong"] forState:UIControlStateNormal];
        return nil;
    }
    
    if (self.registerPSWTextField.text.length == 0)
    {
        [self showalertview_text:@"密码不能为空" frame:frame autoHiden:YES];
        return nil;
    }
    
    if (![self.registerPSWTextField.text isEqualToString:self.confirmPSWTextField.text])
    {
        [self showalertview_text:@"两次输入的密码不一致" frame:frame autoHiden:YES];
        return nil;
    }
    
    return @{@"nickname":self.nickNameTextField.text,@"password":self.registerPSWTextField.text,@"gender":@(gender),@"email":self.registerMailTextField.text,@"location":self.registerAddressTextField.text};
}

@end