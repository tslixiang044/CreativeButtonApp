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
#import "MyUIButton.h"
#import "ZTModel.h"
#import "DB.h"

@interface MainViewController ()<UITextFieldDelegate,WaterFlowViewDelegate,WaterFlowViewDataSource,Globaldelegate>
{
    NSMutableArray *mArr;
    WaterFlowView *waterFlow;
    //------------------
    UISegmentedControl *segmentedControl;
    UITextField *txtsearch;
}
@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //------
    mArr=[[NSMutableArray alloc]init];
   //-------------
    segmentedControl=[[UISegmentedControl alloc] initWithFrame:CGRectMake(0, 0, kMainScreenBoundwidth, 44) ];
    [segmentedControl insertSegmentWithTitle:@"按友圈" atIndex:0 animated:YES];
    [segmentedControl insertSegmentWithTitle:@"我也要按" atIndex:1 animated:YES];
    segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    segmentedControl.selectedSegmentIndex=0;
    [segmentedControl addTarget:self action:@selector(Selectbutton:) forControlEvents:UIControlEventValueChanged];
    [self.navigationController.navigationBar addSubview:segmentedControl];
    //-------------
    UIView *view_search_bg=[[UIView alloc]initWithFrame:CGRectMake(10, 5, kMainScreenBoundwidth-20, 44)];
    view_search_bg.backgroundColor=COLOR(123, 95, 33);
    [self.view addSubview:view_search_bg];
    //-------------
    txtsearch=[[UITextField alloc]initWithFrame:CGRectMake(2, 2, view_search_bg.bounds.size.width-100, view_search_bg.bounds.size.height-4)];
    txtsearch.textColor=[UIColor whiteColor];
    txtsearch.clearButtonMode=UITextFieldViewModeWhileEditing;
    txtsearch.backgroundColor=[UIColor clearColor];
    txtsearch.delegate=self;
    [txtsearch.layer setBackgroundColor:[COLOR(4, 4, 4) CGColor]];
    txtsearch.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"按产品类别搜索" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [txtsearch.layer setMasksToBounds:YES];
    [view_search_bg addSubview:txtsearch];
    //-------------
    
    float y=view_search_bg.frame.origin.y+view_search_bg.frame.size.height+5;
    waterFlow = [[WaterFlowView alloc] initWithFrame:CGRectMake(0, y, kMainScreenBoundwidth, kMainScreenBoundheight-64-y)];
    waterFlow.waterFlowViewDelegate = self;
    waterFlow.waterFlowViewDatasource = self;
    waterFlow.backgroundColor = [UIColor blackColor];
    [self.view addSubview:waterFlow];
    //----------------
//    [self loadData];
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
        if([result.code isEqualToString:@"0"])
        {
            NSArray *typeArr=(NSArray *)result.list;
            
            for(int i=0;i<typeArr.count;i++)
            {
                WaterFlowObj *wobj=[[WaterFlowObj alloc]initwithDic:[typeArr objectAtIndex:i]];
                [mArr addObject:wobj];
            }

            [waterFlow reloadData];
        }
        else
        {
            [self showalertview_text:result.msg imgname:nil autoHiden:YES];
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
}

-(void)Selectbutton:(UISegmentedControl*)mseg
{
    if(mseg.selectedSegmentIndex==0)
    {
        
    }
    else  if(mseg.selectedSegmentIndex==1)
    {
        mseg.hidden=YES;
//        User* user = [[DB sharedInstance]queryUser];
//        if (user)
//        {
//            [self.navigationController pushViewController:[[IAlsoPressViewController alloc]init] animated:YES];
//        }
//        else
        {
            [self.navigationController pushViewController:[[LoginViewController alloc] init] animated:YES];
        }
        
    }
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


-(void)waterFlowView:(WaterFlowView *)waterFlowView  relayoutCellSubview:(UIView *)view withIndexPath:(IndexPath *)indexPath{
    
    //arrIndex是某个数据在总数组中的索引
    int arrIndex = indexPath.row * waterFlowView.columnCount + indexPath.column;
    
    
    WaterFlowObj *obj = [mArr objectAtIndex:arrIndex];
    
    //    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://imgur.com/%@%@", [object objectForKey:@"hash"], [object objectForKey:@"ext"]]];
    //NSLog(@"img=%@",obj.img1);
    NSURL *URL = [NSURL URLWithString:obj.img1];
    
    ImageViewCell *imageViewCell = (ImageViewCell *)view;
    imageViewCell.indexPath = indexPath;
    imageViewCell.columnCount = waterFlowView.columnCount;
    [imageViewCell relayoutViews];
    [(ImageViewCell *)view setImageWithURL:URL];
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
        height = 150;//[[dict objectForKey:@"height"] floatValue];
    }
    
    return waterFlowView.cellWidth * (height/width);
}

- (void)waterFlowView:(WaterFlowView *)waterFlowView didSelectRowAtIndexPath:(IndexPath *)indexPath{
    
    NSLog(@"indexpath row == %d,column == %d",indexPath.row,indexPath.column);
}
@end
