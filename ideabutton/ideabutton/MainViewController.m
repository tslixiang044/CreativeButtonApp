//
//  MainViewController.m
//  ideabutton
//
//  Created by Jian Hu on 15-2-6.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import "MainViewController.h"
#import "IAlsoPressViewController.h"



@interface MainViewController ()
{
    UISegmentedControl *segmentedControl;
}
@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    segmentedControl=[[UISegmentedControl alloc] initWithFrame:CGRectMake(0, 0, kMainScreenBoundwidth, 44) ];
    [segmentedControl insertSegmentWithTitle:@"按友圈" atIndex:0 animated:YES];
    [segmentedControl insertSegmentWithTitle:@"我也要按" atIndex:1 animated:YES];
    segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    segmentedControl.selectedSegmentIndex=0;
    [segmentedControl addTarget:self action:@selector(Selectbutton:) forControlEvents:UIControlEventValueChanged];
    [self.navigationController.navigationBar addSubview:segmentedControl];
}
-(void)Selectbutton:(UISegmentedControl*)mseg
{
    if(mseg.selectedSegmentIndex==0)
    {
        
    }
    else  if(mseg.selectedSegmentIndex==1)
    {
        mseg.hidden=YES;
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
