//
//  MainViewController.m
//  ideabutton
//
//  Created by 周同 on 15-2-6.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import "MainViewController.h"
#import "IAlsoPressViewController.h"
#import "LoginViewController.h"
#import "IdeaGenerateViewController.h"
#import "WaterFlowView.h"
#import "ImageViewCell.h"
#import "JsonResult.h"
#import "WaterFlowObj.h"
#import "ReformIdeaViewController.h"
#import "API.h"
#import "IdeaDetailViewController.h"
//#import "DB.h"
#import "PersonaInfomationViewController.h"
#import "MySegmentedControl.h"
#import "UploadViewController.h"


@interface MainViewController ()<UIScrollViewDelegate,UITextFieldDelegate,WaterFlowViewDelegate,WaterFlowViewDataSource,Globaldelegate,LoginViewControllerDelegate,MySegmentedControlDelegate,ImageViewCellDelegate>
{
    
    NSMutableArray *mArr_1;
    NSMutableArray *mArr_2;
    
    WaterFlowView *waterFlow_1;
    WaterFlowView *waterFlow_2;
    
    NSInteger remainderNum;
    
    MySegmentedControl *segmentedControl;
    
    UITextField *txtsearch;
    
    UIView *bottomView;
    
    int pageindex_1;
    int pageindex_2;
}
@end

@implementation MainViewController
@synthesize btntype;

- (void)viewDidLoad
{
    pageindex_1=1;
    pageindex_2=1;
    
    isLoadingMore_1=NO;
    isLoadingMore_2=NO;
    
    [super viewDidLoad];
    
    [self loadData:1];
    [self loadData:2];
    
    //------
    mArr_1=[[NSMutableArray alloc]init];
    mArr_2=[[NSMutableArray alloc]init];
    //-------------
    NSArray *segmentarr=[[NSArray alloc]initWithObjects:@"按友圈",@"建议栏", nil];
    segmentedControl=[[MySegmentedControl alloc]initWithFrame:CGRectMake(0, 0, kMainScreenBoundwidth, 44)];
    segmentedControl.items=segmentarr;
    segmentedControl.delegate=self;
    
    segmentedControl.backgroundColor=kGetNavbarColor;
    
    [self.navigationController.navigationBar addSubview:segmentedControl];
    
    //-------
    mscrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenBoundwidth, kMainScreenBoundheight-64-50)];
    mscrollview.backgroundColor=[UIColor grayColor];
    [self.view addSubview:mscrollview];
    //-------
    k=1;
    waterFlow_1 = [[WaterFlowView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenBoundwidth, kMainScreenBoundheight-64-50)];
    waterFlow_1.tag=1;
    waterFlow_1.waterFlowViewDelegate = self;
    waterFlow_1.waterFlowViewDatasource = self;
    waterFlow_1.backgroundColor = [UIColor blackColor];
    [mscrollview addSubview:waterFlow_1];
    [waterFlow_1 release];
    //------------------
    waterFlow_2 = [[WaterFlowView alloc] initWithFrame:CGRectMake(kMainScreenBoundwidth, 0, kMainScreenBoundwidth, kMainScreenBoundheight-64-50)];
    waterFlow_2.tag=2;
    waterFlow_2.waterFlowViewDelegate = self;
    waterFlow_2.waterFlowViewDatasource = self;
    waterFlow_2.backgroundColor = [UIColor blackColor];
    [mscrollview addSubview:waterFlow_2];
    [waterFlow_2 release];
    //------------------
    
    bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, kMainScreenBoundheight-64-50, kMainScreenBoundwidth, 50)];
    bottomView.backgroundColor=[UIColor blackColor];
    [self.view addSubview:bottomView];
    
    //------------------
    UIButton *btnwyya = [UIButton buttonWithType:UIButtonTypeCustom];
    btnwyya.frame = CGRectMake((kMainScreenBoundwidth-70)/2, -20 , 70, 70);
    [btnwyya setBackgroundImage:[UIImage imageNamed:@"btn_wyya.png"] forState:UIControlStateNormal];
    [btnwyya addTarget:self action:@selector(btnwyyaAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:btnwyya];
    //------------------
    UIButton *btnadmin = [UIButton buttonWithType:UIButtonTypeCustom];
    btnadmin.frame = CGRectMake(kMainScreenBoundwidth-35-7, 10 , 25, 25);
    [btnadmin setBackgroundImage:[UIImage imageNamed:@"icon_admin1.png"] forState:UIControlStateNormal];
    [btnadmin addTarget:self action:@selector(btnadminAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:btnadmin];
    //------------------

    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backToFriend:) name:@"aaaaaaaaa" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backToSuggestion:) name:@"backToSuggestion" object:nil];
}

