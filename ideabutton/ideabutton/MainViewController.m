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
#import "WaitPageViewController.h"
#import "InteractivePageViewController.h"
#import "IdeaDetailViewController.h"
#import "DB.h"

@interface MainViewController ()<UITextFieldDelegate,WaterFlowViewDelegate,WaterFlowViewDataSource,Globaldelegate,LoginViewControllerDelegate>
{
    
    NSMutableArray *mArr;
    WaterFlowView *waterFlow;
    //------------------
    UISegmentedControl *segmentedControl;
    UITextField *txtsearch;
    
    UIView *bottomView;
}
@end

@implementation MainViewController

-(void)dealloc
{
    [segmentedControl release];
    [txtsearch release];
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //------
    mArr=[[NSMutableArray alloc]init];
   //-------------
    segmentedControl=[[UISegmentedControl alloc] initWithFrame:CGRectMake(0, 0, kMainScreenBoundwidth, 44) ];
    [segmentedControl insertSegmentWithTitle:@"按友圈" atIndex:0 animated:YES];
    [segmentedControl insertSegmentWithTitle:@"建议烂" atIndex:1 animated:YES];
    segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    segmentedControl.selectedSegmentIndex=0;
    [segmentedControl addTarget:self action:@selector(Selectbutton:) forControlEvents:UIControlEventValueChanged];
    [self.navigationController.navigationBar addSubview:segmentedControl];
    
    //-------
    mscrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenBoundwidth, kMainScreenBoundheight-64-50)];
    mscrollview.backgroundColor=[UIColor grayColor];
    [self.view addSubview:mscrollview];
    //-------
  
    waterFlow = [[WaterFlowView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenBoundwidth, kMainScreenBoundheight-64-50)];
    waterFlow.tag=1;
    waterFlow.waterFlowViewDelegate = self;
    waterFlow.waterFlowViewDatasource = self;
    waterFlow.backgroundColor = [UIColor blackColor];
    [mscrollview addSubview:waterFlow];
    [waterFlow release];
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
    btnadmin.frame = CGRectMake(kMainScreenBoundwidth-35-7, 7 , 35, 35);
    [btnadmin setBackgroundImage:[UIImage imageNamed:@"icon_admin.png"] forState:UIControlStateNormal];
    [btnadmin addTarget:self action:@selector(btnadminAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:btnadmin];
    //------------------
    
    
    [self loadData];
    
    
    
    
    
    
    
}
-(void)btnadminAction
{
    
}
-(void)btnwyyaAction
{
            segmentedControl.hidden=YES;
    
   
            User* user = [[DB sharedInstance]queryUser];
            if (user)
            {
                IAlsoPressViewController *press=[[IAlsoPressViewController alloc]init];
                [self.navigationController pushViewController:press animated:YES];
                [press release];
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
-(void)loadData
{
    NSString *url=kgetWaterFlowUrl;
    
    [[Global getInstanse] getHttpRequest_url:url key:@"kgetWaterFlowUrl" delegate:self];
}
-(void)loadMore
{
    
}
-(void)uploadfinished_global:(NSData *)responseData key:(NSString *)mkey
{
    NSDictionary *mdic=[Global  GetdicwithData:responseData];
    
    JsonResult *result=[[JsonResult alloc]initwithDic:mdic];
    
    if([mkey isEqualToString:@"kgetWaterFlowUrl"])
    {
        if([result.code intValue] ==0)
        {
            NSArray *typeArr=(NSArray *)result.data;
            
            for(int i=0;i<typeArr.count;i++)
            {
                WaterFlowObj *wobj=[[WaterFlowObj alloc]initwithDic:[typeArr objectAtIndex:i]];
                [mArr addObject:wobj];
            }

               [waterFlow reloadData];
        }
        else
        {
            //[self showalertview_text:result.msg frame:<#(CGRect)#> autoHiden:<#(BOOL)#>
        }
    }
}

-(void)uploadfaild_global:(NSString *)mkey
{
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[Global getInstanse] cancerRequest_key:@"kgetWaterFlowUrl"];
    segmentedControl.hidden=YES;
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

//    if(mseg.selectedSegmentIndex==0)
//    {
//        
//    }
//    else  if(mseg.selectedSegmentIndex==1)
//    {
//        mseg.hidden=YES;
//        
////        IAlsoPressViewController *press=[[IAlsoPressViewController alloc]init];
////        [self.navigationController pushViewController:press animated:YES];
//        User* user = [[DB sharedInstance]queryUser];
//        if (user)
//        {
//            IAlsoPressViewController *press=[[IAlsoPressViewController alloc]init];
//            [self.navigationController pushViewController:press animated:YES];
//        }
//        else
//        {
//            LoginViewController *login=[[LoginViewController alloc] init];
//            login.delegate=self;
//            [self.navigationController pushViewController:login animated:YES];
//            [login release];
//        }
//    }
}
-(void)loginSuccessfull
{
    IAlsoPressViewController *press=[[IAlsoPressViewController alloc]init];
    [self.navigationController pushViewController:press animated:YES];
    [press release];
}
-(void)viewWillAppear:(BOOL)animated
{
    segmentedControl.hidden=NO;
    segmentedControl.selectedSegmentIndex=0;
}
//--------------------------------------------------------------waterflow
- (NSInteger)numberOfColumsInWaterFlowView:(WaterFlowView *)waterFlowView{
    
    return 2;
}

- (NSInteger)numberOfAllWaterFlowView:(WaterFlowView *)waterFlowView{
    
    return [mArr count];
}

- (UIView *)waterFlowView:(WaterFlowView *)waterFlowView cellForRowAtIndexPath:(IndexPath *)indexPath{
    
    ImageViewCell *view = [[ImageViewCell alloc] initWithIdentifier:nil];
    
    return view;
}


-(void)waterFlowView:(WaterFlowView *)waterFlowView  relayoutCellSubview:(UIView *)view withIndexPath:(IndexPath *)indexPath
{
    //arrIndex是某个数据在总数组中的索引
    int arrIndex = indexPath.row * waterFlowView.columnCount + indexPath.column;

    WaterFlowObj *obj = [mArr objectAtIndex:arrIndex];

    ImageViewCell *imageViewCell = (ImageViewCell *)view;
    imageViewCell.indexPath = indexPath;
    imageViewCell.columnCount = waterFlowView.columnCount;
    [imageViewCell relayoutViews];
    [imageViewCell setbtnObjct:obj];
}


#pragma mark WaterFlowViewDelegate
- (CGFloat)waterFlowView:(WaterFlowView *)waterFlowView heightForRowAtIndexPath:(IndexPath *)indexPath{
    
    int arrIndex = indexPath.row * waterFlowView.columnCount + indexPath.column;
    WaterFlowObj *obj = [mArr objectAtIndex:arrIndex];
    
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

- (void)waterFlowView:(WaterFlowView *)waterFlowView didSelectRowAtIndexPath:(IndexPath *)indexPath
{
    IdeaDetailViewController *detail=[[IdeaDetailViewController alloc]init];
    [self.navigationController pushViewController:detail animated:YES];
    [detail release];
}
@end
