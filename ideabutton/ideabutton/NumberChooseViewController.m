//
//  NumberChooseViewController.m
//  ideabutton
//
//  Created by Li Xiang on 15/2/11.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NumberChooseViewController.h"
#import "MyUIButton.h"
#import "API.h"
//#import "DB.h"
#import "ZTModel.h"
#import "IdeaGenerateViewController.h"
#import "SVProgressHUD.h"

#define Height  45

@interface NumberChooseViewController()
{
    NSInteger   remainderNum;
}

@property(nonatomic, strong)NSMutableDictionary* myDict;
@property(nonatomic, strong)NSArray* ideaArr;

@end


@implementation NumberChooseViewController

-(id)initWithDict:(NSDictionary*)dict
{
    self = [super init];
    if (self)
    {
        self.myDict = [[NSMutableDictionary alloc] initWithDictionary:dict];
        
        User *user = [User GetInstance];
        
        //        User* user = [[DB sharedInstance]queryUser];
        dispatch_queue_t currentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(currentQueue, ^{
            //后台处理代码, 一般 http 请求在这里发, 然后阻塞等待返回, 收到返回处理
            remainderNum = [[API sharedInstance]userIdeasRemainderNumber:@{@"userCode":[NSString stringWithFormat:@"%ld",(long)user.userCode]}];
            //处理完上面的后回到主线程去更新UI
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            dispatch_async(mainQueue, ^{
                
            });
        });
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
    titleLabel.text = @"你一次可以驾驭多少个idea";
    [self.view addSubview:titleLabel];
    
    UIImageView* view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ideaRuleChoose/line_bg"]];
    view.frame = CGRectMake(38, 55, 245, 1);
    [self.view addSubview:view];
    
    UIButton* NumNineBtn = [[UIButton alloc] initWithFrame:CGRectMake(130, 120, 60, 60)];
    NumNineBtn.tag = 18;
    [NumNineBtn setImage:[UIImage imageNamed:@"ideaRuleChoose/btn_muber09"] forState:UIControlStateNormal];
    [NumNineBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:NumNineBtn];
    
    UIButton* NumeighteenBtn = [[UIButton alloc] initWithFrame:CGRectMake(130, 230, 60, 60)];
    NumeighteenBtn.tag = 36;
    [NumeighteenBtn setImage:[UIImage imageNamed:@"ideaRuleChoose/btn_muber18"] forState:UIControlStateNormal];
    [NumeighteenBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:NumeighteenBtn];
    
    UIButton* NumTwentySevenBtn = [[UIButton alloc] initWithFrame:CGRectMake(130, 340, 60, 60)];
    NumTwentySevenBtn.tag = 81;
    [NumTwentySevenBtn setImage:[UIImage imageNamed:@"ideaRuleChoose/btn_muber27"] forState:UIControlStateNormal];
    [NumTwentySevenBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:NumTwentySevenBtn];
}

-(void)createIdea
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    dispatch_queue_t currentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(currentQueue, ^{
        //后台处理代码, 一般 http 请求在这里发, 然后阻塞等待返回, 收到返回处理
        self.ideaArr = [[API sharedInstance]createIdea:self.myDict];
        //处理完上面的后回到主线程去更新UI
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        dispatch_async(mainQueue, ^{
            if ([self.ideaArr count] != 0)
            {
                [SVProgressHUD dismiss];
                
                [self ShowLoadingView];
                
                [self performSelector:@selector(showController) withObject:nil afterDelay:3];
            }
            else
            {
                [SVProgressHUD showErrorWithStatus:[API sharedInstance].msg];
            }
        });
    });
}

-(void) showController
{
    [self hidenLoadingView];
    
    [self.navigationController pushViewController:[[IdeaGenerateViewController alloc]initWithData:self.ideaArr] animated:YES];
}

-(void)buttonClicked:(UIButton*)sender
{
    User *user = [User GetInstance];

    if (remainderNum > 0)
    {
        if (sender.tag == 36)
        {
            if (user)
            {
                if (user.userLevel == 1)
                {
                    [self showAlertView_desc:@"就知道18个满足不了你,\n去完善个人资料可看到更多idea" btnImage:@"bg_btn_wszl_on" btnHideFlag:NO ActionType:3];
                    
                    return;
                }
            }
        }
        else if(sender.tag == 81)
        {
            if (user.userLevel == 1)
            {
                [self showAlertView_desc:@"就知道18个满足不了你,\n去完善个人资料可看到更多idea" btnImage:@"bg_btn_wszl_on" btnHideFlag:NO ActionType:3];
                
                return;
            }
            else if (user.userLevel == 2)
            {
                if (user.auditStatus == 0)
                {
                    [self showAlertView_desc:@"就知道36个满足不了你,\n去上传实名认证可看到更多idea" btnImage:@"bg_btn_wyrz_on" btnHideFlag:NO ActionType:3];
                    
                    return;
                }
                else
                {
                    [self showAlertView_desc:@"实名认证资料正在审核中,\n审核通过后每日可免费浏览81个idea" btnImage:@"bg_btn_hd_on" btnHideFlag:NO ActionType:3];
                    
                    return;
                }
            }
        }
        
        if (sender.tag <= remainderNum)
        {
            [self.myDict setValue:[NSString stringWithFormat:@"%ld",(long)sender.tag] forKey:@"ideaNum"];
        }
        else
        {
            [self.myDict setValue:[NSString stringWithFormat:@"%ld",(long)remainderNum] forKey:@"ideaNum"];
        }
        
        [self createIdea];
    }
    else
    {
        if (user.nickName.length > 0)
        {
            if (user.userLevel == 1)
            {
                [self showAlertView_desc:@"就知道18个满足不了你,\n去完善个人资料可看到更多idea" btnImage:@"bg_btn_wszl_on" btnHideFlag:NO ActionType:3];
            }
            else if (user.userLevel == 2)
            {
                if (user.auditStatus == 0)
                {
                    [self showAlertView_desc:@"就知道36个满足不了你,\n去上传实名认证可看到更多idea" btnImage:@"bg_btn_wyrz_on" btnHideFlag:NO ActionType:3];
                }
                else
                {
                    [self showAlertView_desc:@"实名认证资料正在审核中,\n审核通过后可看到更多idea" btnImage:@"bg_btn_hd_on" btnHideFlag:NO ActionType:3];
                }
            }
            else
            {
                [self showAlertView_desc:@"今日81个免费已用完,请明日再来!" btnImage:@"all_btn_qd" btnHideFlag:NO ActionType:3];
            }
        }
    }
}

@end