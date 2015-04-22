//
//  ISavedViewController.m
//  ideabutton
//
//  Created by Jian Hu on 15-2-9.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import "ISavedViewController.h"
#import "MysaveCell.h"
#import "SVProgressHUD.h"
#import "API.h"
#import "MyUIButton.h"
#import "ReformIdeaViewController.h"




@interface ISavedViewController ()<UITableViewDataSource,UITableViewDelegate,MysaveCellDelegate,UIScrollViewDelegate>
{
    UITableView *mtableview;
    NSMutableArray *marr;
    UIView *view_show;
    int oldrow;
  
    
    MyUIButton *btndelete;
    MyUIButton *btnwybz;
    MyUIButton *btnwygz;
    
    BOOL ishiden;
    
    
}
@end

@implementation ISavedViewController
@synthesize delegate;


-(id)init
{
    self = [super init];
    if (self)
    {
        
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"我收藏的";
    
    ishiden=NO;
    oldrow=-1;
 
    //----------
    
    UILabel* describeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, kMainScreenBoundwidth, 30)];
    describeLabel.textColor = [UIColor whiteColor];
    describeLabel.textAlignment=NSTextAlignmentCenter;
    describeLabel.text = @"我收藏的";
    [self.view addSubview:describeLabel];
    //----
    UIImageView *imgview=[[UIImageView alloc]initWithFrame:CGRectMake(90, 30, 30, 30)];
    imgview.image=[UIImage imageNamed:@"icon_wscd.png"];
    [self.view addSubview:imgview];
    //----

    UIImageView* view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ideaRuleChoose/line_bg"]];
    view.frame = CGRectMake(0, 70, 320, 1);
    [self.view addSubview:view];
    //----------
    mtableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 72, kMainScreenBoundwidth, kMainScreenBoundheight-64-50-72) style:UITableViewStylePlain];
    
    mtableview.backgroundColor=COLOR(21, 21, 23);;
    mtableview.backgroundView.backgroundColor=COLOR(21, 21, 23);
    //        mtableview.scrollEnabled=NO;
    mtableview.dataSource=self;
    mtableview.delegate=self;
    [self.view addSubview:mtableview];
    
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [mtableview setTableFooterView:v];
    //---------
    marr=[[NSMutableArray alloc]init];
}

