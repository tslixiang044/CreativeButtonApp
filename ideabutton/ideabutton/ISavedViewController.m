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
@interface ISavedViewController ()<UITableViewDataSource,UITableViewDelegate,MysaveCellDelegate,UIScrollViewDelegate>
{
    UITableView *mtableview;
    NSArray *marr;
    UIView *view_show;
    
    MyUIButton *btndelete;
    MyUIButton *btnwybz;
    MyUIButton *btnwygz;
    
    int oldrow;
}
@end

@implementation ISavedViewController

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
    marr=[[NSArray alloc]init];
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    
    dispatch_queue_t currentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(currentQueue, ^{
        //后台处理代码, 一般 http 请求在这里发, 然后阻塞等待返回, 收到返回处理
        marr = [[API sharedInstance] myCollectedIdeas:@{@"range":@"1-10"}];
        //处理完上面的后回到主线程去更新UI
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        dispatch_async(mainQueue, ^{
            [SVProgressHUD dismiss];
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
    return 60;
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
    
    cell.lbltitle.lineBreakMode = NSLineBreakByWordWrapping;
    cell.lbltitle.numberOfLines = 0;
    cell.lbltitle.text=[marr[indexPath.row] objectForKey:@"ideaContent"];
    cell.strid=[marr[indexPath.row] objectForKey:@"ideaId"];
    cell.mrow=indexPath.row;
    
    
    return cell;
}

-(void)btnshow:(NSString *)mid row:(int)mrow
{
    NSLog(@"mid=%@",mid);
    
    UITableViewCell *cell = [mtableview cellForRowAtIndexPath:[NSIndexPath indexPathForItem:mrow inSection:0]];
    
    CGPoint newCenter = [cell.contentView convertPoint:CGPointMake(0, 0) toView:self.view];
    
    
    
    if(view_show)
    {
        if([view_show isHidden])
        {
            [self showview:newCenter];
            oldrow=mrow;
        }
        else
        {
            if(oldrow==mrow)
            {
                [self hidenshowview];
            }
            else
            {
                [self showview:newCenter];
                oldrow=mrow;
            }
            
        }
    }
    else
    {
        [self showview:newCenter];
        oldrow=mrow;
    }

}
-(void)showview:(CGPoint)mpoint
{
    if(view_show==nil)
    {
        view_show=[[UIView alloc]init];
        view_show.backgroundColor=COLOR(47, 44, 43);
        [self.view addSubview:view_show];
        //--------------------
        btndelete = [MyUIButton buttonWithType:UIButtonTypeCustom];
        btndelete.frame =CGRectMake(kMainScreenBoundwidth-80-10-80-10-80-10, 10, 80, 40);
        [btndelete setTitle:@"我要删除" forState:UIControlStateNormal];
        btndelete.backgroundColor=COLOR(141, 144, 143);
        [btndelete setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btndelete addTarget:self action:@selector(btndeleteAction:) forControlEvents:UIControlEventTouchUpInside];
        [view_show addSubview:btndelete];
        //--------------------
        btnwybz = [MyUIButton buttonWithType:UIButtonTypeCustom];
        btnwybz.frame =CGRectMake(kMainScreenBoundwidth-80-10-80-10, 10, 80, 40);
        btnwybz.backgroundColor=COLOR(141, 144, 143);
        [btnwybz setTitle:@"我要霸占" forState:UIControlStateNormal];
        [btnwybz setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnwybz addTarget:self action:@selector(btnwybzAction:) forControlEvents:UIControlEventTouchUpInside];
        [view_show addSubview:btnwybz];
        //--------------------
        btnwygz = [MyUIButton buttonWithType:UIButtonTypeCustom];
        btnwygz.frame =CGRectMake(kMainScreenBoundwidth-80-10, 10, 80, 40);
        btnwygz.backgroundColor=COLOR(141, 144, 143);
        [btnwygz setTitle:@"我要改造" forState:UIControlStateNormal];
        [btnwygz setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnwygz addTarget:self action:@selector(btnwygzAction:) forControlEvents:UIControlEventTouchUpInside];
        [view_show addSubview:btnwygz];
        
    }
    view_show.hidden=NO;
    view_show.frame=CGRectMake(0, mpoint.y+60, kMainScreenBoundwidth, 60-2);
    [self.view bringSubviewToFront:view_show];
    
}

-(void)hidenshowview
{
    view_show.hidden=YES;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self hidenshowview];
}
-(void)btndeleteAction:(MyUIButton*)mbtn
{
    NSLog(@"aa");
}
-(void)btnwybzAction:(MyUIButton*)mbtn
{
    NSLog(@"bb");
}
-(void)btnwygzAction:(MyUIButton*)mbtn
{
    NSLog(@"cc");
}


@end
