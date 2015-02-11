//
//  InteractivePageViewController.m
//  ideabutton
//
//  Created by Li Xiang on 15/2/11.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InteractivePageViewController.h"

#define Height  45

@interface InteractivePageViewController()


@end


@implementation InteractivePageViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setrightbaritem_imgname:@"icon_more_all" title:nil];
    
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 180, 30)];
    titleLabel.text = @"数字决定创意类型，想好再按";
    [self.view addSubview:titleLabel];
}

@end