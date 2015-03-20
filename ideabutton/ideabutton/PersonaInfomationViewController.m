//
//  PersonaInfomationViewController.m
//  ideabutton
//
//  Created by ZhouTong on 15-3-20.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import "PersonaInfomationViewController.h"

@interface PersonaInfomationViewController ()

@end

@implementation PersonaInfomationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"个人资料";
    
     [self setrightbaritem_imgname:@"icon_more_all.png" title:@""];
}

-(void)btnright
{
    [self showMenuView];
    
}




@end
