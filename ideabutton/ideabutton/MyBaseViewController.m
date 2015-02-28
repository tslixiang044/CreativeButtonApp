//
//  MyBaseViewController.m
//  HomeFurnishingApp
//
//  Created by 周同 on 14-12-8.
//
//

#import "MyBaseViewController.h"
#import "MyToolView.h"


@interface MyBaseViewController ()
{
    UIView *alertView;
    UIView *loadView;
    MyToolView *toolview;
    UIView *alertView2;
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



-(void)showalertview_text:(NSString *)mstr imgname:(NSString *)mimgname autoHiden:(BOOL)isautohiden
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
    if(![mimgname isEqualToString:@""] || mimgname != nil)
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



-(void)ShowLoadingView
{
    
    if(loadView==nil)
    {
        loadView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenBoundwidth, kMainScreenBoundheight-64)];
        loadView.backgroundColor=COLOR(1, 0, 0);
        [self.view addSubview:loadView];
        //-----------------------------
        NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"gif" ofType:@"gif"]];
        CGRect frame = CGRectMake((kMainScreenBoundwidth-165)/2,(kMainScreenBoundheight-64-165)/2-50,165,165);
        UIWebView *webView = [[UIWebView alloc] initWithFrame:frame];
        webView.userInteractionEnabled = NO;
        [webView setBackgroundColor:[UIColor clearColor]];
        [webView setOpaque:NO];
        [webView loadData:gif MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
        [loadView addSubview:webView];
        //--------------------------------
        float y=webView.frame.origin.y+webView.frame.size.height+20;
        UILabel *lbldesc=[[UILabel alloc]initWithFrame:CGRectMake(0, y , kMainScreenBoundwidth, 25)];
        lbldesc.text=@"人脑一思考，电脑就发笑";
        lbldesc.textColor=[UIColor whiteColor];
        lbldesc.textAlignment=NSTextAlignmentCenter;
        lbldesc.font=[UIFont systemFontOfSize:12];
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
        toolview=[[MyToolView alloc]initWithFrame:CGRectMake(kMainScreenBoundwidth, 0, kMainScreenBoundwidth, kMainScreenBoundheight-64)];
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
-(void)showAlertView_number:(int)Num
{
    if(alertView2==nil)
    {
        alertView2=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenBoundwidth, kMainScreenBoundheight-64)];
        alertView2.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [[alertView2 layer]setCornerRadius:8.0];
        [alertView2.layer setMasksToBounds:YES];
        
        [self.view addSubview:alertView2];
        //------
        
        //-------
        UIView *view_center=[[UIView alloc]initWithFrame:CGRectMake(20, (kMainScreenBoundheight-64-200)/2, kMainScreenBoundwidth-40, kMainScreenBoundheight-64-200)];
        view_center.tag=886;
        view_center.backgroundColor=COLOR(204, 41, 32);
        [alertView2 addSubview:view_center];
        //-------
        UIButton *  btnclose = [UIButton buttonWithType:UIButtonTypeCustom];
        btnclose.frame = CGRectMake(view_center.frame.size.width-40, -20, 60, 60);
        [btnclose setImage:[UIImage imageNamed:@"btn_close.png"] forState:UIControlStateNormal];
        btnclose.backgroundColor=[UIColor clearColor];
        [btnclose addTarget:self action:@selector(btncloseAction:) forControlEvents:UIControlEventTouchUpInside];
        [view_center addSubview:btnclose];
        //--------
        float width=view_center.frame.size.width;
        UILabel *lbldesc=[[UILabel alloc]initWithFrame:CGRectMake(20, 40, width-40, 60)];
        lbldesc.tag=888;
        lbldesc.numberOfLines=0;
        lbldesc.textAlignment = NSTextAlignmentCenter;
        //自动折行设置
        
        lbldesc.lineBreakMode = NSLineBreakByWordWrapping;
        lbldesc.textColor=[UIColor whiteColor];
        [view_center addSubview:lbldesc];
        //--------
        UIButton *  btngo = [UIButton buttonWithType:UIButtonTypeCustom];
        btngo.frame = CGRectMake((width-80)/2, 120, 80, 30);
        
        
        
        
        [btngo setBackgroundImage:[UIImage imageNamed:@"btn_bg_bai.png"] forState:UIControlStateNormal];
        [btngo setTitle:@"明天再来" forState:UIControlStateNormal];
        btngo.titleLabel.font = [UIFont systemFontOfSize:14];
        btngo.backgroundColor=COLOR(131, 131, 131);
        [btngo setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [btngo setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [btngo addTarget:self action:@selector(btngoAction:) forControlEvents:UIControlEventTouchUpInside];
        [view_center addSubview:btngo];
        //--------
        
    }
    UIView *view_center=[alertView2 viewWithTag:886];
    UILabel *lbldesc=(UILabel *)[view_center viewWithTag:888];
    lbldesc.text=[NSString stringWithFormat:@"今天免费产生的idea数量已达上限%i个",Num];
    //---------
    alertView2.hidden=NO;
    [self.view bringSubviewToFront:alertView2];
    
}
-(void)btngoAction:(UIButton*)mbtn
{
    alertView2.hidden=YES;
}
-(void)btncloseAction:(UIButton*)mbtn
{
    alertView2.hidden=YES;
}
@end
