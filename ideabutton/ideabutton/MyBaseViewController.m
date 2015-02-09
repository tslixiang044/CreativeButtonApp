//
//  MyBaseViewController.m
//  HomeFurnishingApp
//
//  Created by 周同 on 14-12-8.
//
//

#import "MyBaseViewController.h"

@interface MyBaseViewController ()
{
    UIView *alertView;
}
@end

@implementation MyBaseViewController



- (void)viewDidLoad
{

    [super viewDidLoad];
    
    
   self.view.backgroundColor=[UIColor blackColor];
    //----------------------------------
    UIBarButtonItem *backitem = [[UIBarButtonItem alloc] init];
    backitem.title = @"";
    self.navigationItem.backBarButtonItem = backitem;
    //----------------------------------
    
    if (IS_iOS7)
    { // 判断是否是IOS7
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
        self.edgesForExtendedLayout =UIRectEdgeNone ;
       
    }
    
}

-(void)setrightbaritem_imgname:(NSString*)icon_img_name title:(NSString*)mtitle
{
    UIImage* backImage = [UIImage imageNamed:icon_img_name];
    CGRect backframe = CGRectMake(0,0,54,30);
    UIButton* backButton= [[UIButton alloc] initWithFrame:backframe];
    [backButton setBackgroundImage:backImage forState:UIControlStateNormal];
    [backButton setTitle:mtitle forState:UIControlStateNormal];
    backButton.titleLabel.font=[UIFont systemFontOfSize:13];

    [backButton addTarget:self action:@selector(btnright) forControlEvents:UIControlEventTouchUpInside];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIBarButtonItem* rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
   
}
-(void)btnright
{
    
}
-(void)setleftbaritem_imgname:(NSString*)icon_img_name title:(NSString*)mtitle
{
    UIImage* backImage = [UIImage imageNamed:icon_img_name];
    CGRect backframe = CGRectMake(0,0,54,30);
    UIButton* backButton= [[UIButton alloc] initWithFrame:backframe];
    [backButton setBackgroundImage:backImage forState:UIControlStateNormal];
    [backButton setTitle:mtitle forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    backButton.titleLabel.font=[UIFont systemFontOfSize:13];
    [backButton addTarget:self action:@selector(btnleft) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    self.navigationItem.leftBarButtonItem = rightBarButtonItem;
 
}
-(void)btnleft
{
    
}



-(void)showalertview:(NSString *)mstr autoHiden:(BOOL)isautohiden imgname:(NSString *)mimgname
{

    if(alertView==nil)
    {
        alertView=[[UIView alloc]initWithFrame:CGRectMake(   (320-150)/2, (kMainScreenBoundheight-120)/2-100, 150, 120)];
        alertView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        [[alertView layer]setCornerRadius:8.0];
        [alertView.layer setMasksToBounds:YES];
        
        [self.view addSubview:alertView];
        [self.view bringSubviewToFront:alertView];
        //--
        
        UIImageView *imgview=[[UIImageView alloc]initWithFrame:CGRectMake((150-70)/2, 15, 70, 60)];
        imgview.hidden=YES;
        imgview.tag=99;
        [alertView addSubview:imgview];
        //-------------
        UILabel *lblalert=[[UILabel alloc]initWithFrame:CGRectMake(0, 50, 150, 20)];
        lblalert.tag=100;
        lblalert.textColor=[UIColor whiteColor];
        lblalert.textAlignment=NSTextAlignmentCenter;
        lblalert.backgroundColor=[UIColor clearColor];
        [alertView addSubview:lblalert];
        
        //--------
        
    }
    
    
    UILabel *lblaert=(UILabel *)[alertView viewWithTag:100];
    if(![mimgname isEqualToString:@""])
    {
        UIImageView *imgview=(UIImageView *)[alertView viewWithTag:99];
        imgview.hidden=NO;
        imgview.image=[UIImage imageNamed:mimgname];
        
        lblaert.frame=CGRectMake(0, 75, 150, 20);
    }
    else
    {
        lblaert.frame=CGRectMake(0, 50, 150, 20);
        UIImageView *imgview=(UIImageView *)[alertView viewWithTag:99];
        imgview.hidden=YES;
    }
    
    lblaert.text=mstr;
    alertView.hidden=NO;
    
    if(isautohiden==true)
    {
        [self performSelector:@selector(hidenalertView) withObject:nil afterDelay:2];
    }
    
    
}
-(void)hidenalertView
{
    alertView.hidden=YES;
}
-(void)alert:(NSString *)str
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    
}
@end
