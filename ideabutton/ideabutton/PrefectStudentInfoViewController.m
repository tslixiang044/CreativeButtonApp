//
//  PrefectStudentInfoViewController.m
//  ideabutton
//
//  Created by Li Xiang on 15/3/24.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import "PrefectStudentInfoViewController.h"
#import "API.h"
//#import "DB.h"
#import "RegisterSuccessView.h"
//#import "APLevelDB.h"
#import "IoccupyViewController.h"
#import "SVProgressHUD.h"
#import "UploadViewController.h"
#import "ZTModel.h"

#define CheckButtonTag1     0
#define CheckButtonTag2     1
#define CheckButtonTag3     2
#define SendCodeBtnTag      3
#define OkButtonTag         4

#define Height  45

@interface PrefectStudentInfoViewController ()<UITextFieldDelegate,UIActionSheetDelegate,RegisterSuccessViewDelegate>

@property(nonatomic, strong)UIScrollView *mainScroll;
@property(nonatomic, assign)CGFloat lastScrollOffset;
@property(nonatomic, strong)UITextField *inFocusTextField;

@end

@implementation PrefectStudentInfoViewController
{
    UITextField* realNameTextField;
    UITextField* schoolNameTextField;
    UITextField* telTextField;
    UITextField* graduationTextField;
    UITextField* codeTextField;
    
    UIButton* checkBtn;
    UIButton* checkBtn1;
    UIButton* checkBtn2;
    
    BOOL checkBtnFlag;
    BOOL checkBtnFlag1;
    BOOL checkBtnFlag2;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = kgettitle;
    
    [self setrightbaritem_imgname:@"icon_more_all" title:nil];
    
    CGFloat contentHeight = 400;
    UIScrollView *mainScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    mainScroll.contentSize = CGSizeMake(320, contentHeight);
    self.mainScroll = mainScroll;
    [self.view addSubview:mainScroll];
    
    UIView *editingView = [self createInputView];
    editingView.frame = CGRectMake(20, 50, 280, contentHeight);
    [mainScroll addSubview:editingView];
    
    //注册键盘通知获取键盘高度
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:self.view.window];
}

- (void)keyboardWillShow:(NSNotification *)noti
{
    NSDictionary* userInfo = [noti userInfo];
    
    CGFloat keyboardHeight = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height+50;
    self.lastScrollOffset = self.mainScroll.contentOffset.y;
    
    if (self.inFocusTextField == codeTextField)
    {
        CGRect inputRect = [self.inFocusTextField.superview convertRect:CGRectMake(0, codeTextField.frame.origin.y, 320, Height) toView:self.view];
        CGFloat inputRectBottomHeight = self.view.frame.size.height - (inputRect.origin.y + Height);
        CGFloat heightDiff = inputRectBottomHeight - keyboardHeight;
        if(heightDiff < 0)
        {
            CGFloat newScrollOffset = self.mainScroll.contentOffset.y-heightDiff;
            [self.mainScroll setContentOffset:CGPointMake(0, newScrollOffset) animated:YES];
        }
    }
}

