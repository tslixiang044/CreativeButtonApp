//
//  MyToolView.m
//  ideabutton
//
//  Created by ZhouTong on 15-2-27.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import "MyToolView.h"
#import "MytoolviewCell.h"
#import "Config.h"
#import "DB.h"
#import "API.h"

@implementation MyToolView
@synthesize delegate;

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        user = [[DB sharedInstance]queryUser];
        btnClose = [UIButton buttonWithType:UIButtonTypeCustom];
        btnClose.frame = CGRectMake(0, 0, kMainScreenBoundwidth, kMainScreenBoundheight-64);
        btnClose.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:.5];
        [btnClose addTarget:self action:@selector(btnCloseAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnClose];
        //---------
        mtableview=[[UITableView alloc]initWithFrame:CGRectMake(kMainScreenBoundwidth-200, 0, 200, kMainScreenBoundheight-64-80) style:UITableViewStylePlain];
        
        mtableview.backgroundColor=COLOR(21, 21, 23);;
        mtableview.backgroundView.backgroundColor=COLOR(21, 21, 23);
//        mtableview.scrollEnabled=NO;
        mtableview.dataSource=self;
        mtableview.delegate=self;
        [self addSubview:mtableview];
        
        UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
        [mtableview setTableFooterView:v];
        //---------
        marr=[[NSMutableArray alloc]init];
    }
    return self;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (user)
    {
        return 7;
    }
    else
    {
        return 6;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"mytoolcell";
    
    MytoolviewCell *cell=(MytoolviewCell *)[tableView dequeueReusableCellWithIdentifier:Identifier];
    if(cell==nil)
    {
       cell=[[MytoolviewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier ];
       cell.backgroundColor=COLOR(21, 21, 23);
    }

    if(indexPath.row==0)
    {
        cell.imgview_left.image=[UIImage imageNamed:@"icon_wdzy"];
        cell.lbltitle.text=@"我的主页";
    }
    else if(indexPath.row==1)
    {
        cell.imgview_left.image=[UIImage imageNamed:@"icon_wyfx"];
        cell.lbltitle.text=@"我要分享";
    }
    else if(indexPath.row==2)
    {
        cell.imgview_left.image=[UIImage imageNamed:@"icon_sysm"];
        cell.lbltitle.text=@"使用说明";
    }
    else if(indexPath.row==3)
    {
        cell.imgview_left.image=[UIImage imageNamed:@"icon_gfwb"];
        cell.lbltitle.text=@"官方微博";
    }
    else if(indexPath.row==4)
    {
        cell.imgview_left.image=[UIImage imageNamed:@"icon_gfwx"];
        cell.lbltitle.text=@"官方微信";
    }
    else if(indexPath.row==5)
    {
        cell.imgview_left.image=[UIImage imageNamed:@"icon_gfwz"];
        cell.lbltitle.text=@"官方网站";
    }
    else if(indexPath.row==6 && user)
    {
        cell.imgview_left.image=[UIImage imageNamed:@"icon_tcdl"];
        cell.lbltitle.text=@"退出登录";
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 0:
            break;
        case 1:
            break;
        case 2:
            break;
        case 3:
            break;
        case 4:
            break;
        case 5:
            break;
        case 6:
            [[DB sharedInstance]clearCacheExcept:@[@"ctrler:login:last-login-name"]];
            [API sharedInstance].user = nil;
            if(delegate)
            {
                [delegate LoginOUt];
            }
            
            break;
            
        default:
            break;
    }
    
    [self hidentoolView];
}

-(void)btnCloseAction:(UIButton *)mbtn
{
    //NSLog(@"close");
    
    [self hidentoolView];
}

-(void)hidentoolView
{
    [UIView animateWithDuration:0.3 animations:^{
        
        self.frame=CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
        
    } completion:^(BOOL finished){
        
        self.hidden=YES;
        
    }];
}

-(void)showtoolView
{
    if([self isHidden])
    {
        [UIView animateWithDuration:0.3f animations:^{
            self.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
            self.hidden=NO;
        }];
    }
    else
    {
        [self hidentoolView];
    }
    
}
@end
