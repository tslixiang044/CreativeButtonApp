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
@end

@implementation IdeaDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setrightbaritem_imgname:@"icon_more_all.png" title:@""];
    
    
    self.title=@"用户详情页";
    
    
    float x=10;
    float y=10;
    
    imgview_header=[[UIImageView alloc]initWithFrame:CGRectMake(x, y, 50, 50)];
    imgview_header.userInteractionEnabled=YES;
    imgview_header.image=[UIImage imageNamed:@"userheader.png"];
    [self.view addSubview:imgview_header];
    
    CALayer *layer = [imgview_header layer];
    [layer setMasksToBounds:YES];
    CGFloat radius=imgview_header.frame.size.width/2; //设置圆角的半径为图片宽度的一半
    [layer setCornerRadius:radius];
    [layer setBorderWidth:2.0];//添加白色的边框
    
    UIColor *mcolor=COLOR(60, 60, 60);
    
    [layer setBorderColor:[mcolor CGColor]];
    //--------------
    x=imgview_header.frame.origin.x+imgview_header.frame.size.width+5;
    lblnickname=[[UILabel alloc]initWithFrame:CGRectMake(x, y, 100, 25)];
    lblnickname.backgroundColor=[UIColor clearColor];
    lblnickname.font=[UIFont systemFontOfSize:13];
    lblnickname.text=@"peter zhong";
    lblnickname.textColor=[UIColor whiteColor];
    [self.view addSubview:lblnickname];
    //--------------
//    y=lblnickname.frame.origin.y+lblnickname.frame.size.height;
//    
//    lblsource=[[UILabel alloc]initWithFrame:CGRectMake(x, y, 100, 25)];
//    lblsource.backgroundColor=[UIColor clearColor];
//    lblsource.text=@"长沙 胜美广告";
//    lblsource.font=[UIFont systemFontOfSize:12];
//    lblsource.textColor=[UIColor whiteColor];
//    [self.view addSubview:lblsource];
    //---------------
    y=imgview_header.frame.origin.y+imgview_header.frame.size.height+30;
    
    view_center=[[UIView alloc]initWithFrame:CGRectMake(10, y, kMainScreenBoundwidth-20, 200)];
    view_center.backgroundColor=COLOR(204, 41, 32);
    [self.view addSubview:view_center];
    //---------------
    x=10;
    y=10;
    
    lbldesc=[[UILabel alloc]initWithFrame:CGRectMake(x, y, kMainScreenBoundwidth-20-20, 35)];
    lbldesc.numberOfLines=2;
    lbldesc.textColor=[UIColor whiteColor];
    lbldesc.text=@"我刚刚霸占了一条啤酒广告IDEA：";
    lbldesc.font=[UIFont systemFontOfSize:14];
    lbldesc.backgroundColor=[UIColor clearColor];
    [view_center addSubview:lbldesc];
    //---------------
    y=lbldesc.frame.origin.y+lbldesc.frame.size.height;
    lblproduct=[[UILabel alloc]initWithFrame:CGRectMake(x, y, kMainScreenBoundwidth-20-20, 25)];
    
    lblproduct.textColor=[UIColor whiteColor];
    lblproduct.font=[UIFont systemFontOfSize:20];
    lblproduct.text=@"啤酒瓶里插莲花";
    lblproduct.backgroundColor=[UIColor clearColor];
    [view_center addSubview:lblproduct];
    //---------------
    y=lblproduct.frame.origin.y+lblproduct.frame.size.height;
    lbltime=[[UILabel alloc]initWithFrame:CGRectMake(x, y, kMainScreenBoundwidth-20-20, 25)];
    lbltime.textAlignment=NSTextAlignmentRight;
    lbltime.textColor=[UIColor whiteColor];
    lbltime.text=@"12分钟前";
    lbltime.font=[UIFont systemFontOfSize:12];
    lbltime.backgroundColor=[UIColor clearColor];
    [view_center addSubview:lbltime];
    //---------------
    //---------------------
    x=20;
    y=kMainScreenBoundheight-64-100;
    
   UIButton *  btnzan = [UIButton buttonWithType:UIButtonTypeCustom];
    btnzan.frame = CGRectMake(x, y, 60, 30);
    [btnzan setImage:[UIImage imageNamed:@"jiantou_xia.png"] forState:UIControlStateNormal];
    [btnzan setTitle:@"赞" forState:UIControlStateNormal];
    btnzan.titleLabel.font = [UIFont systemFontOfSize:14];
    btnzan.backgroundColor=COLOR(131, 131, 131);
    [btnzan setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnzan setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [btnzan addTarget:self action:@selector(btnzanAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [btnzan setTitleEdgeInsets:UIEdgeInsetsMake(5, 40, 5, 0)];
    [btnzan setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
    [self.view addSubview:btnzan];
    //---------------------
    x=20+60+13.3;

    UIButton *  btnzhuan = [UIButton buttonWithType:UIButtonTypeCustom];
    btnzhuan.frame = CGRectMake(x, y, 60, 30);
    [btnzhuan setImage:[UIImage imageNamed:@"jiantou_xia.png"] forState:UIControlStateNormal];
    [btnzhuan setTitle:@"转" forState:UIControlStateNormal];
    btnzhuan.titleLabel.font = [UIFont systemFontOfSize:14];
    btnzhuan.backgroundColor=COLOR(131, 131, 131);
    [btnzhuan setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnzhuan setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [btnzhuan addTarget:self action:@selector(btnzhuanAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [btnzhuan setTitleEdgeInsets:UIEdgeInsetsMake(5, 40, 5, 0)];
    [btnzhuan setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
    [self.view addSubview:btnzhuan];
    //---------------------
    x=20+60+13.3+60+13.3;
    
    UIButton *  btnping = [UIButton buttonWithType:UIButtonTypeCustom];
    btnping.frame = CGRectMake(x, y, 60, 30);
    [btnping setImage:[UIImage imageNamed:@"jiantou_xia.png"] forState:UIControlStateNormal];
    [btnping setTitle:@"评" forState:UIControlStateNormal];
    btnping.titleLabel.font = [UIFont systemFontOfSize:14];
    btnping.backgroundColor=COLOR(131, 131, 131);
    [btnping setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnping setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [btnping addTarget:self action:@selector(btnpingAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [btnping setTitleEdgeInsets:UIEdgeInsetsMake(5, 40, 5, 0)];
    [btnping setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
    [self.view addSubview:btnping];
    //---------------------
    x=20+60+13.3+60+13.3+60+13.3;
    
    UIButton *  btnshan = [UIButton buttonWithType:UIButtonTypeCustom];
    btnshan.frame = CGRectMake(x, y, 60, 30);
    [btnshan setImage:[UIImage imageNamed:@"jiantou_xia.png"] forState:UIControlStateNormal];
    [btnshan setTitle:@"删" forState:UIControlStateNormal];
    btnshan.titleLabel.font = [UIFont systemFontOfSize:14];
    btnshan.backgroundColor=COLOR(131, 131, 131);
    [btnshan setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnshan setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [btnshan addTarget:self action:@selector(btnshanAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [btnshan setTitleEdgeInsets:UIEdgeInsetsMake(5, 40, 5, 0)];
    [btnshan setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
    [self.view addSubview:btnshan];
    //---------------------
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