- (UIView*) createInputView
{
    UIView* backgroundView = [[UIView alloc] initWithFrame:CGRectMake(20, 50, 280, 400)];
    backgroundView.backgroundColor = COLOR(21, 21, 22);
    [self.view addSubview:backgroundView];
    
    UILabel* title = [[UILabel alloc] initWithFrame:CGRectMake(120, 20, 50, 30)];
    title.text = @"学生";
    title.textColor = [UIColor whiteColor];
    [backgroundView addSubview:title];
    
    realNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 60, 200, 35)];
    realNameTextField.placeholder = @"真实姓名";
    realNameTextField.layer.cornerRadius = 5;
    realNameTextField.delegate = self;
    realNameTextField.backgroundColor = [UIColor whiteColor];
    [backgroundView addSubview:realNameTextField];
    
    UILabel* flagLabel = [[UILabel alloc] initWithFrame:CGRectMake(215, 70, 35, 15)];
    flagLabel.textColor = [UIColor whiteColor];
    flagLabel.text = @"不公开";
    flagLabel.font = [UIFont systemFontOfSize:11.5];
    [backgroundView addSubview:flagLabel];
    
    checkBtn = [[UIButton alloc] initWithFrame:CGRectMake(255, 70, 15, 15)];
    checkBtn.tag = CheckButtonTag1;
    [checkBtn setImage:[UIImage imageNamed:@"login/checkbox-unchecked"] forState:UIControlStateNormal];
    [checkBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:checkBtn];
    
    schoolNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 105, 200, 35)];
    schoolNameTextField.placeholder = @"院校简称";
    schoolNameTextField.layer.cornerRadius = 5;
    schoolNameTextField.delegate = self;
    schoolNameTextField.backgroundColor = [UIColor whiteColor];
    [backgroundView addSubview:schoolNameTextField];
    
    UILabel* flagLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(215, 115, 35, 15)];
    flagLabel1.textColor = [UIColor whiteColor];
    flagLabel1.text = @"不公开";
    flagLabel1.font = [UIFont systemFontOfSize:11.5];
    [backgroundView addSubview:flagLabel1];
    
    checkBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(255, 115, 15, 15)];
    checkBtn1.tag = CheckButtonTag2;
    [checkBtn1 setImage:[UIImage imageNamed:@"login/checkbox-unchecked"] forState:UIControlStateNormal];
    [checkBtn1 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:checkBtn1];
    
    graduationTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 150, 200, 35)];
    graduationTextField.placeholder = @"毕业时间";
    graduationTextField.layer.cornerRadius = 5;
    graduationTextField.delegate = self;
    graduationTextField.backgroundColor = [UIColor whiteColor];
    [backgroundView addSubview:graduationTextField];
    
    UILabel* flagLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(215, 160, 35, 15)];
    flagLabel3.textColor = [UIColor whiteColor];
    flagLabel3.text = @"不公开";
    flagLabel3.font = [UIFont systemFontOfSize:11.5];
    [backgroundView addSubview:flagLabel3];
    
    checkBtn2 = [[UIButton alloc] initWithFrame:CGRectMake(255, 160, 15, 15)];
    checkBtn2.tag = CheckButtonTag3;
    [checkBtn2 setImage:[UIImage imageNamed:@"login/checkbox-unchecked"] forState:UIControlStateNormal];
    [checkBtn2 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:checkBtn2];
    
    float x = 0;
    float y = graduationTextField.frame.origin.y + graduationTextField.frame.size.height + 10;
    
    UIImageView* line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"public/line"]];
    line.frame = CGRectMake(0, y, 280, 3);
    [backgroundView addSubview:line];
    
    y = y + 15;
    
    telTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, y, 260, 35)];
    telTextField.placeholder = @"手机(只做验证用)";
    telTextField.layer.cornerRadius = 5;
    telTextField.delegate = self;
    telTextField.backgroundColor = [UIColor whiteColor];
    [backgroundView addSubview:telTextField];
    
    y = telTextField.frame.origin.y + telTextField.frame.size.height + 10;
    
    codeTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, y, 180, 35)];
    codeTextField.placeholder = @"验证码";
    codeTextField.layer.cornerRadius = 5;
    codeTextField.delegate = self;
    codeTextField.backgroundColor = [UIColor whiteColor];
    [backgroundView addSubview:codeTextField];
    
    x = codeTextField.frame.origin.x + codeTextField.frame.size.width + 10;
    
    UIButton* sendCodeBtn = [[UIButton alloc] initWithFrame:CGRectMake(x, y, 70, 35)];
    sendCodeBtn.tag = SendCodeBtnTag;
    sendCodeBtn.layer.cornerRadius = 5;
    sendCodeBtn.backgroundColor = [UIColor lightGrayColor];
    [sendCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [sendCodeBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    sendCodeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [sendCodeBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:sendCodeBtn];
    
    y = sendCodeBtn.frame.origin.y + sendCodeBtn.frame.size.height + 10;
    
    UIImageView* line1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"public/line"]];
    line1.frame = CGRectMake(0, y, 280, 3);
    [backgroundView addSubview:line1];

    UIButton* okBtn = [[UIButton alloc] initWithFrame:CGRectMake(110, y + 20, 60, 60)];
    okBtn.tag = OkButtonTag;
    [okBtn setImage:[UIImage imageNamed:@"register/btn_ok"] forState:UIControlStateNormal];
    [okBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:okBtn];
    
    return backgroundView;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.inFocusTextField = textField;
    //    if ([telTextField isFirstResponder])
    //    {
    //        [majorTextField resignFirstResponder];
    //        [self chooseGraduation];
    //    }
    if (textField == graduationTextField)
    {
        [self chooseGraduation];
    }
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == graduationTextField)
    {
        [textField resignFirstResponder];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    [self.mainScroll setContentOffset:CGPointMake(0, self.lastScrollOffset) animated:YES];
    
    return YES;
}

- (void)chooseGraduation
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"毕业时间"
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:@"2015"
                                                    otherButtonTitles:@"2016", @"2017",@"2018", nil];
    [actionSheet showInView:self.view];
}

