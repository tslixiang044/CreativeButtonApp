//
//  IdeaGenerateViewController.m
//  ideabutton
//
//  Created by Li Xiang on 15/2/12.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IdeaGenerateViewController.h"

#define HoggedBtnTag    0
#define CollectionBtnTag    1
#define AchieveBtnTag   2
#define TransformBtnTag 3
#define NextBtnTag  4

@interface IdeaGenerateViewController()
{
    NSInteger IdeaNum;
    NSInteger index;
    NSInteger titleNumber;
    
    UILabel* detailLabel;
    
    UIButton* hoggedBtn;
    UIButton* collectionBtn;
    UIButton* achieveBtn;
    UIButton* transformBtn;
    UIButton* nextBtn;
}
@property(nonatomic, strong)NSArray* data;

@end


@implementation IdeaGenerateViewController

-(id)initWithData:(NSArray*)dataArr
{
    self = [super init];
    if (self)
    {
        self.data = dataArr;
        IdeaNum = [dataArr count];
        index = 0;
        titleNumber = 1;
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
    UIImageView* backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"input_bg"]];
    backgroundView.frame = CGRectMake(40, 50, 240, 160);
    [self.view addSubview:backgroundView];
    
    detailLabel = [[UILabel alloc] initWithFrame:backgroundView.frame];
    detailLabel.layer.borderColor = [UIColor whiteColor].CGColor;
    detailLabel.layer.borderWidth = 1.0;
    detailLabel.lineBreakMode = NSLineBreakByWordWrapping;
    detailLabel.numberOfLines = 0;
    detailLabel.font = [UIFont systemFontOfSize:16];
    detailLabel.text = [NSString stringWithFormat:@"  %d. %@",titleNumber,[[self.data objectAtIndex:index] objectForKey:@"sentence"]];
    detailLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:detailLabel];
    
    hoggedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    hoggedBtn.frame = CGRectMake(40, 230, 110, 50);
    hoggedBtn.tag = HoggedBtnTag;
    hoggedBtn.backgroundColor = [UIColor redColor];
    hoggedBtn.layer.cornerRadius = 5;
    [hoggedBtn setTitle:@"我要霸占" forState:UIControlStateNormal];
    [hoggedBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:hoggedBtn];
    
    collectionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    collectionBtn.frame = CGRectMake(170, 230, 110, 50);
    collectionBtn.tag = CollectionBtnTag;
    collectionBtn.backgroundColor = [UIColor redColor];
    collectionBtn.layer.cornerRadius = 5;
    [collectionBtn setTitle:@"我要收藏" forState:UIControlStateNormal];
    [collectionBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:collectionBtn];
    
    achieveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    achieveBtn.frame = CGRectMake(40, 300, 110, 50);
    achieveBtn.tag = AchieveBtnTag;
    achieveBtn.backgroundColor = [UIColor redColor];
    achieveBtn.layer.cornerRadius = 5;
    [achieveBtn setTitle:@"我要实现" forState:UIControlStateNormal];
    [achieveBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:achieveBtn];
    
    transformBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    transformBtn.frame = CGRectMake(170, 300, 110, 50);
    transformBtn.tag = TransformBtnTag;
    transformBtn.backgroundColor = [UIColor redColor];
    transformBtn.layer.cornerRadius = 5;
    [transformBtn setTitle:@"我要改造" forState:UIControlStateNormal];
    [transformBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:transformBtn];
    
    nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.frame = CGRectMake(40, 370, 240, 45);
    nextBtn.tag = NextBtnTag;
    nextBtn.backgroundColor = COLOR(124, 96, 33);
    nextBtn.layer.cornerRadius = 5;
    [nextBtn setTitle:[NSString stringWithFormat:@"下一个(今日剩余%d个)",--IdeaNum] forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
}

-(void)buttonClick:(UIButton*)sender
{
    switch (sender.tag)
    {
        case HoggedBtnTag:
            
            break;
        case CollectionBtnTag:
            
            break;
        case AchieveBtnTag:
            
            break;
        case TransformBtnTag:
            
            break;
        case NextBtnTag:
            if (IdeaNum > 0)
            {
                if (index < self.data.count)
                {
                    index++;
                }
                
                [nextBtn setTitle:[NSString stringWithFormat:@"下一个(今日剩余%d个)",--IdeaNum] forState:UIControlStateNormal];
                detailLabel.text = [NSString stringWithFormat:@"  %d. %@",++titleNumber,[[self.data objectAtIndex:index] objectForKey:@"sentence"]];
            }
            
            break;
            
        default:
            break;
    }
}

@end