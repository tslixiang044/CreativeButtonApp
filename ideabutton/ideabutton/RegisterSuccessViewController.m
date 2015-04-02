//
//  RegisterSuccessViewController.m
//  ideabutton
//
//  Created by Li Xiang on 15/3/24.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import "RegisterSuccessViewController.h"

#define PerfectInfoBtnTag       1
#define StartBtnTag             2

@interface RegisterSuccessViewController ()

@end

@implementation RegisterSuccessViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UILabel* describeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 120, 300, 100)];
    describeLabel.textAlignment = NSTextAlignmentCenter;
    if (self.flag == 1)
    {
        describeLabel.text = @"现在你每天可以按出18个idea了,\r继续完善个人资料的话,\r可以按出更多。";
    }
    else if (self.flag == 2)
    {
        describeLabel.text = @"现在每天增加到36个idea了,\r还不过瘾?\r上传有效身份证明。";
    }
    else
    {
        describeLabel.text = @"审核通过以后,\r每天81 idea!\r想想怎么驾驭她们吧。";
    }
    describeLabel.textColor = [UIColor whiteColor];
    describeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    describeLabel.numberOfLines = 0;
    [self.view addSubview:describeLabel];
    
    UIButton* perfectInfoBtn = [[UIButton alloc] initWithFrame:CGRectMake(60, 300, 60, 60)];
    perfectInfoBtn.tag = PerfectInfoBtnTag;
    if (self.flag == 1)
    {
        [perfectInfoBtn setImage:[UIImage imageNamed:@"register/all_btn_ljws"] forState:UIControlStateNormal];
        [perfectInfoBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:perfectInfoBtn];
    }
    else if (self.flag == 2)
    {
        [perfectInfoBtn setImage:[UIImage imageNamed:@"register/btn_ljyz"] forState:UIControlStateNormal];
        [perfectInfoBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:perfectInfoBtn];
    }
    
    
    UIButton* startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (self.flag == 3)
    {
        startBtn.frame = CGRectMake(130, 300, 60, 60);
    }
    else
    {
        startBtn.frame = CGRectMake(200, 300, 60, 60);
    }
    
    [startBtn setImage:[UIImage imageNamed:@"register/all_btn_ljka"] forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    startBtn.tag = StartBtnTag;
    [self.view addSubview:startBtn];
    // Do any additional setup after loading the view.
}

-(void)buttonClick:(UIButton*)sender
{
    switch (sender.tag)
    {
        case PerfectInfoBtnTag:
        {
            if (self.flag == 1)
            {
                
            }
            else if (self.flag == 2)
            {
                
            }
            else
            {
                
            }
        }
            break;
        case StartBtnTag:
        {
            if (self.flag == 1)
            {
                
            }
            else if (self.flag == 2)
            {
                
            }
            else
            {
                
            }
        }
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
