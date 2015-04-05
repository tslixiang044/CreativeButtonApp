//
//  IdeaGenerateViewController.m
//  ideabutton
//
//  Created by Li Xiang on 15/2/12.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IdeaGenerateViewController.h"
#import "InteractivePageViewController.h"
#import "DB.h"
#import "API.h"
#import "SVProgressHUD.h"
#import "ReformIdeaViewController.h"

#define HoggedBtnTag    0
#define CollectionBtnTag    1
#define TransformBtnTag 2
#define NextBtnTag  3
#define DoAgianBtnTag   4
#define PreviousBtnTag  5

@interface IdeaGenerateViewController()
{
    NSInteger IdeaNumCount;
    NSInteger belongMeIdeaNum;
    NSInteger index;
    NSInteger titleNumber;
    
    UILabel* detailLabel;
    
    UIButton* hoggedBtn;
    UIButton* collectionBtn;
    UIButton* transformBtn;
    UIButton* doAgianBtn;
    UILabel* surplusNumLabel;
    UIButton* previousBtn;
    UIButton* nextBtn;
}
@property(nonatomic, strong)NSArray* data;
@property(nonatomic, strong)NSMutableDictionary* dict;

@end


@implementation IdeaGenerateViewController

-(id)initWithData:(NSArray*)dataArr
{
    self = [super init];
    if (self)
    {
        self.data = dataArr;
        belongMeIdeaNum = [dataArr count];
        index = 0;
        titleNumber = 1;
        NSInteger ideaCount = [[[DB sharedInstance] queryArbitraryObjectWithKey:@"balanceIdea"] integerValue];
        if ( ideaCount > 0)
        {
            IdeaNumCount = ideaCount;
        }
        else
        {
            IdeaNumCount = 80;
        }
        
        self.dict = [[NSMutableDictionary alloc] init];
        [self.dict setValue:[[self.data objectAtIndex:0] objectForKey:@"adtype"] forKey:@"adtype"];
        [self.dict setValue:[[self.data objectAtIndex:0] objectForKey:@"appeal"] forKey:@"appeal"];
        [self.dict setValue:[[self.data objectAtIndex:0] objectForKey:@"brand"] forKey:@"brand"];
        [self.dict setValue:[[self.data objectAtIndex:0] objectForKey:@"product"] forKey:@"product"];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeButtonTitle:) name:@"reformIdeaSuccess" object:nil];
    
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
    UIImageView* backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ideaCreate/connet_bg"]];
    backgroundView.frame = CGRectMake(40, 50, 240, 160);
    [self.view addSubview:backgroundView];
    
    previousBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 50, 25, 160)];
    [previousBtn setImage:[UIImage imageNamed:@"ideaCreate/icon_left"] forState:UIControlStateNormal];
    [previousBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    previousBtn.tag = PreviousBtnTag;
    previousBtn.hidden = YES;
    [self.view addSubview:previousBtn];
    
    detailLabel = [[UILabel alloc] initWithFrame:backgroundView.frame];
    detailLabel.layer.borderColor = COLOR(142, 142, 142).CGColor;
    detailLabel.layer.borderWidth = 1.0;
    detailLabel.lineBreakMode = NSLineBreakByWordWrapping;
    detailLabel.numberOfLines = 0;
    detailLabel.font = [UIFont systemFontOfSize:16];
    detailLabel.text = [NSString stringWithFormat:@"  %d. %@",titleNumber,[[self.data objectAtIndex:index] objectForKey:@"sentence"]];
    detailLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:detailLabel];
    
    surplusNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 209, 240, 30)];
    surplusNumLabel.layer.borderColor = COLOR(142, 142, 142).CGColor;
    surplusNumLabel.layer.borderWidth = 1.0;
    surplusNumLabel.backgroundColor = COLOR(47, 44, 43);
    surplusNumLabel.text = @"今日剩余N个";
    surplusNumLabel.textColor = [UIColor whiteColor];
    surplusNumLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:surplusNumLabel];
    
    doAgianBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 209, 120, 30)];
    [doAgianBtn setBackgroundImage:[UIImage imageNamed:@"ideaCreate/btn_bg_hong"] forState:UIControlStateNormal];
    [doAgianBtn setTitle:@"再来一轮" forState:UIControlStateNormal];
    [doAgianBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    doAgianBtn.tag = DoAgianBtnTag;
    doAgianBtn.hidden = YES;
    [self.view addSubview:doAgianBtn];
    
    nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(285, 50, 25, 160)];
    [nextBtn setImage:[UIImage imageNamed:@"ideaCreate/icon_right"] forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    nextBtn.tag = NextBtnTag;
    [self.view addSubview:nextBtn];
    
    hoggedBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, 270, 70, 70)];
    [hoggedBtn setImage:[UIImage imageNamed:@"ideaCreate/btn_wybz"] forState:UIControlStateNormal];
    hoggedBtn.tag = HoggedBtnTag;
    [hoggedBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:hoggedBtn];
    
    collectionBtn = [[UIButton alloc] initWithFrame:CGRectMake(125, 270, 70, 70)];
    [collectionBtn setImage:[UIImage imageNamed:@"ideaCreate/btn_wygz"] forState:UIControlStateNormal];
    collectionBtn.tag = CollectionBtnTag;
    [collectionBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:collectionBtn];
    
    transformBtn = [[UIButton alloc] initWithFrame:CGRectMake(210, 270, 70, 70)];
    [transformBtn setImage:[UIImage imageNamed:@"ideaCreate/btn_wysc"] forState:UIControlStateNormal];
    transformBtn.tag = TransformBtnTag;
    [transformBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:transformBtn];
}

