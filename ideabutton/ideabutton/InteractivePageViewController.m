//
//  InteractivePageViewController.m
//  ideabutton
//
//  Created by Li Xiang on 15/2/11.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InteractivePageViewController.h"
#import "InteractivePageViewController1.h"
#import "MyUIButton.h"

#define Height  45

@interface InteractivePageViewController()

@property (nonatomic, strong)NSMutableDictionary* myDict;

@end


@implementation InteractivePageViewController

-(id)initWithDict:(NSDictionary*)dict
{
    self = [super init];
    if (self)
    {
        self.myDict = [[NSMutableDictionary alloc] initWithDictionary:dict];
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
    titleLabel.text = @"数字决定创意类型，想好再按";
    [self.view addSubview:titleLabel];
    
    UIImageView* view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ideaRuleChoose/line_bg"]];
    view.frame = CGRectMake(38, 55, 245, 1);
    [self.view addSubview:view];
    
    UIButton* NumOneBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, 120, 60, 60)];
    NumOneBtn.titleLabel.text = @"1";
    [NumOneBtn setImage:[UIImage imageNamed:@"ideaRuleChoose/btn_muber1"] forState:UIControlStateNormal];
    [NumOneBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:NumOneBtn];
    
    UIButton* NumEightBtn = [[UIButton alloc] initWithFrame:CGRectMake(130, 120, 60, 60)];
    NumEightBtn.titleLabel.text = @"8";
    [NumEightBtn setImage:[UIImage imageNamed:@"ideaRuleChoose/btn_muber8"] forState:UIControlStateNormal];
    [NumEightBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:NumEightBtn];
    
    UIButton* NumNineBtn = [[UIButton alloc] initWithFrame:CGRectMake(220, 120, 60, 60)];
    NumNineBtn.titleLabel.text = @"9";
    [NumNineBtn setImage:[UIImage imageNamed:@"ideaRuleChoose/btn_muber9"] forState:UIControlStateNormal];
    [NumNineBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:NumNineBtn];
    
    UIButton* NumThreeBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, 230, 60, 60)];
    NumThreeBtn.titleLabel.text = @"3";
    [NumThreeBtn setImage:[UIImage imageNamed:@"ideaRuleChoose/btn_muber3"] forState:UIControlStateNormal];
    [NumThreeBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:NumThreeBtn];
    
    UIButton* NumTwoBtn = [[UIButton alloc] initWithFrame:CGRectMake(130, 230, 60, 60)];
    NumTwoBtn.titleLabel.text = @"2";
    [NumTwoBtn setImage:[UIImage imageNamed:@"ideaRuleChoose/btn_muber2"] forState:UIControlStateNormal];
    [NumTwoBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:NumTwoBtn];
    
    UIButton* NumSevenBtn = [[UIButton alloc] initWithFrame:CGRectMake(220, 230, 60, 60)];
    NumSevenBtn.titleLabel.text = @"7";
    [NumSevenBtn setImage:[UIImage imageNamed:@"ideaRuleChoose/btn_muber7"] forState:UIControlStateNormal];
    [NumSevenBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:NumSevenBtn];
    
    UIButton* NumFourBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, 340, 60, 60)];
    NumFourBtn.titleLabel.text = @"4";
    [NumFourBtn setImage:[UIImage imageNamed:@"ideaRuleChoose/btn_muber4"] forState:UIControlStateNormal];
    [NumFourBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:NumFourBtn];
    
    UIButton* NumFiveBtn = [[UIButton alloc] initWithFrame:CGRectMake(130, 340, 60, 60)];
    NumFiveBtn.titleLabel.text = @"5";
    [NumFiveBtn setImage:[UIImage imageNamed:@"ideaRuleChoose/btn_muber5"] forState:UIControlStateNormal];
    [NumFiveBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:NumFiveBtn];
    
    UIButton* NumSixBtn = [[UIButton alloc] initWithFrame:CGRectMake(220, 340, 60, 60)];
    NumSixBtn.titleLabel.text = @"6";
    [NumSixBtn setImage:[UIImage imageNamed:@"ideaRuleChoose/btn_muber6"] forState:UIControlStateNormal];
    [NumSixBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:NumSixBtn];
}

-(void)buttonClicked:(UIButton*)sender
{
    [self.myDict setValue:sender.titleLabel.text forKey:@"romanNum"];
    [self.navigationController pushViewController:[[InteractivePageViewController1 alloc]initWithDict:self.myDict] animated:YES];
}

@end