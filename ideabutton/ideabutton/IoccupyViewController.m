//
//  IoccupyViewController.m
//  ideabutton
//
//  Created by Xiang Li on 15-2-9.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import "IoccupyViewController.h"
#import "ProContentViewController.h"
#import "MyUIButton.h"

#define PrintAdBtnTag   100
#define InteractionAdBtnTag 101
#define VideoAdBtnTag   102
#define MarketingBtnTag   103

@interface IoccupyViewController ()

@end

@implementation IoccupyViewController
@synthesize delegate;


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"我霸占的";
    
    UILabel* describeLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 30, 180, 30)];
    describeLabel.textColor = [UIColor whiteColor];
    describeLabel.text = @"按什么,有什么";
    [self.view addSubview:describeLabel];
    
    UIImageView* view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ideaRuleChoose/line_bg"]];
    view.frame = CGRectMake(0, 70, 320, 1);
    [self.view addSubview:view];
    
    UIButton* printAdBtn = [[UIButton alloc] initWithFrame:CGRectMake(130, 120, 50, 50)];
    [printAdBtn setImage:[UIImage imageNamed:@"ideaRuleChoose/btn_pmgg"] forState:UIControlStateNormal];
    [printAdBtn addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
    printAdBtn.tag = PrintAdBtnTag;
    [self.view addSubview:printAdBtn];
    
    UILabel* printAdLabel = [[UILabel alloc] initWithFrame:CGRectMake(130, 175, 70, 20)];
    printAdLabel.text = @"平面广告";
    printAdLabel.font = [UIFont systemFontOfSize:14];
    printAdLabel.textColor = [UIColor lightGrayColor];
    [self.view addSubview:printAdLabel];
    
    UIButton* videoAdBtn = [[UIButton alloc] initWithFrame:CGRectMake(130, 230, 50, 50)];
    [videoAdBtn setImage:[UIImage imageNamed:@"btn_video"] forState:UIControlStateNormal];
    [videoAdBtn addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
    videoAdBtn.tag = VideoAdBtnTag;
    [self.view addSubview:videoAdBtn];
    
    UILabel* videoAdLabel = [[UILabel alloc] initWithFrame:CGRectMake(130, 285, 70, 20)];
    videoAdLabel.text = @"视频广告";
    videoAdLabel.font = [UIFont systemFontOfSize:14];
    videoAdLabel.textColor = [UIColor lightGrayColor];
    [self.view addSubview:videoAdLabel];
    
    UIButton* marketingBtn = [[UIButton alloc] initWithFrame:CGRectMake(130, 340, 50, 50)];
    [marketingBtn setImage:[UIImage imageNamed:@"ideaRuleChoose/btn_sjyx1"] forState:UIControlStateNormal];
    [marketingBtn addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:marketingBtn];
    
    UILabel* marketingLabel = [[UILabel alloc] initWithFrame:CGRectMake(130, 395, 70, 20)];
    marketingLabel.text = @"事件营销";
    marketingLabel.font = [UIFont systemFontOfSize:14];
    marketingLabel.textColor = [UIColor lightGrayColor];
    [self.view addSubview:marketingLabel];
}

-(void)buttonSelected:(UIButton*)sender
{
    switch (sender.tag)
    {
        case PrintAdBtnTag:

//              if(delegate)
              {
                  ProContentViewController *pro= [[ProContentViewController alloc]initWithDict:@{@"adtype":@"1"}];
//                  [delegate gotoviewcontroller_Ioccupy:pro];
                  [self.navigationController pushViewController:pro animated:YES];
                  
              }
            break;
        case VideoAdBtnTag:
            
            break;
        case MarketingBtnTag:
            
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

-(void)btnleft
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