-(void)changeButtonTitle:(NSNotification*)notify
{
    [hoggedBtn setTitle:@"我已霸占" forState:UIControlStateNormal];
    [transformBtn setTitle:@"我已改造" forState:UIControlStateNormal];
}

-(void)buttonClick:(UIButton*)sender
{
    [self.dict setValue:[[self.data objectAtIndex:index] objectForKey:@"algorithmRule"] forKey:@"algorithmRule"];
    switch (sender.tag)
    {
        case HoggedBtnTag:
        {
            [self occupyIdea];
        }
            break;
        case CollectionBtnTag:
        {
            [self collectIdea];
        }
            break;
        case TransformBtnTag:
        {
            [self.navigationController pushViewController:[[ReformIdeaViewController alloc]initWithDict:self.dict] animated:YES];
        }
            break;
        case NextBtnTag:
            if (IdeaNumCount > 0)
            {
                if (index < belongMeIdeaNum - 1)
                {
                    index++;
                    
                    detailLabel.text = [NSString stringWithFormat:@"  %d. %@",++titleNumber,[[self.data objectAtIndex:index] objectForKey:@"sentence"]];
                }
                else
                {
                    [[DB sharedInstance] saveArbitraryObject:[NSString stringWithFormat:@"%d",IdeaNumCount] withKey:@"balanceIdea"];
                    InteractivePageViewController* pageViewController = [[InteractivePageViewController alloc]initWithDict:self.dict];
                    [self.navigationController pushViewController:pageViewController animated:YES];
                }
            }
            else
            {
                [self showAlertView_desc:@"今天免费产生的idea数量已达上限81" btntitle:@"明天再来"  ];
                            }
            
            break;
            
        default:
            break;
    }
}

-(void)occupyIdea
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    dispatch_queue_t currentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(currentQueue, ^{
        //后台处理代码, 一般 http 请求在这里发, 然后阻塞等待返回, 收到返回处理
        NSString* occupyIdeaID = [[API sharedInstance] occupyIdea:@{@"algorithmRule":[self.dict objectForKey:@"algorithmRule"],@"sentence":detailLabel.text,@"adtype":[self.dict objectForKey:@"adtype"],@"product":[self.dict objectForKey:@"product"]}];
        //处理完上面的后回到主线程去更新UI
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        dispatch_async(mainQueue, ^{
            [SVProgressHUD dismiss];
            if (occupyIdeaID)
            {
//                [self showalertview_text:@"创意霸占成功" imgname:nil autoHiden:YES];
                [hoggedBtn setTitle:@"我已霸占" forState:UIControlStateNormal];
            }
            else
            {
//                [self showalertview_text:@"创意霸占失败" imgname:@"error" autoHiden:YES];
            }
        });
    });
}

-(void)collectIdea
{
    [SVProgressHUD showWithStatus:@"正在收藏" maskType:SVProgressHUDMaskTypeClear];
    dispatch_queue_t currentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(currentQueue, ^{
        //后台处理代码, 一般 http 请求在这里发, 然后阻塞等待返回, 收到返回处理
        NSString* collectIdeaID = [[API sharedInstance] collectIdea:@{@"algorithmRule":[self.dict objectForKey:@"algorithmRule"],@"sentence":detailLabel.text,@"adtype":[self.dict objectForKey:@"adtype"],@"product":[self.dict objectForKey:@"product"]}];
        //处理完上面的后回到主线程去更新UI
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        dispatch_async(mainQueue, ^{
            [SVProgressHUD dismiss];
            if (collectIdeaID)
            {
//                [self showalertview_text:@"创意收藏成功" imgname:nil autoHiden:YES];
                [collectionBtn setTitle:@"我已收藏" forState:UIControlStateNormal];
            }
            else
            {
//                [self showalertview_text:@"创意收藏失败" imgname:@"error" autoHiden:YES];
            }
        });
    });
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end