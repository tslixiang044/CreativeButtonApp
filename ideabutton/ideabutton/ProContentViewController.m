//
//  ProContentViewController.m
//  ideabutton
//
//  Created by Li Xiang on 15/2/10.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProContentViewController.h"
#import "InteractivePageViewController.h"
#import "SVProgressHUD.h"
#import "API.h"
#import "ProductListTableViewController.h"

#define Height  45

@interface ProContentViewController()<UITextFieldDelegate>
{
    NSArray* productListArray;
    NSArray* appealListArray;
    NSInteger selectType;
}

@property(nonatomic, strong)UIScrollView *mainScroll;

@property(nonatomic, assign)CGFloat lastScrollOffset;
@property(nonatomic, strong)UITextField *inFocusTextField;
@property(nonatomic, strong)NSMutableDictionary* myDict;

@property(nonatomic, strong)UITextField* brandTextField;
@property(nonatomic, strong)UITextField* productTextField;
@property(nonatomic, strong)UITextField* appealTextField;

@end


@implementation ProContentViewController

-(id)initWithDict:(NSDictionary*)dict
{
    self = [super init];
    if (self)
    {
        selectType = 0;
        productListArray = [[NSArray alloc]init];
        appealListArray = [[NSArray alloc]init];
        self.myDict = [[NSMutableDictionary alloc] initWithDictionary:dict];
        [self getProductList];
    }
    
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setrightbaritem_imgname:@"icon_more_all" title:nil];
    
    CGFloat contentHeight = 380;
    UIScrollView *mainScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    mainScroll.contentSize = CGSizeMake(320, contentHeight);
    self.mainScroll = mainScroll;
    [self.view addSubview:mainScroll];
    
    UIView *editingView = [self createInputView];
    editingView.frame = CGRectMake(20, 60, 280, contentHeight);
    [mainScroll addSubview:editingView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setTextValue:) name:@"chooseProduct" object:nil];
    //注册键盘通知获取键盘高度
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:self.view.window];
}

-(void)btnright
{
    [self showMenuView];
}

- (void)keyboardWillShow:(NSNotification *)noti
{
    NSDictionary* userInfo = [noti userInfo];
    
    CGFloat keyboardHeight = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height+50;
    self.lastScrollOffset = self.mainScroll.contentOffset.y;
    
    CGRect inputRect = [self.inFocusTextField.superview convertRect:CGRectMake(0, 0, 320, Height) toView:self.view];
    CGFloat inputRectBottomHeight = self.view.frame.size.height - (inputRect.origin.y + Height);
    CGFloat heightDiff = inputRectBottomHeight - keyboardHeight;
    if(heightDiff<0)
    {
        CGFloat newScrollOffset = self.mainScroll.contentOffset.y-heightDiff;
        [self.mainScroll setContentOffset:CGPointMake(0, newScrollOffset) animated:YES];
    }
}

-(UIView*)createInputView
{
    UIView* contentView = [[UIView alloc] initWithFrame:CGRectMake(20, 60, 280, 380)];
    contentView.backgroundColor = COLOR(21, 21, 22);
    [self.view addSubview:contentView];
    
    UIImageView *inputView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"public/input_bai"]];
    inputView.userInteractionEnabled = YES;
    inputView.frame = CGRectMake(20, 40, 240, 40);
    [contentView addSubview:inputView];
    
    self.productTextField = [[UITextField alloc] initWithFrame:inputView.frame];
    self.productTextField.delegate = self;
    self.productTextField.placeholder = @"产品";
    [contentView addSubview:self.productTextField];
    
    UIImageView *inputView1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"public/input_bai"]];
    inputView1.userInteractionEnabled = YES;
    inputView1.frame = CGRectMake(20, 100, 240, 40);
    [contentView addSubview:inputView1];
    
    self.appealTextField = [[UITextField alloc] initWithFrame:inputView1.frame];
    self.appealTextField.delegate = self;
    self.appealTextField.placeholder = @"诉求点";
    [contentView addSubview:self.appealTextField];
    
    UIImageView *inputView2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"public/input_bai"]];
    inputView2.userInteractionEnabled = YES;
    inputView2.frame = CGRectMake(20, 160, 240, 40);
    [contentView addSubview:inputView2];
    
    self.brandTextField = [[UITextField alloc] initWithFrame:inputView2.frame];
    self.brandTextField.delegate = self;
    self.brandTextField.placeholder = @"品牌";
    [contentView addSubview:self.brandTextField];
    
    UIImageView* line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"public/line"]];
    line.frame = CGRectMake(0, 230, 280, 5);
    [contentView addSubview:line];
    
    UIButton* ideaButton = [UIButton buttonWithType:UIButtonTypeCustom];
    ideaButton.frame = CGRectMake(100, 270, 70, 70);
    [ideaButton setBackgroundImage:[UIImage imageNamed:@"btn_logo"] forState:UIControlStateNormal];
    [ideaButton addTarget:self action:@selector(showNextPage) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:ideaButton];

    return contentView;
}

