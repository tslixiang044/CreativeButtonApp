//
//  IdeaGenerateViewController.m
//  ideabutton
//
//  Created by Li Xiang on 15/2/12.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IdeaGenerateViewController.h"

@interface IdeaGenerateViewController()

@end


@implementation IdeaGenerateViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setrightbaritem_imgname:@"icon_more_all" title:nil];
    
    [self createInputView];
}

-(void)createInputView
{
    UIImageView* backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"input_bg"]];
    backgroundView.frame = CGRectMake(40, 50, 240, 160);
    [self.view addSubview:backgroundView];
    
    UILabel* detailLabel = [[UILabel alloc] initWithFrame:backgroundView.frame];
    detailLabel.layer.borderColor = [UIColor whiteColor].CGColor;
    detailLabel.layer.borderWidth = 1.0;
    detailLabel.lineBreakMode = NSLineBreakByWordWrapping;
    detailLabel.numberOfLines = 0;
    //    detailLabel.textColor = [UIColor whiteColor];
    //    detailLabel.text = @"测试内容";
    [self.view addSubview:detailLabel];
    
    UIButton* hoggedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    hoggedBtn.frame = CGRectMake(40, 230, 100, 50);
    hoggedBtn.backgroundColor = [UIColor redColor];
    hoggedBtn.layer.cornerRadius = 5;
    [hoggedBtn setTitle:@"我要霸占" forState:UIControlStateNormal];
    [self.view addSubview:hoggedBtn];
    
    UIButton* achieveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    achieveBtn.frame = CGRectMake(40, 300, 100, 50);
    achieveBtn.backgroundColor = [UIColor redColor];
    achieveBtn.layer.cornerRadius = 5;
    [achieveBtn setTitle:@"我要实现" forState:UIControlStateNormal];
    [self.view addSubview:achieveBtn];
    
    UIButton* nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.frame = CGRectMake(40, 370, 280, 45);
    nextBtn.backgroundColor = COLOR(124, 96, 33);
    nextBtn.layer.cornerRadius = 5;
    [nextBtn setTitle:@"下一个(今日剩余N个)" forState:UIControlStateNormal];
    [self.view addSubview:nextBtn];
}

@end