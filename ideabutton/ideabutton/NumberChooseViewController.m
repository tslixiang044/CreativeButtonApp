//
//  NumberChooseViewController.m
//  ideabutton
//
//  Created by Li Xiang on 15/2/11.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NumberChooseViewController.h"
#import "WaitPageViewController.h"
#import "MyUIButton.h"

#define Height  45

@interface NumberChooseViewController()


@end


@implementation NumberChooseViewController

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
    titleLabel.text = @"你一次可以驾驭多少个idea";
    [self.view addSubview:titleLabel];
    
    UIImageView* view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_interaction_split"]];
    view.frame = CGRectMake(35, 55, 245, 2);
    [self.view addSubview:view];
    
    MyUIButton* button = [[MyUIButton alloc] initWithRoundButton_Frame:CGRectMake(130, 120, 60, 60) bgimg:nil title:@"9"];
    button.backgroundColor = COLOR(205, 38, 33);
    [button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    MyUIButton* button1 = [[MyUIButton alloc] initWithRoundButton_Frame:CGRectMake(130, 210, 60, 60) bgimg:nil title:@"18"];
    button1.backgroundColor = COLOR(205, 38, 33);
    [button1 addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    MyUIButton* button2 = [[MyUIButton alloc] initWithRoundButton_Frame:CGRectMake(130, 300, 60, 60) bgimg:nil title:@"27"];
    button2.backgroundColor = COLOR(205, 38, 33);
    [button2 addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
}

-(void)buttonClicked
{
    [self.navigationController pushViewController:[[WaitPageViewController alloc]init] animated:YES];
}

@end