-(void)dealloc
{
    [segmentedControl release];
    [txtsearch release];
    [super dealloc];
}

-(void)loginSuccessfull
{
    if([btntype isEqualToString:@"admin"])
    {
        User *user = [User GetInstance];//[[DB sharedInstance] queryUser];
        if(user.userCode != 0)
        {
            NSString *usercode=[NSString stringWithFormat:@"%ld",(long)user.userCode];
            PersonaInfomationViewController *infomaton=[[PersonaInfomationViewController alloc]initwithuserCode:usercode ];
            [self.navigationController pushViewController:infomaton animated:YES];
            [infomaton release];
        }
    }
    else if([btntype isEqualToString:@"wyya"])
    {
        IAlsoPressViewController *press=[[IAlsoPressViewController alloc]init];
        [self.navigationController pushViewController:press animated:YES];
        [press release];
    }
}

-(void)btnadminAction
{
    self.btntype=@"admin";
    
    User *user = [User GetInstance];
//    User* user = [[DB sharedInstance]queryUser];
    if (user.userCode != 0)
    {
        NSString *usercode=[NSString stringWithFormat:@"%ld",(long)user.userCode];
        PersonaInfomationViewController *infomaton=[[PersonaInfomationViewController alloc]initwithuserCode:usercode ];
        
        [self.navigationController pushViewController:infomaton animated:YES];
        [infomaton release];
    }
    else
    {
        LoginViewController *login=[[LoginViewController alloc] init];
        login.delegate=self;
        [self.navigationController pushViewController:login animated:YES];
        [login release];
    }
}

