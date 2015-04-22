//
//  ProductListTableViewController.m
//  ideabutton
//
//  Created by Li Xiang on 15/4/7.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import "ProductListTableViewController.h"
#import "SVProgressHUD.h"
#import "API.h"

@interface ProductListTableViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UITextField* searchTextField;
}

@property(nonatomic, strong)NSArray* productList;
@property(nonatomic, assign)NSInteger   type;
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSString* productName;

@end

@implementation ProductListTableViewController

-(id)initWithData:(NSInteger)Type initData:(NSArray*)list;
{
    self = [super init];
    if (self)
    {
        self.productList = list;
        self.type = Type;
        
        if (self.type == 2)
        {
            self.productName = [self.productList[0] objectForKey:@"productName"];
        }
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = kgettitle;
    [self.view setBackgroundColor:COLOR(21, 21, 22)];
    [self setrightbaritem_imgname:@"icon_more_all" title:nil];
    
    searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 5, 248, 45)];
    searchTextField.backgroundColor = [UIColor whiteColor];
    searchTextField.layer.cornerRadius = 5;
    searchTextField.placeholder = @"按关键字搜索";
    searchTextField.delegate = self;
    [self.view addSubview:searchTextField];
    
    UIButton* searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(265, 5, 50, 45)];
    searchTextField.returnKeyType = UIReturnKeySearch;
    [searchBtn setImage:[UIImage imageNamed:@"ideaCreate/icon_search"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchProduct) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 55, 320, self.view.frame.size.height-44-49) style:UITableViewStylePlain];
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableView.backgroundColor = COLOR(21, 21, 22);
    [self.view addSubview:tableView];
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView setTableFooterView:v];

}

-(void)searchProduct
{
    if ([searchTextField becomeFirstResponder])
    {
        [searchTextField resignFirstResponder];
    }
    
    if (searchTextField.text.length == 0)
    {
        return;
    }
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    dispatch_queue_t currentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(currentQueue, ^{
        //后台处理代码, 一般 http 请求在这里发, 然后阻塞等待返回, 收到返回处理
        if (self.type == 1)
        {
            self.productList = [[API sharedInstance]productList:@{@"productName":searchTextField.text,@"pageNo":@"1",@"pageSize":@"100"}];
        }
        else
        {
            self.productList = [[API sharedInstance]appealList:@{@"productName":self.productName,@"appealName":searchTextField.text,@"pageNo":@"1",@"pageSize":@"100"}];
        }
        //处理完上面的后回到主线程去更新UI
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        dispatch_async(mainQueue, ^{
            [SVProgressHUD dismiss];
            if (self.productList.count == 0)
            {
                [SVProgressHUD showErrorWithStatus:[API sharedInstance].msg];
            }
            else
            {
                [self.tableView reloadData];
            }
        });
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.productList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ProductCell"];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ProductCell"];
    }
    
    cell.backgroundColor = COLOR(21, 21, 22);
    if (self.type == 1)
    {
        cell.textLabel.text = [[self.productList objectAtIndex:indexPath.row] objectForKey:@"productName"];
    }
    else
    {
        cell.textLabel.text = [[self.productList objectAtIndex:indexPath.row] objectForKey:@"appealName"];
    }
    
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.type == 1)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"chooseProduct" object:nil userInfo:@{@"productName":[[self.productList objectAtIndex:indexPath.row] objectForKey:@"productName"]}];
    }
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"chooseProduct" object:nil userInfo:@{@"appealName":[[self.productList objectAtIndex:indexPath.row] objectForKey:@"appealName"]}];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