- (void)buttonClicked:(UIButton*)sender
{
    switch (sender.tag)
    {
        case CheckButtonTag1:
        {
            if (!checkBtnFlag)
            {
                checkBtnFlag = YES;
                [checkBtn setImage:[UIImage imageNamed:@"login/checkbox-checked"] forState:UIControlStateNormal];
            }
            else
            {
                checkBtnFlag = NO;
                [checkBtn setImage:[UIImage imageNamed:@"login/checkbox-unchecked"] forState:UIControlStateNormal];
            }
            
        }
            break;
        case CheckButtonTag2:
        {
            if (!checkBtnFlag1)
            {
                checkBtnFlag1 = YES;
                [checkBtn1 setImage:[UIImage imageNamed:@"login/checkbox-checked"] forState:UIControlStateNormal];
            }
            else
            {
                checkBtnFlag1 = NO;
                [checkBtn1 setImage:[UIImage imageNamed:@"login/checkbox-unchecked"] forState:UIControlStateNormal];
            }
        }
            break;
        case CheckButtonTag3:
        {
            if (!checkBtnFlag2)
            {
                checkBtnFlag2 = YES;
                [checkBtn2 setImage:[UIImage imageNamed:@"login/checkbox-checked"] forState:UIControlStateNormal];
            }
            else
            {
                checkBtnFlag2 = NO;
                [checkBtn2 setImage:[UIImage imageNamed:@"login/checkbox-unchecked"] forState:UIControlStateNormal];
            }
        }
            break;
            
        case OkButtonTag:
        {
            [self updateUserInfo];
        }
            break;
        default:
            break;
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.cancelButtonIndex)
    {
        return;
    }
    switch (buttonIndex)
    {
        case 0:
        {
            graduationTextField.text = @"2015";
            break;
        }
        case 1:
        {
            graduationTextField.text = @"2016";
            break;
        }
        case 2:
        {
            graduationTextField.text = @"2017";
            break;
        }
        case 3:
        {
            graduationTextField.text = @"2018";
            break;
        }
    }
}

- (void)updateUserInfo
{
    if (realNameTextField.text.length == 0)
    {
        [SVProgressHUD showErrorWithStatus:@"真实姓名不能为空"];
        return;
    }
    
    if (schoolNameTextField.text.length == 0)
    {
        [SVProgressHUD showErrorWithStatus:@"院校简称不能为空"];
        return;
    }
    
    if (graduationTextField.text.length == 0)
    {
        [SVProgressHUD showErrorWithStatus:@"毕业时间不能为空"];
        return;
    }
    
    User *user = [User GetInstance];
    if (user.userCode > 0)
    {
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        dispatch_queue_t currentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(currentQueue, ^{
            //后台处理代码, 一般 http 请求在这里发, 然后阻塞等待返回, 收到返回处理
            User* newUserInfo = [[API sharedInstance] updateUser:@{@"userCode":@(user.userCode),
                                                                   @"userFullName":realNameTextField.text,
                                                                   @"userFullNamePrivate":[NSString stringWithFormat:@"%@",@(checkBtnFlag)],
                                                                   @"carrerType":@(self.carrerType),
                                                                   @"college":schoolNameTextField.text,
                                                                   @"collegePrivate":[NSString stringWithFormat:@"%@",@(checkBtnFlag1)],
                                                                   @"graduationTime":graduationTextField.text,
                                                                   @"graduationTimePrivate":[NSString stringWithFormat:@"%@",@(checkBtnFlag2)]}];
            //处理完上面的后回到主线程去更新UI
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            dispatch_async(mainQueue, ^{
                if ([API sharedInstance].code.integerValue == 0)
                {
                    [SVProgressHUD dismiss];
                    
                    [User setLogin:newUserInfo];
                    NSMutableArray *dataarr=[[NSMutableArray alloc]init];
                    [dataarr addObject:newUserInfo];
                    NSData *mdata = [NSKeyedArchiver archivedDataWithRootObject:dataarr];
                    [[NSUserDefaults standardUserDefaults] setObject:mdata forKey:@"userDataInfo"];
                    [[NSUserDefaults standardUserDefaults] setObject:user.nickName forKey:@"ctrler:login:last-login-name"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                    RegisterSuccessView *suc=[[RegisterSuccessView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenBoundwidth, kMainScreenBoundheight) Flag:2];
                    suc.delegate = self;
                    
                    [[UIApplication sharedApplication].keyWindow addSubview:suc];
                }
                else
                {
                    [SVProgressHUD showErrorWithStatus:[API sharedInstance].msg];
                }
            });
        });
    }
}

- (void)btnright
{
    [self showMenuView];
}

-(void)start
{
    //    IAlsoPressViewController *press=[[IAlsoPressViewController alloc]init];
    //    [self.navigationController pushViewController:press animated:YES];
    IoccupyViewController * controller = [[IoccupyViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
    
}

-(void)perfectInfo
{
    
}

-(void)uploadData
{
    [self.navigationController pushViewController:[[UploadViewController alloc]init] animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
