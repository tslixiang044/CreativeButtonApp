//
//  InteractivePageViewController2.m
//  ideabutton
//
//  Created by Li Xiang on 15/2/11.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InteractivePageViewController2.h"
#import "NumberChooseViewController.h"

#define Height  45

@interface InteractivePageViewController2()


@end


@implementation InteractivePageViewController2

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setrightbaritem_imgname:@"icon_more_all" title:nil];
    
    [self createInputView];
    
}

-(void)createInputView
{
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 20, 240, 30)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"汉字决定运算规则，来吧来吧";
    [self.view addSubview:titleLabel];
    
    UIImageView* view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_interaction_split"]];
    view.frame = CGRectMake(35, 55, 245, 2);
    [self.view addSubview:view];
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(40, 120, 60, 60);
    [button setBackgroundImage:[UIImage imageNamed:@"btn_bg"] forState:UIControlStateNormal];
    [button setTitle:@"玖" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton* button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(130, 120, 60, 60);
    [button1 setBackgroundImage:[UIImage imageNamed:@"btn_bg"] forState:UIControlStateNormal];
    [button1 setTitle:@"柒" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    UIButton* button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(220, 120, 60, 60);
    [button2 setBackgroundImage:[UIImage imageNamed:@"btn_bg"] forState:UIControlStateNormal];
    [button2 setTitle:@"陆" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    UIButton* button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    button3.frame = CGRectMake(40, 210, 60, 60);
    [button3 setBackgroundImage:[UIImage imageNamed:@"btn_bg"] forState:UIControlStateNormal];
    [button3 setTitle:@"捌" forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    
    UIButton* button4 = [UIButton buttonWithType:UIButtonTypeCustom];
    button4.frame = CGRectMake(130, 210, 60, 60);
    [button4 setBackgroundImage:[UIImage imageNamed:@"btn_bg"] forState:UIControlStateNormal];
    [button4 setTitle:@"贰" forState:UIControlStateNormal];
    [button4 addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button4];
    
    UIButton* button5 = [UIButton buttonWithType:UIButtonTypeCustom];
    button5.frame = CGRectMake(220, 210, 60, 60);
    [button5 setBackgroundImage:[UIImage imageNamed:@"btn_bg"] forState:UIControlStateNormal];
    [button5 setTitle:@"伍" forState:UIControlStateNormal];
    [button5 addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button5];
    
    UIButton* button6 = [UIButton buttonWithType:UIButtonTypeCustom];
    button6.frame = CGRectMake(40, 300, 60, 60);
    [button6 setBackgroundImage:[UIImage imageNamed:@"btn_bg"] forState:UIControlStateNormal];
    [button6 setTitle:@"壹" forState:UIControlStateNormal];
    [button6 addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button6];
    
    UIButton* button7 = [UIButton buttonWithType:UIButtonTypeCustom];
    button7.frame = CGRectMake(130, 300, 60, 60);
    [button7 setBackgroundImage:[UIImage imageNamed:@"btn_bg"] forState:UIControlStateNormal];
    [button7 setTitle:@"叁" forState:UIControlStateNormal];
    [button7 addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button7];
    
    UIButton* button8 = [UIButton buttonWithType:UIButtonTypeCustom];
    button8.frame = CGRectMake(220, 300, 60, 60);
    [button8 setBackgroundImage:[UIImage imageNamed:@"btn_bg"] forState:UIControlStateNormal];
    [button8 setTitle:@"肆" forState:UIControlStateNormal];
    [button8 addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button8];
}

-(void)buttonClicked
{
    [self.navigationController pushViewController:[[NumberChooseViewController alloc]init] animated:YES];
}

@end