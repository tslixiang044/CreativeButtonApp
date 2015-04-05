//
//  AppDelegate.m
//  ideabutton
//
//  Created by 周同 on 15-2-6.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "MyNavigationViewController.h"
#import "MyUIButton.h"
@interface AppDelegate ()<UIScrollViewDelegate>
{
    UIScrollView *mscrollview;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    //-----------------------------------
    
    BOOL isfirst=[Global CheckisFirst:@"startpage"];
    
    if(isfirst)
    {
        [self initStartPage];
    }
    else
    {
        
        [self gomain];
    }
    
   
    
    //-----------------------------------
    
    
    return YES;
}
-(void)initStartPage
{
    mscrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenBoundwidth, kMainScreenBoundheight)];
    mscrollview.scrollEnabled=YES;
    mscrollview.userInteractionEnabled=YES;
    mscrollview.alwaysBounceHorizontal=YES;
    mscrollview.pagingEnabled=YES;
    mscrollview.backgroundColor=[UIColor blackColor];
    mscrollview.delegate=self;
    mscrollview.contentSize=CGSizeMake(320*5, kMainScreenBoundheight);
    [self.window addSubview:mscrollview];
    //----------------
    float x=0;
    for(int i=0;i<3;i++)
    {
        x=i*kMainScreenBoundwidth;
        
        UIImageView *img1=[[UIImageView alloc]initWithFrame:CGRectMake(x, 0, kMainScreenBoundwidth, kMainScreenBoundheight)];
        img1.userInteractionEnabled=YES;
        NSString *imgname=[NSString stringWithFormat:@"strartpage_%i.png",i+1];
        img1.image=[UIImage imageNamed:imgname];
        //---------------------------------
        [mscrollview addSubview:img1];
        
        if(i==2)
        {
            MyUIButton * btnOk=[[MyUIButton alloc]initWithFrame:CGRectMake((kMainScreenBoundwidth-80)/2, kMainScreenBoundheight/2+50, 80, 80) bgimg:@"btn_start.png" title:@""] ;
            [btnOk addTarget:self action:@selector(btnstartAction) forControlEvents:UIControlEventTouchUpInside];
            [img1 addSubview:btnOk];
           
        }
        
        
    }
    mscrollview.contentSize=CGSizeMake(kMainScreenBoundwidth*3, kMainScreenBoundheight);
}
-(void)btnstartAction
{
    [Global setisfirstFalse:@"startpage"];
    [self gomain];
}
-(void)gomain
{
    MainViewController *main=[[MainViewController alloc]init];
    MyNavigationViewController *nav=[[MyNavigationViewController alloc]initWithRootViewController:main];
    self.window.rootViewController=nav;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
   
}

- (void)applicationWillTerminate:(UIApplication *)application {
   
}

@end
