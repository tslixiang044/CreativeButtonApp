//
//  InteractivePageViewController1.m
//  ideabutton
//
//  Created by Li Xiang on 15/2/11.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InteractivePageViewController1.h"
#import "InteractivePageViewController2.h"
#import "MyUIButton.h"

#define Height  45

@interface InteractivePageViewController1()


@end


@implementation InteractivePageViewController1

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
    titleLabel.text = @"字母决定组合手法，请慎重点";
    [self.view addSubview:titleLabel];
    
    UIImageView* view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_interaction_split"]];
    view.frame = CGRectMake(35, 55, 245, 2);
    [self.view addSubview:view];
    
    MyUIButton* button = [[MyUIButton alloc] initWithRoundButton_Frame:CGRectMake(40, 120, 60, 60) bgimg:nil title:@"F"];
    button.backgroundColor = COLOR(205, 38, 33);
    [button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    MyUIButton* button1 = [[MyUIButton alloc] initWithRoundButton_Frame:CGRectMake(130, 120, 60, 60) bgimg:nil title:@"E"];
    button1.backgroundColor = COLOR(205, 38, 33);
    [button1 addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    MyUIButton* button2 = [[MyUIButton alloc] initWithRoundButton_Frame:CGRectMake(220, 120, 60, 60) bgimg:nil title:@"D"];
    button2.backgroundColor = COLOR(205, 38, 33);
    [button2 addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    MyUIButton* button3 = [[MyUIButton alloc] initWithRoundButton_Frame:CGRectMake(40, 210, 60, 60) bgimg:nil title:@"G"];
    button3.backgroundColor = COLOR(205, 38, 33);
    [button3 addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    
    MyUIButton* button4 = [[MyUIButton alloc] initWithRoundButton_Frame:CGRectMake(130, 210, 60, 60) bgimg:nil title:@"B"];
    button4.backgroundColor = COLOR(205, 38, 33);
    [button4 addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button4];
    
    MyUIButton* button5 = [[MyUIButton alloc] initWithRoundButton_Frame:CGRectMake(220, 210, 60, 60) bgimg:nil title:@"C"];
    button5.backgroundColor = COLOR(205, 38, 33);
    [button5 addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button5];
    
    MyUIButton* button6 = [[MyUIButton alloc] initWithRoundButton_Frame:CGRectMake(40, 300, 60, 60) bgimg:nil title:@"I"];
    button6.backgroundColor = COLOR(205, 38, 33);
    [button6 addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button6];
    
    MyUIButton* button7 = [[MyUIButton alloc] initWithRoundButton_Frame:CGRectMake(130, 300, 60, 60) bgimg:nil title:@"H"];
    button7.backgroundColor = COLOR(205, 38, 33);
    [button7 addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button7];
    
    MyUIButton* button8 = [[MyUIButton alloc] initWithRoundButton_Frame:CGRectMake(220, 300, 60, 60) bgimg:nil title:@"A"];
    button8.backgroundColor = COLOR(205, 38, 33);
    [button8 addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button8];
}

-(void)buttonClicked
{
    [self.navigationController pushViewController:[[InteractivePageViewController2 alloc]init] animated:YES];
}

@end