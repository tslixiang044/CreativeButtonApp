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
#import "MyInformationCell.h"
#import "UIImageView+WebCache.h"
#import "API.h"
#import "MyUIButton.h"

#define headerview_height 150


@interface PersonaInfomationViewController ()<UITableViewDataSource,UITableViewDelegate,MySegmentedControlDelegate,UITextFieldDelegate>
{
    UITableView *mtableview;
    MySegmentedControl *msegmentview;
    UIView *headerview;
    UIImageView *imgview_header;
    UILabel *lblnickname;
    
    NSMutableArray *marr_share;
    NSMutableArray *marr_infor;
    NSMutableArray *marr_msg;
    
    
    UIView *view_update;
    UITextField *txtcontent;
    UITextField *txtcontent_2;
    
    MyUIButton *btncommit;
    UIView *view_center;
    
}
@end


@implementation  PersonaInfomationViewController
@synthesize user;
@synthesize dic_data;
@synthesize userCode;

-(id)init
{
    self=[super init];
    if(self)
    {
        
    }
    return self;
}
-(id)initwithuserCode:(NSString *)muserCode
{
   
    
    self.userCode=muserCode;
    
    return [self init];
}






- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=kgettitle;
    self.mtag=@"个人资料";
    [self setrightbaritem_imgname:@"icon_more_all.png" title:@""];
    self.user = [[DB sharedInstance] queryUser];
    NSString *ucode=[NSString stringWithFormat:@"%d",user.userCode];
    if([ucode isEqualToString:self.userCode] )
    {
        isSelf=YES;
    }
    else
    {
        isSelf=NO;
    }
    [self LoadData];
 

        //-------------------
    
}
-(void)LoadData
{
    NSString *code=@"";
    if(self.userCode!=nil &&  ![self.userCode isEqualToString:@""])
    {
        code=self.userCode;
        [self loadUserInfo:code];
    }
//    else
//    {
//        self.user = [[DB sharedInstance] queryUser];
//        if(user)
//        {
//            code=[NSString stringWithFormat:@"%d",user.userCode];
//            [self loadUserInfo:code];
//        }
//    }
}
-(void)loadUserInfo:(NSString *)mcode
{
    dispatch_queue_t currentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(currentQueue, ^{
        //后台处理代码, 一般 http 请求在这里发, 然后阻塞等待返回, 收到返回处理
        
        
        NSMutableDictionary *mdic=[[NSMutableDictionary alloc]init];
        
        
        
        
        [mdic setValue:mcode forKey:@"userCode"];
        
        NSDictionary * back_dic=  [[API sharedInstance] userInfo:mdic];
        
        
        //处理完上面的后回到主线程去更新UI
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        dispatch_async(mainQueue, ^{
            
            
            NSInteger codeValue = [[back_dic objectForKey:@"code"] integerValue];
            
            if(codeValue==0)
            {
                dic_data=[back_dic objectForKey:@"data"];
                [self LoadMsgList];
                [self initview];
                
            }
            else
            {
                
            }
        });
    });

}
-(void)setUserCode:(NSString *)muserCode
{
    if(muserCode==nil)
    {
        return;
    }
    if(userCode)
    {
        userCode=nil;
        
    }
    userCode=muserCode;
    //------------------
    
    
    
    
    
    
    
}
-(void)LoadMsgList
{
//    dispatch_queue_t currentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_async(currentQueue, ^{
//        //后台处理代码, 一般 http 请求在这里发, 然后阻塞等待返回, 收到返回处理
//        NSDictionary * back_dic=  [[API sharedInstance] userMessages:nil];
//
//        //处理完上面的后回到主线程去更新UI
//        dispatch_queue_t mainQueue = dispatch_get_main_queue();
//        dispatch_async(mainQueue, ^{
//            
//            
//            NSInteger codeValue = [[back_dic objectForKey:@"code"] integerValue];
//            
//            if(codeValue==0)
//            {
//              
//            }
//            else
//            {
//                
//            }
//        });
//    });
}
-(void)initview
{
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
    UIEdgeInsets edgeInset = mtableview.separatorInset;
    mtableview.separatorInset = UIEdgeInsetsMake(edgeInset.top, 0, edgeInset.bottom, 0);
    //修改分隔线长度
    mtableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;

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
            return 8;//marr_infor.count;
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
            static NSString *Identifier = @"cell_info";
            
            MyInformationCell *cell=(MyInformationCell *)[tableView dequeueReusableCellWithIdentifier:Identifier];
            if(cell==nil)
            {
                cell=[[MyInformationCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier ];
                cell.backgroundColor=COLOR(21, 21, 23);
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                
            }
         
          if(indexPath.row==0)
          {
              cell.lbltitle.text=@"昵称";
              NSString *nickname=[dic_data objectForKey:@"nickname"];
              
              cell.lbldesc.text=nickname;
              
              cell.accessoryType=UITableViewCellAccessoryNone;
          }
          else if(indexPath.row==1)
          {
              cell.lbltitle.text=@"性别";
              NSString *str_sex=@"男";
              
              if([[dic_data objectForKey:@"gender"] integerValue]==0)
              {
                  str_sex=@"女";
              }
              cell.lbldesc.text=str_sex;
              
              
              
              if(isSelf)
              {
                 cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
              }
              else
              {
                  cell.accessoryType=UITableViewCellAccessoryNone;
              }
          }
          else  if(indexPath.row==2)
          {
                cell.lbltitle.text=@"邮箱";
                cell.lbldesc.text=[dic_data objectForKey:@"email"];
              
              if(isSelf)
              {
                  cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
              }
              else
              {
                  cell.accessoryType=UITableViewCellAccessoryNone;
              }
          }
          else if(indexPath.row==3)
          {
              cell.lbltitle.text=@"密码";
              cell.lbldesc.text=@"******";
              
              if(isSelf)
              {
                  cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
              }
              else
              {
                  cell.accessoryType=UITableViewCellAccessoryNone;
              }
          }
          else if(indexPath.row==4)
          {
              cell.lbltitle.text=@"真实姓名";
              NSString *name=@"";;
              if([dic_data objectForKey:@"userFullname"]!=nil)
              {
                  name=[dic_data objectForKey:@"userFullname"];
              }
              cell.lbldesc.text=name;
              
              cell.accessoryType=UITableViewCellAccessoryNone;
          }
          else if(indexPath.row==5)
          {
              cell.lbltitle.text=@"所属地";
              cell.lbldesc.text=[dic_data objectForKey:@"city"];
              
              if(isSelf)
              {
                  cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
              }
              else
              {
                  cell.accessoryType=UITableViewCellAccessoryNone;
              }
          }
          else if(indexPath.row==6)
          {
              cell.lbltitle.text=@"院校";
              cell.lbldesc.text=[dic_data objectForKey:@"college"];
              
              if(isSelf)
              {
                  cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
              }
              else
              {
                  cell.accessoryType=UITableViewCellAccessoryNone;
              }
          }
        
          else if(indexPath.row==7)
          {
              cell.lbltitle.text=@"专业";
              cell.lbldesc.text=[dic_data objectForKey:@"major"];
              
              if(isSelf)
              {
                  cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
              }
              else
              {
                  cell.accessoryType=UITableViewCellAccessoryNone;
              }
          }

            return cell;
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
        //imgview_header.image=[UIImage imageNamed:@"btn_wyya.png"];
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
    lblnickname.text=[dic_data objectForKey:@"nickname"];

    
    NSString *str_img_url=[NSString stringWithFormat:@"%@%@",BASEURL,[dic_data objectForKey:@"avatar"]];
    
    [imgview_header setImageWithURL:[NSURL URLWithString:str_img_url] placeholderImage:[UIImage imageNamed:@"register_head"]];

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
        NSArray *segmentarr;
        if(msegmentview==nil)
        {
            NSString *ucode=[NSString stringWithFormat:@"%d",user.userCode];
            if([ucode isEqualToString:self.userCode] )
            {
                segmentarr=[[NSArray alloc]initWithObjects:@"我的分享",@"我的资料",@"我的消息", nil];
                
            }
            else
            {
                segmentarr=[[NSArray alloc]initWithObjects:@"我的分享",@"我的资料", nil];
            }
            
            
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(isSelf)
    {
        if(msegmentview.selectedSegmentIndex==1)
        {
            if(indexPath.row==1)
            {
                [self showUpdateView:@"gender"];
            }
            if(indexPath.row==2)
            {
                [self showUpdateView:@"email"];
            }
            if(indexPath.row==3)
            {
                [self showUpdateView:@"password"];
            }
            if(indexPath.row==5)
            {
                [self showUpdateView:@"city"];
            }
            if(indexPath.row==6)
            {
                [self showUpdateView:@"college"];
            }
            if(indexPath.row==7)
            {
                [self showUpdateView:@"major"];
            }
            
            
            
            
        }

    }
}

-(void)msegment_selected:(MySegmentedControl *)mseg index:(int)mindex
{
   

    [mseg showlineAnimaton];
    
    [mtableview reloadData];
}


-(void)showUpdateView:(NSString *)mkey
{
    if(view_update==nil)
    {
        view_update=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenBoundwidth, kMainScreenBoundheight-64)];
        view_update.backgroundColor=[UIColor clearColor];
        [self.view addSubview:view_update];
        //------
        UIButton *  btnclose = [UIButton buttonWithType:UIButtonTypeCustom];
        btnclose.frame = view_update.frame;
        
        btnclose.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [btnclose addTarget:self action:@selector(btncloseAction:) forControlEvents:UIControlEventTouchUpInside];
        [view_update addSubview:btnclose];
        //------
        view_center=[[UIView alloc]initWithFrame:CGRectMake(20, (kMainScreenBoundheight-64-150)/2-20, kMainScreenBoundwidth-40, 180)];
        view_center.backgroundColor=COLOR(21, 21, 21);;
        
        //[view_center.layer setBorderColor: [[UIColor whiteColor] CGColor]];
        //[view_center.layer setBorderWidth: 1.0];
        [view_center.layer setCornerRadius:8.0f];
        [view_center.layer setMasksToBounds:YES];
        
        [view_update addSubview:view_center];
        //------
        txtcontent=[[UITextField alloc]initWithFrame:CGRectMake(10, 20, view_center.frame.size.width-20, 30)];
        txtcontent.textColor=[UIColor blackColor];
        txtcontent.clearButtonMode=UITextFieldViewModeWhileEditing;
        //txtcontent.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入你的手机/邮箱/qq(选填)" attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
        txtcontent.font=[UIFont fontWithName:@"Arial" size:14];
        txtcontent.backgroundColor=[UIColor whiteColor];
        txtcontent.textAlignment=NSTextAlignmentLeft;
        txtcontent.returnKeyType=UIReturnKeyDone;
        txtcontent.delegate=self;
        [txtcontent.layer setBorderColor: [[UIColor whiteColor] CGColor]];
        [txtcontent.layer setBorderWidth: 1.0];
        [txtcontent.layer setCornerRadius:8.0f];
        [txtcontent.layer setMasksToBounds:YES];
        
        [txtcontent setBorderStyle:UITextBorderStyleRoundedRect];
        [view_center addSubview:txtcontent];
        //------
        float y=txtcontent.frame.origin.y+txtcontent.frame.size.height+5;
        txtcontent_2=[[UITextField alloc]initWithFrame:CGRectMake(10, y, view_center.frame.size.width-20, 30)];
        txtcontent_2.textColor=[UIColor blackColor];
        txtcontent_2.clearButtonMode=UITextFieldViewModeWhileEditing;
        //txtcontent.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入你的手机/邮箱/qq(选填)" attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
        txtcontent_2.font=[UIFont fontWithName:@"Arial" size:14];
        txtcontent_2.backgroundColor=[UIColor whiteColor];
        txtcontent_2.textAlignment=NSTextAlignmentLeft;
        txtcontent_2.returnKeyType=UIReturnKeyDone;
        txtcontent_2.delegate=self;
        
        
        
        [txtcontent_2.layer setBorderColor: [[UIColor whiteColor] CGColor]];
        [txtcontent_2.layer setBorderWidth: 1.0];
        [txtcontent_2.layer setCornerRadius:8.0f];
        [txtcontent_2.layer setMasksToBounds:YES];
        
        [txtcontent_2 setBorderStyle:UITextBorderStyleRoundedRect];
        [view_center addSubview:txtcontent_2];
        txtcontent_2.hidden=YES;
        //--------
        y=txtcontent.frame.origin.y+txtcontent.frame.size.height+20;
        
        
        btncommit = [MyUIButton buttonWithType:UIButtonTypeCustom];
        btncommit.frame = CGRectMake((view_center.frame.size.width-70)/2, y  , 70, 70);
        [btncommit setBackgroundImage:[UIImage imageNamed:@"all_btn_qd.png"] forState:UIControlStateNormal];
        [btncommit addTarget:self action:@selector(btncommitAction:) forControlEvents:UIControlEventTouchUpInside];
        [view_center addSubview:btncommit];
        //------

        
    }
    view_center.frame=CGRectMake(20, (kMainScreenBoundheight-64-150)/2-20, kMainScreenBoundwidth-40, 180) ;
    float y=txtcontent.frame.origin.y+txtcontent.frame.size.height+20;
    btncommit.frame = CGRectMake((view_center.frame.size.width-70)/2, y  , 70, 70);
    txtcontent_2.hidden=YES;
    view_update.hidden=NO;
    [self.view bringSubviewToFront:view_update];
    //----------------------
    
    if([mkey isEqualToString:@"email"])
    {
        txtcontent.text=[dic_data objectForKey:@"email"];
        btncommit.mtag=@"email";
    }
    if([mkey isEqualToString:@"college"])
    {
        txtcontent.text=[dic_data objectForKey:@"college"];
        btncommit.mtag=@"college";
    }
    if([mkey isEqualToString:@"major"])
    {
        txtcontent.text=[dic_data objectForKey:@"major"];
        btncommit.mtag=@"major";
    }
    if([mkey isEqualToString:@"password"])
    {
        txtcontent_2.hidden=NO;
        view_center.frame=CGRectMake(20, (kMainScreenBoundheight-64-150)/2-20, kMainScreenBoundwidth-40, 180+40) ;
        float y=txtcontent_2.frame.origin.y+txtcontent_2.frame.size.height+20;
        btncommit.frame = CGRectMake((view_center.frame.size.width-70)/2, y  , 70, 70);
        txtcontent.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入你的新密码" attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
        txtcontent_2.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请再次输入你的新密码" attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
        
        
      
        btncommit.mtag=@"password";
    }
    
    
    
    
}
-(void)btncloseAction:(UIButton *)mbtn
{
    view_update.hidden=YES;
}
-(void)btncommitAction:(MyUIButton *)mbtn
{
   
    if([mbtn.mtag isEqualToString:@"email"])
    {
     
        
        dispatch_queue_t currentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(currentQueue, ^{
            //后台处理代码, 一般 http 请求在这里发, 然后阻塞等待返回, 收到返回处理
            
            
            NSMutableDictionary *mdic=[[NSMutableDictionary alloc]init];

            [mdic setValue:self.userCode forKey:@"userCode"];
            [mdic setValue:txtcontent.text forKey:@"email"];
            
           User* back_dic=  [[API sharedInstance] updateUser:mdic];
            
            
            //处理完上面的后回到主线程去更新UI
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            dispatch_async(mainQueue, ^{
                
                
                NSInteger codeValue = [[API sharedInstance].code integerValue];
                
                if(codeValue==0)
                {
                  
                }
                else
                {
                    
                }
            });
        });

        
    }
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}



@end
