//
//  NumberChooseViewController.m
//  ideabutton
//
//  Created by Li Xiang on 15/2/11.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WaitPageViewController.h"
#import "API.h"
#import "IdeaGenerateViewController.h"
#import "DB.h"
#import "SVProgressHUD.h"

#define Height  45

@interface WaitPageViewController()

@property(nonatomic, strong)NSDictionary* myDict;
@property(nonatomic, strong)NSArray* ideaArr;

@end


@implementation WaitPageViewController

-(id)initWithDict:(NSDictionary*)dict
{
    self = [super init];
    if (self)
    {
        self.myDict = dict;
        
        [self getUserIdeasRemainderNumber];
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = kgettitle;
    
    [self setrightbaritem_imgname:@"icon_more_all" title:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backToPreView:) name:@"returnBack" object:nil];
}

-(void)backToPreView:(NSNotification*)notify
{
    [self performSelector:@selector(back) withObject:nil afterDelay:3];
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)btnright
{
    [self showMenuView];
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
    [self.navigationController pushViewController:[[IdeaGenerateViewController alloc]initWithData:self.ideaArr] animated:YES];
}

- (void)getUserIdeasRemainderNumber
{
    User* user = [[DB sharedInstance]queryUser];
    dispatch_queue_t currentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(currentQueue, ^{
        //后台处理代码, 一般 http 请求在这里发, 然后阻塞等待返回, 收到返回处理
        NSInteger remainderNum = [[API sharedInstance]userIdeasRemainderNumber:@{@"userCode":[NSString stringWithFormat:@"%d",user.userCode]}];
        //处理完上面的后回到主线程去更新UI
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        dispatch_async(mainQueue, ^{
            if (remainderNum > 0)
            {
                [self createIdea];
            }
            else
            {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        });
    });
}

@end