//
//  ReformIdeaViewController.m
//  ideabutton
//
//  Created by Li Xiang on 15/3/3.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReformIdeaViewController.h"
#import "API.h"
#import "SVProgressHUD.h"

#define SaveBtnTag    0
#define CancelBtnTag    1

@interface ReformIdeaViewController()
{
    UITextField* reformIdeaTextField;
}

@property(nonatomic, strong)NSDictionary* dict;

@end


@implementation ReformIdeaViewController

-(id)initWithDict:(NSDictionary*)dict
{
    self = [super init];
    if (self)
    {
        self.dict = dict;
        //        preSentence = [NSString stringWithFormat:@"%@",[self.dict objectForKey:@"sentence"]];
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
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, 280, 120)];
    titleLabel.layer.borderColor = [[UIColor grayColor] CGColor];
    titleLabel.layer.borderWidth = 1;
    titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    titleLabel.numberOfLines = 0;
    
    NSString* titleStr = [NSString stringWithFormat:@"#改造声明#我宣布,我刚刚改造了一条%@广告,谁也别想再碰!",[self.dict objectForKey:@"product"]];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:titleStr];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,6)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(6,str.length - 7)];
    titleLabel.attributedText = str;
    
    [self.view addSubview:titleLabel];
    
    UIImageView* backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 185, 280, 260)];
    [backgroundView setBackgroundColor:COLOR(21, 21, 22)];
    [self.view addSubview:backgroundView];
}

-(void)buttonClick:(UIButton*)sender
{
    switch (sender.tag)
    {
        case SaveBtnTag:
        {
            [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
            dispatch_queue_t currentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_async(currentQueue, ^{
                //后台处理代码, 一般 http 请求在这里发, 然后阻塞等待返回, 收到返回处理
                NSString* ID = [[API sharedInstance] reformIdea:@{@"userOccupyId":@"",@"userCollectId":@"",@"algorithmRule":[self.dict objectForKey:@"algorithmRule"],@"reformedSentence":reformIdeaTextField.text,@"sentence":@"",@"adtype":[self.dict objectForKey:@"adtype"],@"product":[self.dict objectForKey:@"product"]}];
                //处理完上面的后回到主线程去更新UI
                dispatch_queue_t mainQueue = dispatch_get_main_queue();
                dispatch_async(mainQueue, ^{
                    [SVProgressHUD dismiss];
                    if (ID)
                    {
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"reformIdeaSuccess" object:nil];
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                    else
                    {
                        //                        [self showalertview_text:@"创意霸占失败" imgname:@"error" autoHiden:YES];
                    }
                });
            });
        }
            break;
        case CancelBtnTag:
            [self.navigationController popViewControllerAnimated:YES];
            break;
            
        default:
            break;
    }
}
@end
