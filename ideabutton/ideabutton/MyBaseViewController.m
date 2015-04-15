//
//  MyBaseViewController.m
//  HomeFurnishingApp
//
//  Created by 周同 on 14-12-8.
//
//

#import "MyBaseViewController.h"
#import "MyToolView.h"
#import "PersonaInfomationViewController.h"
#import "SettingViewController.h"
#import "FeedBackViewController.h"
#import "PerfectInfoViewController.h"
#import "DB.h"
#import "UploadViewController.h"


@interface MyBaseViewController ()<MyToolViewDelegate>
{
    UIView *alertView;
    UIView *loadView;
    MyToolView *toolview;
    UIView *alertView2;
    float width;
    NSInteger actionType;
    UIWebView *webView;
}
@end

@implementation MyBaseViewController
@synthesize mtag;



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
    
    NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"gif" ofType:@"gif"]];
    CGRect frame = CGRectMake(0,(kMainScreenBoundheight-64-165)/2-50,220,130);
    webView = [[UIWebView alloc] initWithFrame:frame];
    webView.userInteractionEnabled = NO;
    [webView setBackgroundColor:[UIColor clearColor]];
    [webView setOpaque:NO];
    [webView loadData:gif MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
}

-(void)setrightbaritem_imgname:(NSString*)icon_img_name title:(NSString*)mtitle
{
    UIImage* backImage = [UIImage imageNamed:icon_img_name];
    CGRect backframe = CGRectMake(0,0,30,30);
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
    CGRect backframe = CGRectMake(0,0,30,30);
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

-(void)showalertview_text:(NSString *)mstr frame:(CGRect)frame autoHiden:(BOOL)isautohiden
{
    if(alertView==nil)
    {
        alertView=[[UIView alloc]initWithFrame:frame];
        alertView.backgroundColor=[UIColor blackColor];
        [alertView.layer setMasksToBounds:YES];
        
        [self.view addSubview:alertView];
        [self.view bringSubviewToFront:alertView];

        UILabel *lblalert=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 20)];
        lblalert.tag=100;
        lblalert.text = mstr;
        lblalert.font = [UIFont systemFontOfSize:12];
        lblalert.textColor=[UIColor whiteColor];
        lblalert.textAlignment=NSTextAlignmentCenter;
        lblalert.lineBreakMode = NSLineBreakByWordWrapping;
        lblalert.numberOfLines = 0;
        lblalert.backgroundColor=[UIColor clearColor];
        [alertView addSubview:lblalert];
    }

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

-(void)ShowLoadingView
{
    if(loadView==nil)
    {
        loadView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenBoundwidth, kMainScreenBoundheight-64)];
        loadView.backgroundColor=COLOR(1, 0, 0);
        [self.view addSubview:loadView];
        //-----------------------------
        
        [loadView addSubview:webView];
        //--------------------------------
        float y=webView.frame.origin.y+webView.frame.size.height+20;
        UILabel *lbldesc=[[UILabel alloc]initWithFrame:CGRectMake(0, y , kMainScreenBoundwidth, 25)];
        lbldesc.text=@"人脑一思考，电脑就发笑";
        lbldesc.textColor=[UIColor whiteColor];
        lbldesc.textAlignment=NSTextAlignmentCenter;
        lbldesc.font=[UIFont systemFontOfSize:15];
        [loadView addSubview:lbldesc];
    }
    
    loadView.hidden=NO;
    [self.view bringSubviewToFront:loadView];
}

-(void)hidenLoadingView
{
    loadView.hidden=YES;
}

-(void)showMenuView
{
    if(toolview==nil)
    {
        toolview=[[MyToolView alloc]initWithFrame:CGRectMake(0, -(kMainScreenBoundheight-64), kMainScreenBoundwidth, kMainScreenBoundheight-64)];
        toolview.delegate=self;
        [self.view addSubview:toolview];
        toolview.hidden=YES;
    }
    [self.view bringSubviewToFront:toolview];
    
    [toolview showtoolView];
}

-(void)hidenMenuView
{
    [toolview hidentoolView];
}

-(void)LoginOUt
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)gotoViewcontroller:(NSString *)mtag2
{
    if([mtag2 isEqualToString:@"按友圈"])
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else if([mtag2 isEqualToString:@"我的主页"])
    {
        if(![self.mtag isEqualToString:@"个人资料"])
        {
            PersonaInfomationViewController *infomation=[PersonaInfomationViewController new];
            [self.navigationController pushViewController:infomation animated:YES];
        }
    }
    else if([mtag2 isEqualToString:@"设置"])
    {
        if(![self.title isEqualToString:@"设置"])
        {
            SettingViewController *set=[SettingViewController new];
            [self.navigationController pushViewController:set animated:YES];
        }
    }
    else if([mtag2 isEqualToString:@"提建议"])
    {
        if(![self.title isEqualToString:@"意见反馈"])
        {
            FeedBackViewController *feed=[FeedBackViewController new];
            [self.navigationController pushViewController:feed animated:YES];
        }
    }
}

