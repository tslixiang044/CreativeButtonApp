//
//  ISavedViewController.m
//  ideabutton
//
//  Created by Jian Hu on 15-2-9.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import "ISavedViewController.h"
#import "MysaveCell.h"


@interface ISavedViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *mtableview;
    NSMutableArray *marr;
}
@end

@implementation ISavedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我收藏的";
    
    
    //----------
    
    mtableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenBoundwidth, kMainScreenBoundheight-64-50) style:UITableViewStylePlain];
    
    mtableview.backgroundColor=COLOR(21, 21, 23);;
    mtableview.backgroundView.backgroundColor=COLOR(21, 21, 23);
    //        mtableview.scrollEnabled=NO;
    mtableview.dataSource=self;
    mtableview.delegate=self;
    [self.view addSubview:mtableview];
    //---------
    marr=[[NSMutableArray alloc]init];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
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
        cell.backgroundColor=COLOR(21, 21, 23);
        cell.selectionStyle=UITableViewCellSelectionStyleNone ;
    }
    

    //cell.imgview_left.image=[UIImage imageNamed:@"userheader.png"];
    cell.lbltitle.text=@"瓶酒瓶里插着莲花";
    
    
    return cell;
}



@end
