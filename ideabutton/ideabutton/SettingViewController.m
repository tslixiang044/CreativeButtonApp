//
//  SettingViewController.m
//  ideabutton
//
//  Created by ZhouTong on 15-3-20.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingCell.h"
#import "MyWebviewViewController.h"

@interface SettingViewController ()<UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UITableView *mtableview;
}
@end

@implementation SettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title=@"BUTTON 4 CREATIVE";
    //------------------------
    mtableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 20, kMainScreenBoundwidth, 200) style:UITableViewStylePlain];
    
    mtableview.backgroundColor=[UIColor blackColor];
    mtableview.backgroundView.backgroundColor=[UIColor blackColor];
    mtableview.dataSource=self;
    mtableview.delegate=self;
    [self.view addSubview:mtableview];
    mtableview.scrollEnabled=NO;
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [mtableview setTableFooterView:v];
    
    //------------------------
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *Identifier = @"setcell";
    
    SettingCell *cell=(SettingCell *)[tableView dequeueReusableCellWithIdentifier:Identifier];
    if(cell==nil)
    {
        cell=[[SettingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier ];
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone ;
        cell.backgroundColor=COLOR(21, 21, 22);
    }
    if(indexPath.row==0)
    {
        cell.lbldesc.text=@"新消息通知";
        
    }
    else if(indexPath.row==1)
    {
        cell.lbldesc.text=@"检测自动更新(仅WIFI环境使用)";
        
    }
    else if(indexPath.row==2)
    {
        cell.lbldesc.text=@"清除缓存";
        cell.mswitch.hidden=YES;
    }
    else if(indexPath.row==3)
    {
        cell.lbldesc.text=@"关于";
        cell.mswitch.hidden=YES;
    }

    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==2)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"确定清除缓存吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定" , nil];
        [alert show];
        
    }
    else if(indexPath.row==3)
    {
        MyWebviewViewController *web=[[MyWebviewViewController alloc]init];
        self.title=@"关于";
        web.filename=@"xieyi";
        [self.navigationController pushViewController:web animated:YES];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
        NSLog(@"清除缓存");
    }
}


@end
