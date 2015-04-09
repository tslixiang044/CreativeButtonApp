//
//  IdeaDetailViewController.m
//  ideabutton
//
//  Created by ZhouTong on 15-2-27.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import "IdeaDetailViewController.h"
#import "MyUIButton.h"
#import "MyToolView.h"

@interface IdeaDetailViewController ()
{
    UIImageView *imgview_header;
    UILabel *lblnickname;
    UILabel *lblsource;
    
    UIView *view_center;
    UILabel *lbldesc;
    UILabel *lblproduct;
    UILabel *lbltime;
    
    MyToolView *toolview;
}

@property(nonatomic, strong)WaterFlowObj* data;

@end

@implementation IdeaDetailViewController

- (id)initWithData:(WaterFlowObj *)object
{
    self = [super init];
    if (self)
    {
        self.data = object;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setrightbaritem_imgname:@"icon_more_all.png" title:@""];
    
    float x=10;
    float y=10;
    
    imgview_header=[[UIImageView alloc]initWithFrame:CGRectMake(x, y, 50, 50)];
    imgview_header.userInteractionEnabled=YES;
    imgview_header.image=[UIImage imageNamed:@"userheader"];
    [self.view addSubview:imgview_header];
    
    CALayer *layer = [imgview_header layer];
    [layer setMasksToBounds:YES];
    CGFloat radius=imgview_header.frame.size.width/2; //设置圆角的半径为图片宽度的一半
    [layer setCornerRadius:radius];
    [layer setBorderWidth:2.0];//添加白色的边框
    
    UIColor *mcolor=COLOR(60, 60, 60);
    
    [layer setBorderColor:[mcolor CGColor]];
    //--------------
    x=imgview_header.frame.origin.x+imgview_header.frame.size.width+20;
    lblnickname=[[UILabel alloc]initWithFrame:CGRectMake(x, y, 100, 25)];
    lblnickname.backgroundColor=[UIColor clearColor];
    lblnickname.text=self.data.nickname;
    lblnickname.textColor=[UIColor whiteColor];
    [self.view addSubview:lblnickname];
    
    y=imgview_header.frame.origin.y+imgview_header.frame.size.height+30;
    
    view_center=[[UIView alloc]initWithFrame:CGRectMake(10, y, kMainScreenBoundwidth-20, 200)];
    view_center.backgroundColor=COLOR(205, 40, 30);
    [self.view addSubview:view_center];
    //---------------
    x=10;
    y=10;
    
    lbldesc=[[UILabel alloc]initWithFrame:CGRectMake(x, y, kMainScreenBoundwidth-40, 50)];
    lbldesc.textColor=[UIColor whiteColor];
    lbldesc.text= [NSString stringWithFormat:@"我宣布，我刚刚霸占了一条%@广告，谁也别想再碰：",self.data.product];
    lbldesc.font=[UIFont systemFontOfSize:16];
    lbldesc.backgroundColor=[UIColor clearColor];
    lbldesc.lineBreakMode = NSLineBreakByWordWrapping;
    lbldesc.numberOfLines=0;
    [view_center addSubview:lbldesc];
    //---------------
    y=lbldesc.frame.origin.y+lbldesc.frame.size.height;
    lblproduct=[[UILabel alloc]initWithFrame:CGRectMake(x, y, kMainScreenBoundwidth-40, 100)];
    
    lblproduct.textColor=[UIColor whiteColor];
    lblproduct.font=[UIFont systemFontOfSize:20];
    lblproduct.text=self.data.sentence;
    lblproduct.backgroundColor=[UIColor clearColor];
    lblproduct.lineBreakMode = NSLineBreakByWordWrapping;
    lblproduct.numberOfLines=0;
    [view_center addSubview:lblproduct];
    //---------------
    y=lblproduct.frame.origin.y+lblproduct.frame.size.height + 10;
    lbltime=[[UILabel alloc]initWithFrame:CGRectMake(x, y, kMainScreenBoundwidth-40, 25)];
    lbltime.textAlignment=NSTextAlignmentRight;
    lbltime.textColor=[UIColor whiteColor];
    lbltime.text= self.data.timeStamp;
    lbltime.font=[UIFont systemFontOfSize:14];
    lbltime.backgroundColor=[UIColor clearColor];
    [view_center addSubview:lbltime];
    //---------------
    //---------------------
    x=20;
    y=kMainScreenBoundheight-64-100;
    
    UIButton *  btnzan = [UIButton buttonWithType:UIButtonTypeCustom];
    btnzan.frame = CGRectMake(x, y, 60, 30);
    [btnzan setImage:[UIImage imageNamed:@"btn_good"] forState:UIControlStateNormal];
    [btnzan setTitle:@"赞" forState:UIControlStateNormal];
    [btnzan setTitleColor:COLOR(47, 44, 43) forState:UIControlStateNormal];
    btnzan.titleLabel.font = [UIFont systemFontOfSize:14];
    btnzan.backgroundColor=COLOR(142, 142, 143);
    btnzan.layer.cornerRadius = 5;
    [btnzan addTarget:self action:@selector(btnzanAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [btnzan setTitleEdgeInsets:UIEdgeInsetsMake(5, 10, 5, 0)];
    [btnzan setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 15)];
    [self.view addSubview:btnzan];
    //---------------------
    x=20+60+13.3;
    
    UIButton *  btnping = [UIButton buttonWithType:UIButtonTypeCustom];
    btnping.frame = CGRectMake(x, y, 60, 30);
    [btnping setImage:[UIImage imageNamed:@"btn_tlak"] forState:UIControlStateNormal];
    [btnping setTitle:@"评" forState:UIControlStateNormal];
    [btnping setTitleColor:COLOR(47, 44, 43) forState:UIControlStateNormal];
    btnping.titleLabel.font = [UIFont systemFontOfSize:14];
    btnping.backgroundColor=COLOR(142, 142, 143);
    btnping.layer.cornerRadius = 5;
    [btnping addTarget:self action:@selector(btnpingAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [btnping setTitleEdgeInsets:UIEdgeInsetsMake(5, 10, 5, 0)];
    [btnping setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 15)];
    [self.view addSubview:btnping];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)btnzanAction:(UIButton*)mbtn
{
    NSLog(@"a");
}

-(void)btnzhuanAction:(UIButton*)mbtn
{
    NSLog(@"b");
}

-(void)btnpingAction:(UIButton*)mbtn
{
    NSLog(@"c");
}

-(void)btnshanAction:(UIButton*)mbtn
{
    NSLog(@"d");
}

-(void)btnright
{
    [self showMenuView];
    
}

@end
