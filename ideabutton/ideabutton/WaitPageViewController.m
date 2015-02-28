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
    // 设定位置和大小
    CGRect frame = CGRectMake(50,50,0,0);
    frame.size = [UIImage imageNamed:@"gif.gif"].size;
    // 读取gif图片数据
    NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"gif" ofType:@"gif"]];
    // view生成
    UIWebView *webView = [[UIWebView alloc] initWithFrame:frame];
    webView.userInteractionEnabled = NO;//用户不可交互
    [webView loadData:gif MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    [self.view addSubview:webView];
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