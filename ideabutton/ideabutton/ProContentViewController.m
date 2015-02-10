//
//  ProContentViewController.m
//  ideabutton
//
//  Created by Li Xiang on 15/2/10.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProContentViewController.h"

@interface ProContentViewController()<UITextFieldDelegate>

@end


@implementation ProContentViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView* loginView = [[UIView alloc] initWithFrame:CGRectMake(20, 60, 280, 380)];
    loginView.backgroundColor = COLOR(21, 21, 22);
    [self.view addSubview:loginView];
    
    UIImageView *inputView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"input_bai"]];
    inputView.userInteractionEnabled = YES;
    inputView.frame = CGRectMake(20, 30, 240, 40);
    [loginView addSubview:inputView];
    
    UITextField* textfield = [[UITextField alloc] initWithFrame:inputView.frame];
    textfield.delegate = self;
    textfield.placeholder = @"品牌/子品牌";
    [self.view addSubview:textfield];
}

@end