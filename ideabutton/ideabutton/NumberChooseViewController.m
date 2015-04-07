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

@property(nonatomic, strong)NSMutableDictionary* myDict;

@end


@implementation NumberChooseViewController

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
    titleLabel.text = @"你一次可以驾驭多少个idea";
    [self.view addSubview:titleLabel];
    
    UIImageView* view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ideaRuleChoose/line_bg"]];
    view.frame = CGRectMake(38, 55, 245, 1);
    [self.view addSubview:view];
    
    UIButton* NumNineBtn = [[UIButton alloc] initWithFrame:CGRectMake(130, 120, 60, 60)];
    NumNineBtn.tag = 9;
    [NumNineBtn setImage:[UIImage imageNamed:@"ideaRuleChoose/btn_muber09"] forState:UIControlStateNormal];
    [NumNineBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:NumNineBtn];
    
    UIButton* NumeighteenBtn = [[UIButton alloc] initWithFrame:CGRectMake(130, 210, 60, 60)];
    NumeighteenBtn.tag = 18;
    [NumeighteenBtn setImage:[UIImage imageNamed:@"ideaRuleChoose/btn_muber18"] forState:UIControlStateNormal];
    [NumeighteenBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:NumeighteenBtn];
    
    UIButton* NumTwentySevenBtn = [[UIButton alloc] initWithFrame:CGRectMake(130, 300, 60, 60)];
    NumTwentySevenBtn.tag = 27;
    [NumTwentySevenBtn setImage:[UIImage imageNamed:@"ideaRuleChoose/btn_muber27"] forState:UIControlStateNormal];
    [NumTwentySevenBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:NumTwentySevenBtn];
}

-(void)buttonClicked:(UIButton*)sender
{
    [self.myDict setValue:[NSString stringWithFormat:@"%d",sender.tag] forKey:@"ideaNum"];
    [self.navigationController pushViewController:[[WaitPageViewController alloc]initWithDict:self.myDict] animated:YES];
}

@end