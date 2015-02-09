//
//  MainViewController.m
//  ideabutton
//
//  Created by Jian Hu on 15-2-6.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import "MainViewController.h"
#import "IAlsoPressViewController.h"
#import "LoginViewController.h"


@interface MainViewController ()<UITextFieldDelegate>
{
    UISegmentedControl *segmentedControl;
    UITextField *txtsearch;
}
@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //------
   //-------------
    segmentedControl=[[UISegmentedControl alloc] initWithFrame:CGRectMake(0, 0, kMainScreenBoundwidth, 44) ];
    [segmentedControl insertSegmentWithTitle:@"按友圈" atIndex:0 animated:YES];
    [segmentedControl insertSegmentWithTitle:@"我也要按" atIndex:1 animated:YES];
    segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    segmentedControl.selectedSegmentIndex=0;
    [segmentedControl addTarget:self action:@selector(Selectbutton:) forControlEvents:UIControlEventValueChanged];
    [self.navigationController.navigationBar addSubview:segmentedControl];
    //-------------
    UIView *view_search_bg=[[UIView alloc]initWithFrame:CGRectMake(10, 5, kMainScreenBoundwidth-20, 44)];
    view_search_bg.backgroundColor=COLOR(123, 95, 33);
    [self.view addSubview:view_search_bg];
    //-------------
    txtsearch=[[UITextField alloc]initWithFrame:CGRectMake(2, 2, view_search_bg.bounds.size.width-100, view_search_bg.bounds.size.height-4)];
    txtsearch.textColor=[UIColor whiteColor];
    txtsearch.clearButtonMode=UITextFieldViewModeWhileEditing;
    txtsearch.backgroundColor=[UIColor clearColor];
    txtsearch.delegate=self;
    [txtsearch.layer setBackgroundColor:[COLOR(4, 4, 4) CGColor]];
    txtsearch.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"按产品类别搜索" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [txtsearch.layer setMasksToBounds:YES];
    [view_search_bg addSubview:txtsearch];
    //-------------
    
    
    
}
-(void)Selectbutton:(UISegmentedControl*)mseg
{
    if(mseg.selectedSegmentIndex==0)
    {
        
    }
    else  if(mseg.selectedSegmentIndex==1)
    {
        mseg.hidden=YES;
        
//        [self.navigationController pushViewController:[[LoginViewController alloc] init] animated:YES];
        
        IAlsoPressViewController *press=[[IAlsoPressViewController alloc]init];
        [self.navigationController pushViewController:press animated:YES];
        
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    segmentedControl.hidden=NO;
    segmentedControl.selectedSegmentIndex=0;
}
@end
