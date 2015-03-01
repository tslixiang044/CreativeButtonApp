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

#define Height  45

@interface WaitPageViewController()

@property(nonatomic, strong)NSDictionary* myDict;

@end


@implementation WaitPageViewController

-(id)initWithDict:(NSDictionary*)dict
{
    self = [super init];
    if (self)
    {
        self.myDict = dict;
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setrightbaritem_imgname:@"icon_more_all" title:nil];
    
    [self createInputView];
    
    [self createIdea];
    
}
-(void)btnright
{
    [self showMenuView];
}
-(void)createInputView
{
   [self ShowLoadingView];

}

-(void)createIdea
{
    dispatch_queue_t currentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(currentQueue, ^{
        //后台处理代码, 一般 http 请求在这里发, 然后阻塞等待返回, 收到返回处理
        NSArray* ideaArr = [[API sharedInstance]createIdea:self.myDict];
        //处理完上面的后回到主线程去更新UI
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        dispatch_async(mainQueue, ^{
            if ([ideaArr count] != 0)
            {
                [self.navigationController pushViewController:[[IdeaGenerateViewController alloc]initWithData:ideaArr] animated:YES];
            }
        });
    });

}


@end