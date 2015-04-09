















//
//  IChangedViewController.m
//  ideabutton
//
//  Created by Jian Hu on 15-2-9.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import "IoccupyDetailViewController.h"
#import "MychangedCell.h"
#import "SVProgressHUD.h"
#import "API.h"

@interface IoccupyDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *mtableview;
    NSArray *marr;
}
@end

@implementation IoccupyDetailViewController
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
    self.title=@"我霸占的";
    //----------
    
    UILabel* describeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, kMainScreenBoundwidth, 30)];
    describeLabel.textColor = [UIColor whiteColor];
    describeLabel.textAlignment=NSTextAlignmentCenter;
    describeLabel.text = @"我霸占的";
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
    mtableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 72, kMainScreenBoundwidth, kMainScreenBoundheight-64-72) style:UITableViewStylePlain];
    
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
        marr = [[API sharedInstance] myOccupiedIdeas:@{@"range":@"1-10"}];
        //处理完上面的后回到主线程去更新UI
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        dispatch_async(mainQueue, ^{
            [SVProgressHUD dismiss];
        });
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
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
    
    MychangedCell *cell=(MychangedCell *)[tableView dequeueReusableCellWithIdentifier:Identifier];
    if(cell==nil)
    {
        cell=[[MychangedCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier ];
        cell.backgroundColor=COLOR(21, 21, 23);
        cell.selectionStyle=UITableViewCellSelectionStyleNone ;
    }
    
    cell.lbltitle.lineBreakMode = NSLineBreakByWordWrapping;
    cell.lbltitle.numberOfLines = 0;
    cell.lbltitle.text=[marr[indexPath.row] objectForKey:@"ideaContent"];
    
    return cell;
}



@end

