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
#import "MyUIButton.h"

#define Height  45

@interface InteractivePageViewController2()

@property(nonatomic, strong)NSMutableDictionary* myDict;

@end


@implementation InteractivePageViewController2

-(id)initWithDict:(NSDictionary*)dict
{
    self = [super init];
    if (self)
    {
        self.myDict = [[NSMutableDictionary alloc]initWithDictionary:dict];
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setrightbaritem_imgname:@"icon_more_all" title:nil];
    
    [self createInputView];
    
}
-(void)btnright
{
    [self showMenuView];
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
    
    MyUIButton* button = [[MyUIButton alloc] initWithRoundButton_Frame:CGRectMake(40, 120, 60, 60) bgimg:nil title:@"玖"];
    button.backgroundColor = COLOR(205, 38, 33);
    button.tag = 9;
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    MyUIButton* button1 = [[MyUIButton alloc] initWithRoundButton_Frame:CGRectMake(130, 120, 60, 60) bgimg:nil title:@"柒"];
    button1.backgroundColor = COLOR(205, 38, 33);
    button1.tag = 7;
    [button1 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    MyUIButton* button2 = [[MyUIButton alloc] initWithRoundButton_Frame:CGRectMake(220, 120, 60, 60) bgimg:nil title:@"陆"];
    button2.backgroundColor = COLOR(205, 38, 33);
    button2.tag = 6;
    [button2 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    MyUIButton* button3 = [[MyUIButton alloc] initWithRoundButton_Frame:CGRectMake(40, 210, 60, 60) bgimg:nil title:@"捌"];
    button3.backgroundColor = COLOR(205, 38, 33);
    button3.tag = 8;
    [button3 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    
    MyUIButton* button4 = [[MyUIButton alloc] initWithRoundButton_Frame:CGRectMake(130, 210, 60, 60) bgimg:nil title:@"贰"];
    button4.backgroundColor = COLOR(205, 38, 33);
    button4.tag = 2;
    [button4 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button4];
    
    MyUIButton* button5 = [[MyUIButton alloc] initWithRoundButton_Frame:CGRectMake(220, 210, 60, 60) bgimg:nil title:@"伍"];
    button5.backgroundColor = COLOR(205, 38, 33);
    button5.tag = 5;
    [button5 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button5];
    
    MyUIButton* button6 = [[MyUIButton alloc] initWithRoundButton_Frame:CGRectMake(40, 300, 60, 60) bgimg:nil title:@"壹"];
    button6.backgroundColor = COLOR(205, 38, 33);
    button6.tag = 1;
    [button6 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button6];
    
    MyUIButton* button7 = [[MyUIButton alloc] initWithRoundButton_Frame:CGRectMake(130, 300, 60, 60) bgimg:nil title:@"叁"];
    button7.backgroundColor = COLOR(205, 38, 33);
    button7.tag = 3;
    [button7 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button7];
    
    MyUIButton* button8 = [[MyUIButton alloc] initWithRoundButton_Frame:CGRectMake(220, 300, 60, 60) bgimg:nil title:@"肆"];
    button8.backgroundColor = COLOR(205, 38, 33);
    button8.tag = 4;
    [button8 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button8];
}

-(void)buttonClicked:(UIButton*)sender
{
    [self.myDict setValue:[NSString stringWithFormat:@"%d",sender.tag] forKey:@"number"];
    [self.navigationController pushViewController:[[NumberChooseViewController alloc]initWithDict:self.myDict] animated:YES];
}

@end