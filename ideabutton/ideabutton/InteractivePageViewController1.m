//
//  InteractivePageViewController1.m
//  ideabutton
//
//  Created by Li Xiang on 15/2/11.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InteractivePageViewController1.h"
#import "MyUIButton.h"
#import "NumberChooseViewController.h"

#define Height  45

@interface InteractivePageViewController1()

@property (nonatomic, strong)NSMutableDictionary* myDict;

@end


@implementation InteractivePageViewController1

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
    titleLabel.text = @"字母决定组合手法，请慎重点";
    [self.view addSubview:titleLabel];
    
    UIImageView* view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ideaRuleChoose/line_bg"]];
    view.frame = CGRectMake(38, 55, 245, 1);
    [self.view addSubview:view];
    
    UIButton* F_Btn = [[UIButton alloc] initWithFrame:CGRectMake(40, 120, 60, 60)];
    F_Btn.titleLabel.text = @"F";
    [F_Btn setImage:[UIImage imageNamed:@"ideaRuleChoose/btn_f"] forState:UIControlStateNormal];
    [F_Btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:F_Btn];
    
    UIButton* E_Btn = [[UIButton alloc] initWithFrame:CGRectMake(130, 120, 60, 60)];
    E_Btn.titleLabel.text = @"E";
    [E_Btn setImage:[UIImage imageNamed:@"ideaRuleChoose/btn_e"] forState:UIControlStateNormal];
    [E_Btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:E_Btn];
    
    UIButton* D_Btn = [[UIButton alloc] initWithFrame:CGRectMake(220, 120, 60, 60)];
    D_Btn.titleLabel.text = @"D";
    [D_Btn setImage:[UIImage imageNamed:@"ideaRuleChoose/btn_d"] forState:UIControlStateNormal];
    [D_Btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:D_Btn];
    
    UIButton* G_Btn = [[UIButton alloc] initWithFrame:CGRectMake(40, 210, 60, 60)];
    G_Btn.titleLabel.text = @"G";
    [G_Btn setImage:[UIImage imageNamed:@"ideaRuleChoose/btn_g"] forState:UIControlStateNormal];
    [G_Btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:G_Btn];
    
    UIButton* B_Btn = [[UIButton alloc] initWithFrame:CGRectMake(130, 210, 60, 60)];
    B_Btn.titleLabel.text = @"B";
    [B_Btn setImage:[UIImage imageNamed:@"ideaRuleChoose/btn_b"] forState:UIControlStateNormal];
    [B_Btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:B_Btn];
    
    UIButton* C_Btn = [[UIButton alloc] initWithFrame:CGRectMake(220, 210, 60, 60)];
    C_Btn.titleLabel.text = @"C";
    [C_Btn setImage:[UIImage imageNamed:@"ideaRuleChoose/btn_c"] forState:UIControlStateNormal];
    [C_Btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:C_Btn];
    
    UIButton* I_Btn = [[UIButton alloc] initWithFrame:CGRectMake(40, 300, 60, 60)];
    [I_Btn setImage:[UIImage imageNamed:@"ideaRuleChoose/btn_i"] forState:UIControlStateNormal];
    [I_Btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:I_Btn];
    
    UIButton* H_Btn = [[UIButton alloc] initWithFrame:CGRectMake(130, 300, 60, 60)];
    H_Btn.titleLabel.text = @"H";
    [H_Btn setImage:[UIImage imageNamed:@"ideaRuleChoose/btn_h"] forState:UIControlStateNormal];
    [H_Btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:H_Btn];
    
    UIButton* A_Btn = [[UIButton alloc] initWithFrame:CGRectMake(220, 300, 60, 60)];
    A_Btn.titleLabel.text = @"A";
    [A_Btn setImage:[UIImage imageNamed:@"ideaRuleChoose/btn_a"] forState:UIControlStateNormal];
    [A_Btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:A_Btn];
}

-(void)buttonClicked:(UIButton*)sender
{
    [self.myDict setValue:sender.titleLabel.text forKey:@"letter"];
    [self.navigationController pushViewController:[[NumberChooseViewController alloc]initWithDict:self.myDict] animated:YES];
}

@end