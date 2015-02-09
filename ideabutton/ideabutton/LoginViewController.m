//
//  LoginView.m
//  ideabutton
//
//  Created by Li Xiang on 15/2/9.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginViewController.h"

@interface LoginViewController ()
{

}
@end

@implementation LoginViewController

-(void)viewDidLoad
{
    self.view.backgroundColor = [UIColor blackColor];
    
    UIImageView *loginNameView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"input_bai"]];
    loginNameView.frame = CGRectMake(40, 50, 240, 40);
    [self.view addSubview:loginNameView];
    
    UIImageView *loginPSWView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"input_bai"]];
    loginPSWView.frame = CGRectMake(40, 110, 240, 40);
    [self.view addSubview:loginPSWView];
    
    
}
@end