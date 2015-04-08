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
    NSInteger remainderNum;
    
    UILabel* detailLabel;
    
    UIButton* hoggedBtn;
    UIButton* collectionBtn;
    UIButton* transformBtn;
    UIButton* doAgianBtn;
    UILabel* surplusNumLabel;
    UIButton* previousBtn;
    UIButton* nextBtn;
    
    NSString* reformID;
    NSString* occupyID;
    NSString* collectID;
}
@property(nonatomic, strong)NSMutableArray* data;
@property(nonatomic, strong)NSMutableDictionary* dict;

@end


@implementation IdeaGenerateViewController

-(id)initWithData:(NSArray*)dataArr
{
    self = [super init];
    if (self)
    {
        self.data = [[NSMutableArray alloc] initWithArray:dataArr];
        belongMeIdeaNum = [dataArr count];
        index = 0;
        titleNumber = 1;
        
        reformID = @"0";
        occupyID = @"0";
        collectID = @"0";
        
        [self getRemainderNum];
        
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
    surplusNumLabel.text =[NSString stringWithFormat:@"今日剩余%d个",remainderNum];
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
    nextBtn.hidden = NO;
    [self.view addSubview:nextBtn];
    
    hoggedBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, 300, 70, 70)];
    [hoggedBtn setImage:[UIImage imageNamed:@"ideaCreate/btn_wybz"] forState:UIControlStateNormal];
    hoggedBtn.tag = HoggedBtnTag;
    [hoggedBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:hoggedBtn];
    
    collectionBtn = [[UIButton alloc] initWithFrame:CGRectMake(125, 300, 70, 70)];
    [collectionBtn setImage:[UIImage imageNamed:@"ideaCreate/btn_wysc"] forState:UIControlStateNormal];
    collectionBtn.tag = CollectionBtnTag;
    [collectionBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:collectionBtn];
    
    transformBtn = [[UIButton alloc] initWithFrame:CGRectMake(210, 300, 70, 70)];
    [transformBtn setImage:[UIImage imageNamed:@"ideaCreate/btn_wygz"] forState:UIControlStateNormal];
    transformBtn.tag = TransformBtnTag;
    [transformBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:transformBtn];
}

-(void)changeButtonTitle:(NSNotification*)notify
{
    NSDictionary* userInfo = [notify userInfo];
    
    if (userInfo)
    {
        occupyID = [userInfo objectForKey:@"occupyID"];
        hoggedBtn.enabled = NO;
        [hoggedBtn setImage:[UIImage imageNamed:@"ideaCreate/btn_wybz_on"] forState:UIControlStateDisabled];
    }
    else
    {
        hoggedBtn.enabled = NO;
        [hoggedBtn setImage:[UIImage imageNamed:@"ideaCreate/btn_wybz_on"] forState:UIControlStateDisabled];
        
        transformBtn.enabled = NO;
        [transformBtn setImage:[UIImage imageNamed:@"ideaCreate/btn_wygz_on"] forState:UIControlStateDisabled];
    }
}

-(void)buttonClick:(UIButton*)sender
{
    [self.dict setValue:[[self.data objectAtIndex:index] objectForKey:@"algorithmRule"] forKey:@"algorithmRule"];
    [self.dict setValue:[[self.data objectAtIndex:index] objectForKey:@"sentence"] forKey:@"sentence"];
    switch (sender.tag)
    {
        case HoggedBtnTag:
        {
           [self.navigationController pushViewController:[[ReformIdeaViewController alloc]initWithDict:self.dict Type:1] animated:YES];
        }
            break;
        case CollectionBtnTag:
        {
            if (collectID.integerValue == 0)
            {
                [self collectIdea];
            }
        }
            break;
        case TransformBtnTag:
        {
            if (!hoggedBtn.enabled || !collectionBtn.enabled)
            {
                [self.dict setValue:@(2) forKey:@"type"];
                
                if (occupyID.integerValue > 0)
                {
                    [self.dict setObject:occupyID forKey:@"occupyID"];
                }
                
                if (collectID.integerValue > 0)
                {
                    [self.dict setObject:collectID forKey:@"collectID"];
                }
            }
            else
            {
                [self.dict setValue:@(1) forKey:@"type"];
            }
            [self.navigationController pushViewController:[[ReformIdeaViewController alloc]initWithDict:self.dict Type:2] animated:YES];
        }
            break;
        case NextBtnTag:
            if (remainderNum > 0)
            {
                if (index < belongMeIdeaNum - 1)
                {
                    index++;
                    
                    [self hasIdeaBeenUsed];
                    
                    [self updateLog];
                    
                    previousBtn.hidden = NO;
                    
                    detailLabel.text = [NSString stringWithFormat:@"  %d. %@",++titleNumber,[[self.data objectAtIndex:index] objectForKey:@"sentence"]];
                }
                else
                {
                    nextBtn.hidden = YES;
                    
                    [[DB sharedInstance] saveArbitraryObject:[NSString stringWithFormat:@"%d",remainderNum] withKey:@"balanceIdea"];
                    InteractivePageViewController* pageViewController = [[InteractivePageViewController alloc]initWithDict:self.dict];
                    [self.navigationController pushViewController:pageViewController animated:YES];
                }
            }
    
            break;
        case PreviousBtnTag:
        {
            if (index > 0)
            {
                index--;

                [self hasIdeaBeenUsed];
                
                detailLabel.text = [NSString stringWithFormat:@"  %d. %@",--titleNumber,[[self.data objectAtIndex:index] objectForKey:@"sentence"]];
                
                if (index == 0)
                {
                    previousBtn.hidden = YES;
                }
            }
        }
            break;
            
        default:
            break;
    }
}

