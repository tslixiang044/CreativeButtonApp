//
//  PerfectInfoViewController.m
//  ideabutton
//
//  Created by Li Xiang on 15/3/24.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import "PerfectInfoViewController.h"
#import "PrefectStudentInfoViewController.h"

@interface PerfectInfoViewController ()

@end

@implementation PerfectInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setrightbaritem_imgname:@"icon_more_all" title:nil];
    
    [self createInputView];
    
    // Do any additional setup after loading the view.
}

- (void)createInputView
{
    UIView* backgroundView = [[UIView alloc] initWithFrame:CGRectMake(20, 80, 280, 300)];
    backgroundView.backgroundColor = COLOR(21, 21, 22);
    [self.view addSubview:backgroundView];
    
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 20, 100, 30)];
    titleLabel.text = @"完善资料";
    titleLabel.textColor = [UIColor whiteColor];
    [backgroundView addSubview:titleLabel];
    
    UIImageView* line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"public/line"]];
    line.frame = CGRectMake(0, 60, 280, 3);
    [backgroundView addSubview:line];
    
    UIButton* studentBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 60, 60)];
    [studentBtn setBackgroundImage:[UIImage imageNamed:@"public/bg_btn_lx_on"] forState:UIControlStateNormal];
    [studentBtn setTitle:@"学生" forState:UIControlStateNormal];
    [studentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [studentBtn addTarget:self action:@selector(show) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:studentBtn];
    
    UIButton* AdBtn = [[UIButton alloc] initWithFrame:CGRectMake(180, 100, 60, 60)];
    [AdBtn setBackgroundImage:[UIImage imageNamed:@"public/bg_btn_lx"] forState:UIControlStateNormal];
    [AdBtn setTitle:@"广告人" forState:UIControlStateNormal];
    [AdBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backgroundView addSubview:AdBtn];
    
    UIButton* AdLeaderBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 200, 60, 60)];
    [AdLeaderBtn setBackgroundImage:[UIImage imageNamed:@"public/bg_btn_lx"] forState:UIControlStateNormal];
    [AdLeaderBtn setTitle:@"广告主" forState:UIControlStateNormal];
    [AdLeaderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backgroundView addSubview:AdLeaderBtn];
    
    UIButton* freePeopleBtn = [[UIButton alloc] initWithFrame:CGRectMake(180, 200, 60, 60)];
    [freePeopleBtn setBackgroundImage:[UIImage imageNamed:@"public/bg_btn_lx"] forState:UIControlStateNormal];
    [freePeopleBtn setTitle:@"自由人" forState:UIControlStateNormal];
    [freePeopleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backgroundView addSubview:freePeopleBtn];
}

-(void)btnright
{
    [self showMenuView];
}

- (void)show
{
    PrefectStudentInfoViewController* infoViewController = [[PrefectStudentInfoViewController alloc] init];
    infoViewController.carrerType = 0;
    [self.navigationController pushViewController:infoViewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
