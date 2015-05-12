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
    
    self.title = kgettitle;
    
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
    
    UIImageView* view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ideaRuleChoose/line_bg"]];
    view.frame = CGRectMake(38, 55, 245, 1);
    [self.view addSubview:view];
    
    UIButton* NumNineBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, 120, 60, 60)];
    NumNineBtn.tag = 9;
    [NumNineBtn setImage:[UIImage imageNamed:@"ideaRuleChoose/btn_jiu"] forState:UIControlStateNormal];
    [NumNineBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:NumNineBtn];
    
    UIButton* NumSevenBtn = [[UIButton alloc] initWithFrame:CGRectMake(130, 120, 60, 60)];
    NumSevenBtn.tag = 7;
    [NumSevenBtn setImage:[UIImage imageNamed:@"ideaRuleChoose/btn_qi"] forState:UIControlStateNormal];
    [NumSevenBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:NumSevenBtn];
    
    UIButton* NumSixBtn = [[UIButton alloc] initWithFrame:CGRectMake(220, 120, 60, 60)];
    NumSixBtn.tag = 6;
    [NumSixBtn setImage:[UIImage imageNamed:@"ideaRuleChoose/btn_liu"] forState:UIControlStateNormal];
    [NumSixBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:NumSixBtn];
    
    UIButton* NumEightBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, 210, 60, 60)];
    NumEightBtn.tag = 8;
    [NumEightBtn setImage:[UIImage imageNamed:@"ideaRuleChoose/btn_ba"] forState:UIControlStateNormal];
    [NumEightBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:NumEightBtn];
    
    UIButton* NumTwoBtn = [[UIButton alloc] initWithFrame:CGRectMake(130, 210, 60, 60)];
    NumTwoBtn.tag = 2;
    [NumTwoBtn setImage:[UIImage imageNamed:@"ideaRuleChoose/btn_er"] forState:UIControlStateNormal];
    [NumTwoBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:NumTwoBtn];
    
    UIButton* NumFiveBtn = [[UIButton alloc] initWithFrame:CGRectMake(220, 210, 60, 60)];
    NumFiveBtn.tag = 5;
    [NumFiveBtn setImage:[UIImage imageNamed:@"ideaRuleChoose/btn_wu"] forState:UIControlStateNormal];
    [NumFiveBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:NumFiveBtn];
    
    UIButton* NumOneBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, 300, 60, 60)];
    NumOneBtn.tag = 1;
    [NumOneBtn setImage:[UIImage imageNamed:@"ideaRuleChoose/btn_yi"] forState:UIControlStateNormal];
    [NumOneBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:NumOneBtn];
    
    UIButton* NumThreeBtn = [[UIButton alloc] initWithFrame:CGRectMake(130, 300, 60, 60)];
    NumThreeBtn.tag = 3;
    [NumThreeBtn setImage:[UIImage imageNamed:@"ideaRuleChoose/btn_san"] forState:UIControlStateNormal];
    [NumThreeBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:NumThreeBtn];
    
    UIButton* NumFourBtn = [[UIButton alloc] initWithFrame:CGRectMake(220, 300, 60, 60)];
    NumFourBtn.tag = 4;
    [NumFourBtn setImage:[UIImage imageNamed:@"ideaRuleChoose/btn_si"] forState:UIControlStateNormal];
    [NumFourBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:NumFourBtn];
}

-(void)buttonClicked:(UIButton*)sender
{
    [self.myDict setValue:[NSString stringWithFormat:@"%ld",(long)sender.tag] forKey:@"number"];
    [self.navigationController pushViewController:[[NumberChooseViewController alloc]initWithDict:self.myDict] animated:YES];
}

@end