-(void)collectIdea
{
    [SVProgressHUD showWithStatus:@"正在收藏" maskType:SVProgressHUDMaskTypeClear];
    dispatch_queue_t currentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(currentQueue, ^{
        //后台处理代码, 一般 http 请求在这里发, 然后阻塞等待返回, 收到返回处理
        [[API sharedInstance] collectIdea:@{@"algorithmRule":[self.dict objectForKey:@"algorithmRule"],@"sentence":[[self.data objectAtIndex:index] objectForKey:@"sentence"],@"adtype":[self.dict objectForKey:@"adtype"],@"product":[self.dict objectForKey:@"product"]}];
        //处理完上面的后回到主线程去更新UI
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        dispatch_async(mainQueue, ^{
            if ([API sharedInstance].code.integerValue == 0)
            {
                collectionBtn.enabled = NO;
                [SVProgressHUD showSuccessWithStatus:@"您每天可以收藏9条idea"];
                [collectionBtn setImage:[UIImage imageNamed:@"ideaCreate/btn_wysc_on"] forState:UIControlStateDisabled];
            }
            else
            {
                [SVProgressHUD showErrorWithStatus:[API sharedInstance].msg];
            }
        });
    });
}

-(void)getRemainderNum
{
    User* user = [[DB sharedInstance]queryUser];
    dispatch_queue_t currentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(currentQueue, ^{
        //后台处理代码, 一般 http 请求在这里发, 然后阻塞等待返回, 收到返回处理
        remainderNum = [[API sharedInstance]userIdeasRemainderNumber:@{@"userCode":[NSString stringWithFormat:@"%d",user.userCode]}];
        //处理完上面的后回到主线程去更新UI
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        dispatch_async(mainQueue, ^{
            if (surplusNumLabel)
            {
                surplusNumLabel.text =[NSString stringWithFormat:@"今日剩余%d个",remainderNum];
            }
        });
    });
}

- (void)updateLog
{
    dispatch_queue_t currentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(currentQueue, ^{
        //后台处理代码, 一般 http 请求在这里发, 然后阻塞等待返回, 收到返回处理
        [[API sharedInstance]logIdeaViewed:@{@"sentence":[[self.data objectAtIndex:index] objectForKey:@"sentence"]}];
        //处理完上面的后回到主线程去更新UI
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        dispatch_async(mainQueue, ^{
            
            if ([API sharedInstance].code.integerValue == 0)
            {
                [self getRemainderNum];
            }
        });
    });
}

- (void)hasIdeaBeenUsed
{
    dispatch_queue_t currentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(currentQueue, ^{
        //后台处理代码, 一般 http 请求在这里发, 然后阻塞等待返回, 收到返回处理
        NSDictionary* dict = [[API sharedInstance]hasIdeaBeenUsed:@{@"sentence":[[self.data objectAtIndex:index] objectForKey:@"sentence"]}];
        //处理完上面的后回到主线程去更新UI
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        dispatch_async(mainQueue, ^{
            if (dict)
            {
                reformID = [dict objectForKey:@"reform"];
                occupyID = [dict objectForKey:@"occupy"];
                collectID = [dict objectForKey:@"collect"];
            }
            
            if (reformID.integerValue > 0)
            {
                transformBtn.enabled = NO;
                [transformBtn setImage:[UIImage imageNamed:@"ideaCreate/btn_wygz_on"] forState:UIControlStateDisabled];
            }
            else
            {
                transformBtn.enabled = YES;
                [transformBtn setImage:[UIImage imageNamed:@"ideaCreate/btn_wygz"] forState:UIControlStateNormal];
            }
            
            if (occupyID.integerValue > 0)
            {
                hoggedBtn.enabled = NO;
                [hoggedBtn setImage:[UIImage imageNamed:@"ideaCreate/btn_wybz_on"] forState:UIControlStateDisabled];
            }
            else
            {
                hoggedBtn.enabled = YES;
                [hoggedBtn setImage:[UIImage imageNamed:@"ideaCreate/btn_wybz"] forState:UIControlStateNormal];
            }
            
            if (collectID.integerValue > 0)
            {
                collectionBtn.enabled = NO;
                [collectionBtn setImage:[UIImage imageNamed:@"ideaCreate/btn_wysc_on"] forState:UIControlStateDisabled];
            }
            else
            {
                collectionBtn.enabled = YES;
                [collectionBtn setImage:[UIImage imageNamed:@"ideaCreate/btn_wysc"] forState:UIControlStateNormal];
            }
        });
    });
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end