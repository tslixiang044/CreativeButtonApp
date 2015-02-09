//
//  IAlsoPressViewController.m
//  ideabutton
//
//  Created by Jian Hu on 15-2-9.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import "IAlsoPressViewController.h"
#import "IoccupyViewController.h"
#import "ISavedViewController.h"
#import "IChangedViewController.h"





@interface IAlsoPressViewController ()<UITabBarControllerDelegate>
{
    UITabBarController *mTabbarController;
}
@end

@implementation IAlsoPressViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"我霸占的";
    //---------------------
    mTabbarController=[[UITabBarController alloc]init];
    mTabbarController.view.frame=CGRectMake(0,0, 320, kMainScreenBoundheight);
    mTabbarController.delegate=self;
    mTabbarController.tabBar.frame=CGRectMake(0, kMainScreenBoundheight-50+1, kMainScreenBoundwidth, 50);
    UIColor *mcolor=[UIColor blackColor];
    if (IS_iOS7) {
        mTabbarController.tabBar.barTintColor=mcolor;
    }
    else{
        mTabbarController.tabBar.tintColor= mcolor;
    }
    //----------------
    IoccupyViewController *occupy=[[IoccupyViewController alloc]init];
    occupy.view.tag=1;
    occupy.tabBarItem.image=[UIImage imageNamed:@"find-icon.png"];
    occupy.tabBarItem.title=@"我霸占的";
    //---------------------
    ISavedViewController *save=[[ISavedViewController alloc]init];
    save.view.tag=2;
    save.tabBarItem.image=[UIImage imageNamed:@"find-icon.png"];
    save.tabBarItem.title=@"我收藏的";
    //---------------------
    IChangedViewController *change=[[IChangedViewController alloc]init];
    change.view.tag=3;
    change.tabBarItem.image=[UIImage imageNamed:@"find-icon.png"];
    change.tabBarItem.title=@"我改造的";
    //---------------------
    
    //---------------------
    NSMutableArray *  marr=[[NSMutableArray alloc]initWithObjects:occupy,save,change,nil];
    mTabbarController.viewControllers=marr;
    
    [self.view addSubview:mTabbarController.view];
    
    
}
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if(viewController.view.tag==1)
    {
        self.title=@"我霸占的";
    }
    else if(viewController.view.tag==2)
    {
        self.title=@"我收藏的";
    }
    else if(viewController.view.tag==3)
    {
        self.title=@"我改造的";
    }
}



@end