-(void)btnwyyaAction
{
//    User* user = [[DB sharedInstance]  queryUser];
    User *user = [User GetInstance];
    
    remainderNum = [[API sharedInstance]userIdeasRemainderNumber:@{@"userCode":[NSString stringWithFormat:@"%ld",(long)user.userCode]}];
    
    self.btntype=@"wyya";
    
    segmentedControl.hidden=YES;
    
    if (user.userCode != 0)
    {
        if (remainderNum == 0)
        {
            if (user.userLevel == 1)
            {
                [self showAlertView_desc:@"今日免费浏览的数量\n\n已达上限18个\n\n完善资料可以浏览更多idea" btnImage:@"bg_btn_xcws_on" btnHideFlag:YES ActionType:1];
            }
            
            if (user.userLevel == 2)
            {
                if (user.auditStatus == 0)
                {
                    [self showAlertView_desc:@"今日免费浏览的数量\n\n已达上限36个\n\n上传认证可以浏览更多idea" btnImage:@"bg_btn_xcrz_on" btnHideFlag:YES ActionType:2];
                }
                else
                {
                    [self showAlertView_desc:@"你上传的资料正在审核中\n\n审核通过后\n\n每日可免费浏览81个idea" btnImage:@"bg_btn_hd_on" btnHideFlag:YES ActionType:3];
                }
            }
        }
        else
        {
            IAlsoPressViewController *press=[[IAlsoPressViewController alloc]init];
            [self.navigationController pushViewController:press animated:YES];
            [press release];
        }
    }
    else
    {
        LoginViewController *login=[[LoginViewController alloc] init];
        login.delegate=self;
        [self.navigationController pushViewController:login animated:YES];
        [login release];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [txtsearch resignFirstResponder];
    return YES;
}

-(void)btnsearchAction
{
    [txtsearch resignFirstResponder];
}

-(void)loadData:(int)mtag
{
    if(mtag==1)
    {
        pageindex_1=1;
        NSString *url=[kgetWaterFlowUrl stringByAppendingString:@"1-20"];
        
        [[Global getInstanse] getHttpRequest_url:url key:@"kgetWaterFlowUrl_1" delegate:self];
    }
    else if(mtag==2)
    {
        pageindex_2=1;
        
        NSString *url=[kgetWaterFlowUrl_suggesion stringByAppendingString:@"1"];
        
        [[Global getInstanse] getHttpRequest_url:url key:@"kgetWaterFlowUrl_2" delegate:self];
    }
}

-(void)loadMore:(int)mtag range:(NSString*)range
{
    if(mtag==1)
    {
        NSString *url=[kgetWaterFlowUrl stringByAppendingString:range];
        
        [[Global getInstanse] getHttpRequest_url:url key:@"kgetWaterFlowUrl_1" delegate:self];
    }
    else if(mtag==2)
    {
        NSString *url=[kgetWaterFlowUrl_suggesion stringByAppendingString:range];
        
        [[Global getInstanse] getHttpRequest_url:url key:@"kgetWaterFlowUrl_2" delegate:self];
    }
}

-(void)uploadfinished_global:(NSData *)responseData key:(NSString *)mkey
{
    NSDictionary *mdic=[Global  GetdicwithData:responseData];
    
    JsonResult *result=[[JsonResult alloc]initwithDic:mdic];
    
    if([mkey isEqualToString:@"kgetWaterFlowUrl_1"])
    {
        if([result.code intValue] ==0)
        {
            if(!isLoadingMore_1)
            {
                [mArr_1 removeAllObjects];
            }

            NSArray *typeArr=(NSArray *)result.data;
            
            for(int i=0;i<typeArr.count;i++)
            {
                WaterFlowObj *wobj=[[WaterFlowObj alloc]initwithDic:[typeArr objectAtIndex:i]];
                [mArr_1 addObject:wobj];
            }
            
            [waterFlow_1 reloadData];
            if(!isLoadingMore_1)
            {
                [waterFlow_1 scorlltotopaaa];
            }
            pageindex_1++;
        }

        isLoadingMore_1=NO;
    }
    if([mkey isEqualToString:@"kgetWaterFlowUrl_2"])
    {
        if([result.code intValue] ==0)
        {
            if(!isLoadingMore_2)
            {
                [mArr_2 removeAllObjects];
            }

            NSArray *typeArr=(NSArray *)result.data;
            
            for(int i=0;i<typeArr.count;i++)
            {
                WaterFlowObj *wobj=[[WaterFlowObj alloc]initwithDic:[typeArr objectAtIndex:i]];
                wobj.ideaType = @"3";
                [mArr_2 addObject:wobj];
            }
            
            [waterFlow_2 reloadData];
            
            if(!isLoadingMore_2)
            {
                [waterFlow_2 scorlltotopaaa];
            }
            
            pageindex_2++;
        }

        isLoadingMore_2=NO;
    }
}

-(void)uploadfaild_global:(NSString *)mkey
{
    if([mkey isEqualToString:@"kgetWaterFlowUrl_1"])
    {
        isLoadingMore_1=NO;
    }
    if([mkey isEqualToString:@"kgetWaterFlowUrl_2"])
    {
        isLoadingMore_1=NO;
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[Global getInstanse] cancerRequest_key:@"kgetWaterFlowUrl"];
    segmentedControl.hidden=YES;
}

-(void)msegment_selected:(MySegmentedControl *)mseg index:(int)mindex
{
    [mseg showlineAnimaton];
    
    if(mseg.selectedSegmentIndex==0)
    {
        [mscrollview setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    else  if(mseg.selectedSegmentIndex==1)
    {
        [mscrollview setContentOffset:CGPointMake(kMainScreenBoundwidth, 0) animated:YES];
    }
}

-(void)Selectbutton:(UISegmentedControl*)mseg
{
    if(mseg.selectedSegmentIndex==0)
    {
        [mscrollview setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    else  if(mseg.selectedSegmentIndex==1)
    {
        [mscrollview setContentOffset:CGPointMake(kMainScreenBoundwidth, 0) animated:YES];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    
//    [self loadData:1];
//    [self loadData:2];
    
    
    
    segmentedControl.hidden=NO;
    
    if( segmentedControl.selectedSegmentIndex==0)
    {
        [mscrollview setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    else  if(segmentedControl.selectedSegmentIndex==1)
    {
        [mscrollview setContentOffset:CGPointMake(kMainScreenBoundwidth, 0) animated:YES];
    }
    //segmentedControl.selectedSegmentIndex=0;
    
    
   
}
-(void)backToFriend:(NSNotification*)noti
{
    segmentedControl.selectedSegmentIndex=0;
    [mscrollview setContentOffset:CGPointMake(0, 0) animated:YES];
    [segmentedControl showlineAnimaton];
}

-(void)backToSuggestion:(NSNotification*)noti
{
    segmentedControl.selectedSegmentIndex=1;
    [mscrollview setContentOffset:CGPointMake(0, 0) animated:YES];
    [segmentedControl showlineAnimaton];
}

//--------------------------------------------------------------waterflow
- (NSInteger)numberOfColumsInWaterFlowView:(WaterFlowView *)waterFlowView{
    
    return 2;
}

- (NSInteger)numberOfAllWaterFlowView:(WaterFlowView *)waterFlowView
{
    if(waterFlowView == waterFlow_1)
    {
        return [mArr_1 count];
    }
    else
    {
        return [mArr_2 count];
    }
}

- (UIView *)waterFlowView:(WaterFlowView *)waterFlowView cellForRowAtIndexPath:(IndexPath *)indexPath
{
    ImageViewCell *view = [[ImageViewCell alloc] initWithIdentifier:nil];
    view.delegate=self;
    
    return view;
}

-(void)waterFlowView:(WaterFlowView *)waterFlowView  relayoutCellSubview:(UIView *)view withIndexPath:(IndexPath *)indexPath
{
    //arrIndex是某个数据在总数组中的索引
    if(waterFlowView == waterFlow_1)
    {
        int arrIndex = indexPath.row * waterFlowView.columnCount + indexPath.column;
        
        WaterFlowObj *obj = [mArr_1 objectAtIndex:arrIndex];
        
        ImageViewCell *imageViewCell = (ImageViewCell *)view;
        imageViewCell.indexPath = indexPath;
        imageViewCell.columnCount = waterFlowView.columnCount;
        [imageViewCell relayoutViews];
        [imageViewCell setbtnObjct:obj];
        
        [imageViewCell setcenterviewColor:arrIndex%4];
    }
    else
    {
        int arrIndex = indexPath.row * waterFlowView.columnCount + indexPath.column;
        
        WaterFlowObj *obj = [mArr_2 objectAtIndex:arrIndex];
        
        ImageViewCell *imageViewCell = (ImageViewCell *)view;
        imageViewCell.indexPath = indexPath;
        imageViewCell.columnCount = waterFlowView.columnCount;
        [imageViewCell relayoutViews];
        [imageViewCell setbtnObjct:obj];
        
        [imageViewCell setcenterviewColor:arrIndex%4];
    }
}


#pragma mark WaterFlowViewDelegate
- (CGFloat)waterFlowView:(WaterFlowView *)waterFlowView heightForRowAtIndexPath:(IndexPath *)indexPath
{
    if(waterFlowView == waterFlow_1)
    {
        int arrIndex = indexPath.row * waterFlowView.columnCount + indexPath.column;
        WaterFlowObj *obj = [mArr_1 objectAtIndex:arrIndex];
        
        float width = 0.0f;
        float height = 0.0f;
        if (obj)
        {
            width =100;// [[dict objectForKey:@"width"] floatValue];
            height = 160;//[[dict objectForKey:@"height"] floatValue];
            if(arrIndex%2==0)
                height=170;
        }
        
        return waterFlowView.cellWidth * (height/width);
    }
    else
    {
        int arrIndex = indexPath.row * waterFlowView.columnCount + indexPath.column;
        WaterFlowObj *obj = [mArr_2 objectAtIndex:arrIndex];
        
        float width = 0.0f;
        float height = 0.0f;
        if (obj)
        {
            width =100;// [[dict objectForKey:@"width"] floatValue];
            height = 160;//[[dict objectForKey:@"height"] floatValue];
            if(arrIndex%2==0)
                height=170;
        }
        
        return waterFlowView.cellWidth * (height/width);
    }
}

- (void)waterFlowView:(WaterFlowView *)waterFlowView didSelectRowAtIndexPath:(IndexPath *)indexPath
{
    if(waterFlowView==waterFlow_1)
    {
        int arrIndex = indexPath.row * waterFlowView.columnCount + indexPath.column;
        IdeaDetailViewController *detail=[[IdeaDetailViewController alloc]initWithData:[mArr_1 objectAtIndex:arrIndex]];
        [self.navigationController pushViewController:detail animated:YES];
        [detail release];
    }
    else
    {
        int arrIndex = indexPath.row * waterFlowView.columnCount + indexPath.column;
        IdeaDetailViewController *detail=[[IdeaDetailViewController alloc]initWithData:[mArr_2 objectAtIndex:arrIndex]];
        [self.navigationController pushViewController:detail animated:YES];
        [detail release];
    }
}

-(void)gotoviewcontroller_imageviewcell_usercode:(NSInteger)muserCode
{
    NSString *ucode=[NSString stringWithFormat:@"%li",(long)muserCode];
    PersonaInfomationViewController *infomaton=[[PersonaInfomationViewController alloc]initwithuserCode:ucode ];
    [self.navigationController pushViewController:infomaton animated:YES];
    [infomaton release];
}

-(void)loadmore:(WaterFlowView *)waterFlowView
{
    if(waterFlowView==waterFlow_1)
    {
        if(isLoadingMore_1==YES)
        {
            return;
        }
        isLoadingMore_1=YES;
        
        
        NSString *page=[NSString stringWithFormat:@"%i-%i",(pageindex_1-1)*20+1,20*pageindex_1];
        [self loadMore:1 range:page];
    }
    else
    {
        if(isLoadingMore_2==YES)
        {
            return;
        }
        isLoadingMore_2=YES;
        
        
        NSString *page=[NSString stringWithFormat:@"%i",pageindex_2];
        
        [self loadMore:2 range:page];
    }
}

@end