-(void)setTextValue:(NSNotification *)noti
{
    NSDictionary* userInfo = [noti userInfo];
    
    if (selectType == 1)
    {
        self.productTextField.text = [userInfo objectForKey:@"productName"];
    }
    else
    {
        self.appealTextField.text = [userInfo objectForKey:@"appealName"];
    }
}

-(void)showNextPage
{
    if (self.productTextField.text.length == 0)
    {
        [SVProgressHUD showErrorWithStatus:@"请选择产品"];
        return;
    }
    
    if (self.appealTextField.text.length == 0)
    {
        [SVProgressHUD showErrorWithStatus:@"请选择诉求点"];
        return;
    }
    
    if (self.brandTextField.text.length == 0 )
    {
        [SVProgressHUD showErrorWithStatus:@"品牌不能为空"];
        return;
    }
    
    [self.myDict setValue:self.brandTextField.text forKey:@"brand"];
    [self.myDict setValue:self.productTextField.text forKey:@"product"];
    [self.myDict setValue:self.appealTextField.text forKey:@"appeal"];
    
    InteractivePageViewController* interactivePage = [[InteractivePageViewController alloc] initWithDict:self.myDict];
    [self.navigationController pushViewController:interactivePage animated:YES];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.inFocusTextField = textField;
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.productTextField)
    {
        [textField resignFirstResponder];
        selectType = 1;
        ProductListTableViewController* tableViewContoller = [[ProductListTableViewController alloc] initWithData:selectType initData: productListArray];
        [self.navigationController pushViewController:tableViewContoller animated:YES];
    }
    
    if (textField == self.appealTextField)
    {
        [textField resignFirstResponder];
        selectType = 2;
        if (self.productTextField.text.length == 0)
        {
            [SVProgressHUD showErrorWithStatus:@"请先选择产品"];
        }
        else
        {
            [self getAppealList];
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    [self.mainScroll setContentOffset:CGPointMake(0, self.lastScrollOffset) animated:YES];
    
    return YES;
}

- (void)getProductList
{
    dispatch_queue_t currentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(currentQueue, ^{
        //后台处理代码, 一般 http 请求在这里发, 然后阻塞等待返回, 收到返回处理
        productListArray = [[API sharedInstance]productList:@{@"productName":@"",@"pageNo":@"1",@"pageSize":@"10"}];
        //处理完上面的后回到主线程去更新UI
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        dispatch_async(mainQueue, ^{
            if (productListArray.count == 0)
            {
                [SVProgressHUD showErrorWithStatus:[API sharedInstance].msg];
            }
        });
    });
}

- (void) getAppealList
{
    [SVProgressHUD showWithStatus:[NSString stringWithFormat:@"正在查询“%@”对应的诉求点",self.productTextField.text]];
    dispatch_queue_t currentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(currentQueue, ^{
        //后台处理代码, 一般 http 请求在这里发, 然后阻塞等待返回, 收到返回处理
        appealListArray = [[API sharedInstance]appealList:@{@"productName":self.productTextField.text,@"appealName":@"",@"pageNo":@"1",@"pageSize":@"10"}];
        //处理完上面的后回到主线程去更新UI
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        dispatch_async(mainQueue, ^{
            if (appealListArray.count == 0)
            {
                [SVProgressHUD showErrorWithStatus:[API sharedInstance].msg];
            }
            else
            {
                [SVProgressHUD dismiss];
                ProductListTableViewController* tableViewContoller = [[ProductListTableViewController alloc] initWithData:selectType initData:appealListArray];
                [self.navigationController pushViewController:tableViewContoller animated:YES];
            }
        });
    });
}

@end