-(void)showAlertView_desc:(NSString *)desc btnImage:(NSString *)imageName btnHideFlag:(BOOL)flag ActionType:(NSInteger)type
{
    actionType = type;
    
    if(alertView2==nil)
    {
        alertView2=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenBoundwidth, kMainScreenBoundheight-64)];
        alertView2.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [[alertView2 layer]setCornerRadius:8.0];
        [alertView2.layer setMasksToBounds:YES];
        
        [self.view addSubview:alertView2];

        UIView *view_center=[[UIView alloc]initWithFrame:CGRectMake(30, (kMainScreenBoundheight-64-250)/2, kMainScreenBoundwidth-60, kMainScreenBoundheight-80-200)];
        view_center.tag=886;
        view_center.backgroundColor = COLOR(21, 21, 22);
        [alertView2 addSubview:view_center];
        //-------
        if (!flag)
        {
            UIButton *  btnclose = [UIButton buttonWithType:UIButtonTypeCustom];
            btnclose.frame = CGRectMake(view_center.frame.size.width-50, -10, 60, 60);
            [btnclose setImage:[UIImage imageNamed:@"btn_close"] forState:UIControlStateNormal];
            btnclose.backgroundColor=[UIColor clearColor];
            [btnclose addTarget:self action:@selector(btncloseAction:) forControlEvents:UIControlEventTouchUpInside];
            [view_center addSubview:btnclose];
        }
        
        //--------
        width = view_center.frame.size.width;
        UILabel *lbldesc=[[UILabel alloc]initWithFrame:CGRectMake(30, 20, width-60, 100)];
        lbldesc.font = [UIFont systemFontOfSize:15];
        lbldesc.tag=888;
        
        lbldesc.textAlignment = NSTextAlignmentCenter;
        //自动折行设置
        lbldesc.lineBreakMode = NSLineBreakByWordWrapping;
        lbldesc.numberOfLines=0;
        
        lbldesc.textColor=[UIColor whiteColor];
        [view_center addSubview:lbldesc];
        //--------
        UIButton *  btngo = [UIButton buttonWithType:UIButtonTypeCustom];
        btngo.tag = 889;
        [btngo addTarget:self action:@selector(btngoAction:) forControlEvents:UIControlEventTouchUpInside];
        [view_center addSubview:btngo];
        
        UIButton* preBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        preBtn.frame = CGRectMake(40, 140, 80, 80);
        preBtn.tag = 900;
        [preBtn addTarget:self action:@selector(btngoAction:) forControlEvents:UIControlEventTouchUpInside];
        [view_center addSubview:preBtn];
    }
    
    UIView *view_center=[alertView2 viewWithTag:886];
    UILabel *lbldesc=(UILabel *)[view_center viewWithTag:888];
    lbldesc.text=desc;
    //---------
    
    UIButton *btngo=(UIButton *)[view_center viewWithTag:889];
    UIButton *preBtn=(UIButton *)[view_center viewWithTag:900];
    
    if (type == 3 || type == 4)
    {
        preBtn.hidden = YES;
        
        btngo.frame = CGRectMake((width-80)/2, 140, 80, 80);
        [btngo setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    else if (type == 2)
    {
        [preBtn setImage:[UIImage imageNamed:@"bg_btn_wyrz_on"] forState:UIControlStateNormal];
        
        btngo.frame = CGRectMake(width-110, 140, 80, 80);
        [btngo setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    else if (type == 1)
    {
        [preBtn setImage:[UIImage imageNamed:@"bg_btn_wszl_on"] forState:UIControlStateNormal];
        
        btngo.frame = CGRectMake(width-110, 140, 80, 80);
        [btngo setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }

    alertView2.hidden=NO;
    [self.view bringSubviewToFront:alertView2];
    
}

-(void)btngoAction:(UIButton*)mbtn
{
    alertView2.hidden=YES;
    
    switch (mbtn.tag)
    {
        case 889:
        {
            User* user = [[DB sharedInstance]queryUser];
            if (actionType == 3)
            {
                if (user.userLevel == 1)
                {
                    [self.navigationController pushViewController:[[PerfectInfoViewController alloc] init] animated:YES];
                }
                else if (user.userLevel == 2)
                {
                    [self.navigationController pushViewController:[[UploadViewController alloc] init] animated:YES];
                }
                else
                {
                     [self.navigationController popToRootViewControllerAnimated:YES];
                }
            }
            else if (actionType == 4)
            {
                
            }
            else
            {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }
            
            break;
        case 900:
        {
            if (actionType == 1)
            {
                [self.navigationController pushViewController:[[PerfectInfoViewController alloc] init] animated:YES];
            }
            else if(actionType == 2)
            {
                [self.navigationController pushViewController:[[UploadViewController alloc] init] animated:YES];
            }
        }
            break;
            
        default:
            break;
    }
    
}

-(void)btncloseAction:(UIButton*)mbtn
{
    alertView2.hidden=YES;
}


//--------------------------------------------------------------
/**
 从下向上推入导航
 */
-(void) PushToTop:(UIViewController*)mviewcontroller
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionMoveIn;
    
    transition.subtype =kCATransitionFromTop;
    
    transition.delegate = self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    [self.navigationController pushViewController:mviewcontroller animated:NO];
}


/**
 从下向上返回主页
 */
-(void) PopToParent
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromBottom;
    transition.delegate = self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController popViewControllerAnimated:NO];
    
}
//--------------------------------------------------------------












@end
