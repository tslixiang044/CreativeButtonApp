//
//  PersonaInfomationViewController.m
//  ideabutton
//
//  Created by ZhouTong on 15-3-20.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import "PersonaInfomationViewController.h"
#import "MySegmentedControl.h"
#import "MymsgCell.h"

#define headerview_height 150


@interface PersonaInfomationViewController ()<UITableViewDataSource,UITableViewDelegate,MySegmentedControlDelegate>
{
    UITableView *mtableview;
    
    
    
    MySegmentedControl *msegmentview;
    UIView *headerview;
    UIImageView *imgview_header;
    UILabel *lblnickname;
    
    NSMutableArray *marr_share;
    NSMutableArray *marr_infor;
    NSMutableArray *marr_msg;
    
}
@end


@implementation  PersonaInfomationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=kgettitle;
    self.mtag=@"个人资料";
    [self setrightbaritem_imgname:@"icon_more_all.png" title:@""];
    //-----------------------------
    marr_share=[[NSMutableArray alloc]init];
    marr_infor=[[NSMutableArray alloc]init];
    marr_msg=[[NSMutableArray alloc]init];
    //-----------------------------
    
    mtableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenBoundwidth, kMainScreenBoundheight-64) style:UITableViewStylePlain];

    mtableview.backgroundColor=COLOR(21, 21, 23);;
    mtableview.backgroundView.backgroundColor=COLOR(21, 21, 23);
    
    mtableview.dataSource=self;
    mtableview.delegate=self;
    [self.view addSubview:mtableview];
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [mtableview setTableFooterView:v];
    //-----------------------------
}

-(void)btnright
{
    [self showMenuView];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0)
    {
        return 1;
    }
    else
    {
        if(msegmentview.selectedSegmentIndex==0)
        {
            return marr_share.count;
        }
        else if(msegmentview.selectedSegmentIndex==1)
        {
            return marr_infor.count;
        }
        else
        {
            return 20;//marr_msg.count;
        }
    }
  
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
        return headerview_height;
    else
        return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        static NSString *Identifier = @"mcell1";
        
        UITableViewCell *cell=(UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:Identifier];
        if(cell==nil)
        {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier ];
            cell.backgroundColor=COLOR(21, 21, 23);
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            [cell addSubview:[self getheaderview]];
            //----------------
        }
        return cell;
    }
    else
    {
        
        if(msegmentview.selectedSegmentIndex==0)
        {
            return nil;
        }
        else if(msegmentview.selectedSegmentIndex==1)
        {
            return nil;
        }
        else
        {
            static NSString *Identifier = @"cell_msg";
            
            MymsgCell *cell=(MymsgCell *)[tableView dequeueReusableCellWithIdentifier:Identifier];
            if(cell==nil)
            {
                cell=[[MymsgCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier ];
                cell.backgroundColor=COLOR(21, 21, 23);
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                
                
            }
            cell.imgview_left.image=[UIImage imageNamed:@"userheader.png"];
            cell.lbltitle.text=@"jack评论了我转发的idea";
            cell.lbltime.text=@"1分钟前";
            return cell;
        }
        
        
        
        
        
    }
    
}
-(UIView *)getheaderview
{
    if(headerview==nil)
    {
        headerview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenBoundwidth, headerview_height)];
        headerview.backgroundColor=[UIColor clearColor];
        //---------------
        imgview_header=[[UIImageView alloc]initWithFrame:CGRectMake((kMainScreenBoundwidth-60)/2, 30, 60, 60)];
        imgview_header.image=[UIImage imageNamed:@"btn_wyya.png"];
        [headerview addSubview:imgview_header];
        //---------------
        float y=imgview_header.frame.origin.y+imgview_header.frame.size.height+20;
        lblnickname=[[UILabel alloc]initWithFrame:CGRectMake(0, y , kMainScreenBoundwidth, 25)];
        lblnickname.text=@"昵称";
        lblnickname.textAlignment=NSTextAlignmentCenter;
        lblnickname.textColor=[UIColor whiteColor];
        [headerview addSubview:lblnickname];
        //---------------
    }
    return headerview;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section==1)
        return 44;
    else
        return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section==1)
    {
        if(msegmentview==nil)
        {
            
            NSArray *segmentarr=[[NSArray alloc]initWithObjects:@"我的分享",@"我的资料",@"我的消息", nil];
            msegmentview=[[MySegmentedControl alloc]initWithFrame:CGRectMake(0, 0, kMainScreenBoundwidth, 44)];
            msegmentview.items=segmentarr;
            msegmentview.delegate=self;
            
            msegmentview.backgroundColor=kGetNavbarColor;
        }
        
        return msegmentview;
    }
    else
    {
         UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
        return v;
    }
    
}
-(void)msegment_selected:(MySegmentedControl *)mseg index:(int)mindex
{
   

    [mseg showlineAnimaton];
    
    [mtableview reloadData];
}
@end
