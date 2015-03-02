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
#define PrCampaignBtnTag   103
#define AudioAdBtnTag   104
#define MediaCreateBtnTag   105

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
    
    UIView* line = [[UIView alloc] initWithFrame:CGRectMake(0, 70, 320, 2)];
    line.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:line];
    
    MyUIButton* printAdBtn = [[MyUIButton alloc] initWithRoundButton_Frame:CGRectMake(50, 100, 70, 70) bgimg:nil title:nil];
    printAdBtn.backgroundColor = COLOR(205, 38, 33);
    [printAdBtn setImage:[UIImage imageNamed:@"btn_icon_plane"] forState:UIControlStateNormal];
    printAdBtn.tag = PrintAdBtnTag;
    [printAdBtn addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:printAdBtn];
    
    UILabel* printAdLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 170, 80, 30)];
    printAdLabel.textColor = [UIColor whiteColor];
    printAdLabel.text = @"平面广告";
    [self.view addSubview:printAdLabel];
    
    MyUIButton* interactionAdBtn = [[MyUIButton alloc] initWithRoundButton_Frame:CGRectMake(190, 100, 70, 70) bgimg:nil title:nil];
    interactionAdBtn.backgroundColor = COLOR(205, 38, 33);
    [interactionAdBtn setImage:[UIImage imageNamed:@"btn_icon_hdym"] forState:UIControlStateNormal];
    interactionAdBtn.tag = InteractionAdBtnTag;
    [interactionAdBtn addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:interactionAdBtn];
    
    UILabel* interactionAdLabel = [[UILabel alloc] initWithFrame:CGRectMake(195, 170, 80, 30)];
    interactionAdLabel.textColor = [UIColor whiteColor];
    interactionAdLabel.text = @"互动广告";
    [self.view addSubview:interactionAdLabel];
    
    MyUIButton* videoAdBtn = [[MyUIButton alloc] initWithRoundButton_Frame:CGRectMake(50, 220, 70, 70) bgimg:nil title:nil];
    videoAdBtn.backgroundColor = COLOR(205, 38, 33);
    [videoAdBtn setImage:[UIImage imageNamed:@"btn_icon_camera"] forState:UIControlStateNormal];
    videoAdBtn.tag = VideoAdBtnTag;
    [videoAdBtn addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:videoAdBtn];
    
    UILabel* videoAdLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 290, 80, 30)];
    videoAdLabel.textColor = [UIColor whiteColor];
    videoAdLabel.text = @"视频广告";
    [self.view addSubview:videoAdLabel];
    
    MyUIButton* prCampaignBtn = [[MyUIButton alloc] initWithRoundButton_Frame:CGRectMake(190, 220, 70, 70) bgimg:nil title:nil];
    prCampaignBtn.backgroundColor = COLOR(205, 38, 33);
    [prCampaignBtn setImage:[UIImage imageNamed:@"btn_icon_gghd"] forState:UIControlStateNormal];
    prCampaignBtn.tag = PrCampaignBtnTag;
    [prCampaignBtn addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:prCampaignBtn];
    
    UILabel* prCampaignLabel = [[UILabel alloc] initWithFrame:CGRectMake(195, 290, 80, 30)];
    prCampaignLabel.textColor = [UIColor whiteColor];
    prCampaignLabel.text = @"公关活动";
    [self.view addSubview:prCampaignLabel];
    
    MyUIButton* audioAdBtn = [[MyUIButton alloc] initWithRoundButton_Frame:CGRectMake(50, 340, 70, 70) bgimg:nil title:nil];
    audioAdBtn.backgroundColor = COLOR(205, 38, 33);
    [audioAdBtn setImage:[UIImage imageNamed:@"btn_icon_suona"] forState:UIControlStateNormal];
    audioAdBtn.tag = AudioAdBtnTag;
    [audioAdBtn addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:audioAdBtn];
    
    UILabel* audioAdLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 410, 80, 30)];
    audioAdLabel.textColor = [UIColor whiteColor];
    audioAdLabel.text = @"音频广告";
    [self.view addSubview:audioAdLabel];
    
    MyUIButton* mediaCreateBtn = [[MyUIButton alloc] initWithRoundButton_Frame:CGRectMake(190, 340, 70, 70) bgimg:nil title:nil];
    mediaCreateBtn.backgroundColor = COLOR(205, 38, 33);
    [mediaCreateBtn setImage:[UIImage imageNamed:@"btn_icon_shouji"] forState:UIControlStateNormal];
    mediaCreateBtn.tag = MediaCreateBtnTag;
    [mediaCreateBtn addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mediaCreateBtn];
    
    UILabel* mediaCreateLabel = [[UILabel alloc] initWithFrame:CGRectMake(195, 410, 80, 30)];
    mediaCreateLabel.textColor = [UIColor whiteColor];
    mediaCreateLabel.text = @"媒体创新";
    [self.view addSubview:mediaCreateLabel];
}

-(void)buttonSelected:(UIButton*)sender
{
    switch (sender.tag)
    {
        case PrintAdBtnTag:

              if(delegate)
              {
                  ProContentViewController *pro= [[ProContentViewController alloc]initWithDict:@{@"adtype":@"1"}];
                  [delegate gotoviewcontroller_Ioccupy:pro];
                  
              }
            break;
        case InteractionAdBtnTag:
            
            break;
        case VideoAdBtnTag:
            
            break;
        case PrCampaignBtnTag:
            
            break;
        case AudioAdBtnTag:
            
            break;
        case MediaCreateBtnTag:
            
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
