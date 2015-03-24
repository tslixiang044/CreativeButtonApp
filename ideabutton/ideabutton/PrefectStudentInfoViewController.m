//
//  PrefectStudentInfoViewController.m
//  ideabutton
//
//  Created by Li Xiang on 15/3/24.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import "PrefectStudentInfoViewController.h"

@interface PrefectStudentInfoViewController ()<UITextFieldDelegate>

@end

@implementation PrefectStudentInfoViewController
{
    UITextField* realNameTextField;
    UITextField* schoolNameTextField;
    UITextField* majorTextField;
    UITextField* graduationTextField;
    UITextField* repineCompanyTextField;
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
    
    UIButton* checkBtn = [[UIButton alloc] initWithFrame:CGRectMake(255, 70, 15, 15)];
    [checkBtn setImage:[UIImage imageNamed:@"login/checkbox-unchecked"] forState:UIControlStateNormal];
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
    
    UIButton* checkBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(255, 115, 15, 15)];
    [checkBtn1 setImage:[UIImage imageNamed:@"login/checkbox-unchecked"] forState:UIControlStateNormal];
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
    
    UIButton* checkBtn2 = [[UIButton alloc] initWithFrame:CGRectMake(255, 160, 15, 15)];
    [checkBtn2 setImage:[UIImage imageNamed:@"login/checkbox-unchecked"] forState:UIControlStateNormal];
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
    
    UIButton* checkBtn3 = [[UIButton alloc] initWithFrame:CGRectMake(255, 205, 15, 15)];
    [checkBtn3 setImage:[UIImage imageNamed:@"login/checkbox-unchecked"] forState:UIControlStateNormal];
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
    
    UIButton* checkBtn4 = [[UIButton alloc] initWithFrame:CGRectMake(255, 250, 15, 15)];
    [checkBtn4 setImage:[UIImage imageNamed:@"login/checkbox-unchecked"] forState:UIControlStateNormal];
    [backgroundView addSubview:checkBtn4];
    
    UIImageView* line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"public/line"]];
    line.frame = CGRectMake(0, 290, 280, 3);
    [backgroundView addSubview:line];
    
    UIButton* okBtn = [[UIButton alloc] initWithFrame:CGRectMake(110, 315, 60, 60)];
    [okBtn setImage:[UIImage imageNamed:@"register/btn_ok"] forState:UIControlStateNormal];
    [backgroundView addSubview:okBtn];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
//    [self.mainScroll setContentOffset:CGPointMake(0, self.lastScrollOffset) animated:YES];
    
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
