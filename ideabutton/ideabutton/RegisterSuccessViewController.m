//
//  RegisterSuccessViewController.m
//  ideabutton
//
//  Created by Li Xiang on 15/3/24.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import "RegisterSuccessViewController.h"

@interface RegisterSuccessViewController ()

@end

@implementation RegisterSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel* describeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 120, 300, 100)];
    describeLabel.textAlignment = NSTextAlignmentCenter;
    describeLabel.text = @"现在你每天可以按出18个idea了,\r继续完善个人资料的话,\r可以按出更多。";
    describeLabel.textColor = [UIColor whiteColor];
    describeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    describeLabel.numberOfLines = 0;
    [self.view addSubview:describeLabel];
    
    UIButton* perfectInfoBtn = [[UIButton alloc] initWithFrame:CGRectMake(60, 300, 60, 60)];
    [perfectInfoBtn setImage:[UIImage imageNamed:@"register/all_btn_ljws"] forState:UIControlStateNormal];
    [self.view addSubview:perfectInfoBtn];
    
    UIButton* startBtn = [[UIButton alloc] initWithFrame:CGRectMake(200, 300, 60, 60)];
    [startBtn setImage:[UIImage imageNamed:@"register/all_btn_ljka"] forState:UIControlStateNormal];
    [self.view addSubview:startBtn];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