-(void)viewWillAppear:(BOOL)animated
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    
    dispatch_queue_t currentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(currentQueue, ^{
        //后台处理代码, 一般 http 请求在这里发, 然后阻塞等待返回, 收到返回处理
        marr = (NSMutableArray*)[[API sharedInstance] myCollectedIdeas:@{@"range":@"1-100"}];
        //处理完上面的后回到主线程去更新UI
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        dispatch_async(mainQueue, ^{
            [SVProgressHUD dismiss];
            
            [mtableview reloadData];
        });
    });
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [marr count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[self tableView:tableView cellForRowAtIndexPath:indexPath];
    float h=cell.frame.size.height;
    if(indexPath.row==oldrow)
    {
        if(ishiden)
        {
            return h;
        }
        else
        {
            return h+60;
        }
        
    }
    else
    {
        return h;
    }
    
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"mytoolcell";
    
    MysaveCell *cell=(MysaveCell *)[tableView dequeueReusableCellWithIdentifier:Identifier];
    if(cell==nil)
    {
        cell=[[MysaveCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier ];
        cell.delegate=self;
        cell.backgroundColor=COLOR(21, 21, 23);
        cell.selectionStyle=UITableViewCellSelectionStyleNone ;
    }
    
    NSString* comment =[marr[indexPath.row] objectForKey:@"ideaContent"];
    
    CGSize  labelSize = [comment sizeWithFont:[UIFont systemFontOfSize:15.0f]
                            constrainedToSize:CGSizeMake(260, 300)
                                lineBreakMode:NSLineBreakByWordWrapping];
    
    cell.lbltitle.frame=CGRectMake(30, 5, kMainScreenBoundwidth-80 , labelSize.height + 10);
    cell.lbltitle.text = comment;
    cell.lbltitle.textColor = [UIColor grayColor];
    cell.lbltitle.font = [UIFont systemFontOfSize:15.0f];
    cell.lbltitle.numberOfLines = 0;
    cell.lbltitle.lineBreakMode = NSLineBreakByWordWrapping;
    
    cell.strid=[marr[indexPath.row] objectForKey:@"ideaId"];
    cell.mrow=indexPath.row;
    
    cell.frame=CGRectMake(0, 0, kMainScreenBoundwidth, labelSize.height + 20);
    
    float h=labelSize.height+20;
    
    
    cell.btndelete.frame=CGRectMake(kMainScreenBoundwidth-80-10-80-10-80-20, h+5, 80, 40);
    cell.btnwybz.frame =CGRectMake(kMainScreenBoundwidth-80-10-80-20, h+5, 80, 40);
    cell.btnwygz.frame =CGRectMake(kMainScreenBoundwidth-80-20, h+5, 80, 40);
    if(indexPath.row==oldrow)
    {
        if(ishiden)
        {
            cell.btndelete.hidden=YES;
            cell.btnwybz.hidden=YES;
            cell.btnwygz.hidden=YES;
        }
        else
        {
            cell.btndelete.hidden=NO;
            cell.btnwybz.hidden=NO;
            cell.btnwygz.hidden=NO;
        }
        
    }
    else
    {
        cell.btndelete.hidden=YES;
        cell.btnwybz.hidden=YES;
        cell.btnwygz.hidden=YES;
    }
    
    
    
    return cell;
}

-(void)btnshow:(NSString *)mid row:(int)mrow 
{
    if(oldrow==mrow)
    {
        
        ishiden= ishiden==YES?NO:YES;
        
            
    }
    else
    {
        ishiden=NO;
    }
    oldrow=mrow;
    [mtableview reloadData];
    
//    UITableViewCell *cell = [mtableview cellForRowAtIndexPath:[NSIndexPath indexPathForItem:mrow inSection:0]];
//    
//    CGPoint newCenter = [cell.contentView convertPoint:CGPointMake(0, 0) toView:self.view];
//    
//    if(view_show)
//    {
//        if([view_show isHidden])
//        {
//            [self showview:newCenter ideaId:mid];
//            oldrow=mrow;
//        }
//        else
//        {
//            if(oldrow==mrow)
//            {
//                [self hidenshowview];
//            }
//            else
//            {
//                [self showview:newCenter ideaId:mid];
//                oldrow=mrow;
//            }
//        }
//    }
//    else
//    {
//        [self showview:newCenter ideaId:mid];
//        oldrow=mrow;
//    }
}

//-(void)showview:(CGPoint)mpoint ideaId:(NSString *)mideaId;
//{
//    if(view_show==nil)
//    {
//        view_show=[[UIView alloc]init];
//        view_show.backgroundColor=COLOR(47, 44, 43);
//        [self.view addSubview:view_show];
//        //--------------------
//        btndelete = [MyUIButton buttonWithType:UIButtonTypeCustom];
//        btndelete.frame =CGRectMake(kMainScreenBoundwidth-80-10-80-10-80-20, 10, 80, 40);
//        [btndelete setTitle:@"我要删除" forState:UIControlStateNormal];
//        btndelete.backgroundColor=COLOR(141, 144, 143);
//        [btndelete setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [btndelete addTarget:self action:@selector(btndeleteAction:) forControlEvents:UIControlEventTouchUpInside];
//        [view_show addSubview:btndelete];
//        //--------------------
//        btnwybz = [MyUIButton buttonWithType:UIButtonTypeCustom];
//        btnwybz.frame =CGRectMake(kMainScreenBoundwidth-80-10-80-20, 10, 80, 40);
//        btnwybz.backgroundColor=COLOR(141, 144, 143);
//        [btnwybz setTitle:@"我要霸占" forState:UIControlStateNormal];
//        [btnwybz setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [btnwybz addTarget:self action:@selector(btnwybzAction:) forControlEvents:UIControlEventTouchUpInside];
//        [view_show addSubview:btnwybz];
//        //--------------------
//        btnwygz = [MyUIButton buttonWithType:UIButtonTypeCustom];
//        btnwygz.frame =CGRectMake(kMainScreenBoundwidth-80-20, 10, 80, 40);
//        btnwygz.backgroundColor=COLOR(141, 144, 143);
//        [btnwygz setTitle:@"我要改造" forState:UIControlStateNormal];
//        [btnwygz setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [btnwygz addTarget:self action:@selector(btnwygzAction:) forControlEvents:UIControlEventTouchUpInside];
//        [view_show addSubview:btnwygz];
//        
//    }
//    btndelete.mtag=mideaId;
//    view_show.hidden=NO;
//    view_show.frame=CGRectMake(15, mpoint.y+60, kMainScreenBoundwidth, 60-2);
//    [self.view bringSubviewToFront:view_show];
//}

//-(void)hidenshowview
//{
//    view_show.hidden=YES;
//}
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    [self hidenshowview];
//}



-(void)btngo
{
        dispatch_queue_t currentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(currentQueue, ^{
            //后台处理代码, 一般 http 请求在这里发, 然后阻塞等待返回, 收到返回处理
    
            NSMutableDictionary *mdic=[[NSMutableDictionary alloc]init];
            
            NSString *strid=[NSString stringWithFormat:@"%@",[marr[oldrow] objectForKey:@"ideaId"]];
            
            
            [mdic setValue:strid forKey:@"userCollectId"];
    
            [[API sharedInstance] deleteCollectedIdea:mdic];
    
            //处理完上面的后回到主线程去更新UI
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            dispatch_async(mainQueue, ^{
    
                NSInteger codeValue = [[API sharedInstance].code integerValue];
                CGRect frame = CGRectMake(90,260,150,20);
                if(codeValue==0)
                {
                    //[self hidenshowview];
    
                    [self showalertview_text:@"删除成功" frame:frame autoHiden:YES];
                    for(int i=0;i<marr.count;i++)
                    {
                        NSDictionary *dic=[marr objectAtIndex:i];
                        int mid=[[NSString stringWithFormat:@"%@",[dic objectForKey:@"ideaId"]] intValue];
    
                        if(mid ==[strid intValue])
                        {
                            [marr removeObject:dic];
                        }
                    }
                    
                    
                    oldrow=-1;
                    ishiden=YES;
                    
                    [mtableview reloadData];
                }
                else
                {
                    [self showalertview_text:[API sharedInstance].msg frame:frame autoHiden:YES];
                }
            });
        });

}
-(void)btndeleteAction:(MyUIButton*)mbtn
{
    [self showAlertView_desc:@"确定?\n\n删除后可能再也看不到了" btnImage:@"bg_btn_qd_on" btnHideFlag:NO ActionType:4];

}

-(void)btnwybzAction:(MyUIButton*)mbtn
{
    if(delegate)
    {
        NSMutableDictionary   *mdict = [[NSMutableDictionary alloc] initWithDictionary:[marr objectAtIndex:oldrow]];
        [mdict setObject:[mdict objectForKey:@"ideaContent"] forKey:@"sentence"];
        ReformIdeaViewController *reform=[[ReformIdeaViewController alloc]initWithDict:mdict Type:1];
        [delegate gotoviewcontroller_save:reform];
    }
}
-(void)btnwygzAction:(MyUIButton*)mbtn
{
    if(delegate)
    {
        NSMutableDictionary* mdict = [[NSMutableDictionary alloc] initWithDictionary:[marr objectAtIndex:oldrow]];
        [mdict setObject:[mdict objectForKey:@"ideaContent"] forKey:@"sentence"];
        ReformIdeaViewController *reform=[[ReformIdeaViewController alloc]initWithDict:mdict Type:2];
        [delegate gotoviewcontroller_save:reform];
    }
}


@end
