//
//  PrefectStudentInfoViewController.m
//  ideabutton
//
//  Created by Li Xiang on 15/3/24.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import "PrefectStudentInfoViewController.h"

#define CheckButtonTag1     0
#define CheckButtonTag2     1
#define CheckButtonTag3     2
#define CheckButtonTag4     3
#define CheckButtonTag5     4
#define OkButtonTag         5

@interface PrefectStudentInfoViewController ()<UITextFieldDelegate>

@end

@implementation PrefectStudentInfoViewController
{
    UITextField* realNameTextField;
    UITextField* schoolNameTextField;
    UITextField* majorTextField;
    UITextField* graduationTextField;
    UITextField* repineCompanyTextField;
    
    UIButton* checkBtn;
    UIButton* checkBtn1;
    UIButton* checkBtn2;
    UIButton* checkBtn3;
    UIButton* checkBtn4;
    
    BOOL checkBtnFlag;
    BOOL checkBtnFlag1;
    BOOL checkBtnFlag2;
    BOOL checkBtnFlag3;
    BOOL checkBtnFlag4;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setrightbaritem_imgname:@"icon_more_all" title:nil];
    
    [self createInputView];
    // Do any additional setup after loading the view.
}

- (void) createInputView
{
    UIView* backgroundView = [[UIView alloc] initWithFrame:CGRectMake(20, 50, 280, 400)];
    backgroundView.backgroundColor = COLOR(21, 21, 22);
    [self.view addSubview:backgroundView];
    
    UILabel* title = [[UILabel alloc] initWithFrame:CGRectMake(120, 20, 50, 30)];
    title.text = @"学生";
    title.textColor = [UIColor whiteColor];
    [backgroundView addSubview:title];
    
    realNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 60, 200, 30)];
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
    
    schoolNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 105, 200, 30)];
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
    
    majorTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 150, 200, 30)];
    majorTextField.placeholder = @"专业";
    majorTextField.layer.cornerRadius = 5;
    majorTextField.delegate = self;
    majorTextField.backgroundColor = [UIColor whiteColor];
    [backgroundView addSubview:majorTextField];
    
    UILabel* flagLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(215, 160, 35, 15)];
    flagLabel2.textColor = [UIColor whiteColor];
    flagLabel2.text = @"不公开";
    flagLabel2.font = [UIFont systemFontOfSize:11.5];
    [backgroundView addSubview:flagLabel2];
    
    checkBtn2 = [[UIButton alloc] initWithFrame:CGRectMake(255, 160, 15, 15)];
    checkBtn2.tag = CheckButtonTag3;
    [checkBtn2 setImage:[UIImage imageNamed:@"login/checkbox-unchecked"] forState:UIControlStateNormal];
    [checkBtn2 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:checkBtn2];
    
    graduationTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 195, 200, 30)];
    graduationTextField.placeholder = @"毕业时间";
    graduationTextField.layer.cornerRadius = 5;
    graduationTextField.delegate = self;
    graduationTextField.backgroundColor = [UIColor whiteColor];
    [backgroundView addSubview:graduationTextField];
    
    UILabel* flagLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(215, 205, 35, 15)];
    flagLabel3.textColor = [UIColor whiteColor];
    flagLabel3.text = @"不公开";
    flagLabel3.font = [UIFont systemFontOfSize:11.5];
    [backgroundView addSubview:flagLabel3];
    
    checkBtn3 = [[UIButton alloc] initWithFrame:CGRectMake(255, 205, 15, 15)];
    checkBtn3.tag = CheckButtonTag4;
    [checkBtn3 setImage:[UIImage imageNamed:@"login/checkbox-unchecked"] forState:UIControlStateNormal];
    [checkBtn3 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:checkBtn3];
    
    repineCompanyTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 240, 200, 30)];
    repineCompanyTextField.placeholder = @"向往公司";
    repineCompanyTextField.layer.cornerRadius = 5;
    repineCompanyTextField.delegate = self;
    repineCompanyTextField.backgroundColor = [UIColor whiteColor];
    [backgroundView addSubview:repineCompanyTextField];
    
    UILabel* flagLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(215, 250, 35, 15)];
    flagLabel4.textColor = [UIColor whiteColor];
    flagLabel4.text = @"不公开";
    flagLabel4.font = [UIFont systemFontOfSize:11.5];
    [backgroundView addSubview:flagLabel4];
    
    checkBtn4 = [[UIButton alloc] initWithFrame:CGRectMake(255, 250, 15, 15)];
    checkBtn4.tag = CheckButtonTag5;
    [checkBtn4 setImage:[UIImage imageNamed:@"login/checkbox-unchecked"] forState:UIControlStateNormal];
    [checkBtn4 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:checkBtn4];
    
    UIImageView* line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"public/line"]];
    line.frame = CGRectMake(0, 290, 280, 3);
    [backgroundView addSubview:line];
    
    UIButton* okBtn = [[UIButton alloc] initWithFrame:CGRectMake(110, 315, 60, 60)];
    okBtn.tag = OkButtonTag;
    [okBtn setImage:[UIImage imageNamed:@"register/btn_ok"] forState:UIControlStateNormal];
    [okBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:okBtn];
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
    
//    [self.mainScroll setContentOffset:CGPointMake(0, self.lastScrollOffset) animated:YES];
    
    return YES;
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
        case CheckButtonTag4:
        {
            if (!checkBtnFlag3)
            {
                checkBtnFlag3 = YES;
                [checkBtn3 setImage:[UIImage imageNamed:@"login/checkbox-checked"] forState:UIControlStateNormal];
            }
            else
            {
                checkBtnFlag3 = NO;
                [checkBtn3 setImage:[UIImage imageNamed:@"login/checkbox-unchecked"] forState:UIControlStateNormal];
            }
        }
            break;
        case CheckButtonTag5:
        {
            if (!checkBtnFlag4)
            {
                checkBtnFlag4 = YES;
                [checkBtn4 setImage:[UIImage imageNamed:@"login/checkbox-checked"] forState:UIControlStateNormal];
            }
            else
            {
                checkBtnFlag4 = NO;
                [checkBtn4 setImage:[UIImage imageNamed:@"login/checkbox-unchecked"] forState:UIControlStateNormal];
            }
        }
            break;
        case OkButtonTag:
            
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
