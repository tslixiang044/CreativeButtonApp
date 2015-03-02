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
#import "API.h"




@interface IAlsoPressViewController ()<UITabBarControllerDelegate,IoccupyViewControllerDelegate>
{
    UITabBarController *mTabbarController;
}
@end

@implementation IAlsoPressViewController

- (void)viewDidLoad
{
//    [[API sharedInstance] createIdea:@{@"adtype":@"1",@"product":@"啤酒",@"brand":@"我是",@"appeal":@"你的",@"number":@"9",@"letter":@"A",@"romanNum":@"1",@"ideaNum":@"1"}];
    
    [super viewDidLoad];
    self.title=@"我霸占的";
    //[self setleftbaritem_imgname:@"icon_jiantou_zuo.png" title:nil];
    [self setrightbaritem_imgname:@"icon_more_all" title:nil];
    //---------------------

    mTabbarController=[[UITabBarController alloc]init];
    mTabbarController.view.frame=CGRectMake(0,0, 320, kMainScreenBoundheight);
    mTabbarController.delegate=self;
    mTabbarController.tabBar.frame=CGRectMake(0, kMainScreenBoundheight-50+1, kMainScreenBoundwidth, 50);
    UIColor *mcolor=[UIColor blackColor];
    if (IS_iOS7)
    {
        mTabbarController.tabBar.barTintColor=mcolor;
    }
    else
    {
        mTabbarController.tabBar.tintColor= mcolor;
    }
    //----------------
    IoccupyViewController *occupy=[[IoccupyViewController alloc]init];
    occupy.view.tag=1;
    occupy.delegate=self;
    occupy.tabBarItem.image=[UIImage imageNamed:@"icon_wbzd"];
    occupy.tabBarItem.title=@"我霸占的";
    //---------------------
    ISavedViewController *save=[[ISavedViewController alloc]init];
    save.view.tag=2;
    save.tabBarItem.image=[UIImage imageNamed:@"icon_wscd"];
    save.tabBarItem.title=@"我收藏的";
    //---------------------
    IChangedViewController *change=[[IChangedViewController alloc]init];
    change.view.tag=3;
    change.tabBarItem.image=[UIImage imageNamed:@"icon_chuizi"];
    change.tabBarItem.title=@"我改造的";
    //---------------------
    UIViewController *back=[[UIViewController alloc]init];
    back.view.tag=4;
    back.tabBarItem.image=[UIImage imageNamed:@"icon_brbz"];
    back.tabBarItem.title=@"大家霸的";
    //---------------------
    NSMutableArray *  marr=[[NSMutableArray alloc]initWithObjects:occupy,save,change,back,nil];
    mTabbarController.viewControllers=marr;
    
    [self.view addSubview:mTabbarController.view];
    //-------
    [self settoolbarColor];
}
-(void)btnleft
{
    
}
-(void)btnright
{
    [self showMenuView];
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
    else if(viewController.view.tag==4)
    {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)settoolbarColor
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        [mTabbarController.tabBar setSelectedImageTintColor:[UIColor redColor]];

        
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor whiteColor], UITextAttributeTextColor,
                                                           [UIFont fontWithName:@"Helvetica" size:12], UITextAttributeFont,
                                                           nil] forState:UIControlStateNormal];
        
        UIColor *titleHighlightedColor = [UIColor colorWithRed:153/255.0 green:192/255.0 blue:48/255.0 alpha:1.0];
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                           titleHighlightedColor, UITextAttributeTextColor,
                                                           [UIFont fontWithName:@"Helvetica" size:12], UITextAttributeFont,
                                                           nil] forState:UIControlStateHighlighted];
        

    }
}
-(void)gotoviewcontroller_Ioccupy:(UIViewController *)mviewcontroller
{
    [self.navigationController pushViewController:mviewcontroller animated:YES];
}

@end
