//
//  MyNavigationViewController.m
//  izhuzhou
//
//  Created by 周同 on 14-6-20.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "MyNavigationViewController.h"

@interface MyNavigationViewController ()

@end

@implementation MyNavigationViewController





- (void)viewDidLoad
{
    [super viewDidLoad];
    //--------------------------------------------------------------------------
     self.navigationBar.translucent = NO;
    
    [self setnavigatonbarColor];
    

}
-(void)setnavigatonbarColor
{
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1)
    {
        self.navigationBar.tintColor = [UIColor redColor];
    }
    else
    {
        self.navigationBar.barTintColor =[UIColor redColor];
        self.navigationBar.tintColor=[UIColor whiteColor];
    }
    
    UIColor *mcolor=[UIColor whiteColor];
    
    
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                
                                                mcolor,
                                                UITextAttributeTextColor,
                                                
                                                [UIColor colorWithRed:0 green:0.7 blue:0.8 alpha:1],
                                                
                                                UITextAttributeTextShadowColor,
                                                
                                                
                                                [NSValue valueWithUIOffset:UIOffsetMake(0, 0)],
                                                
                                                UITextAttributeTextShadowOffset,
                                                
                                                
                                                [UIFont fontWithName:@"Arial-Bold" size:0.0],
                                                
                                                UITextAttributeFont,
                                                nil]];
}
@end
