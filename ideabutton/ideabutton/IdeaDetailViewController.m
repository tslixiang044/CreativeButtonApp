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
#import "SVProgressHUD.h"
#import "API.h"

@interface IdeaDetailViewController ()<UITextFieldDelegate>
{
    UIImageView *imgview_header;
    UILabel *lblnickname;
    UILabel *lblsource;
    
    UIView *view_center;
    UILabel *lbldesc;
    UILabel *lblproduct;
    UILabel *lbltime;
    
    MyToolView *toolview;
    
    UIImageView* sexImageView;
    UILabel* goodLabel;
    
    UIView *view_update;
    UITextField *txtcontent;
    MyUIButton *btncommit;
    
    UIButton *  btnzan;
    UIButton *  btnping;
    
    float   origin_y;
}

@property(nonatomic, strong)WaterFlowObj* data;
@property(nonatomic, strong)UIScrollView* scrollView;

@end

@implementation IdeaDetailViewController

- (id)initWithData:(WaterFlowObj *)object
{
    self = [super init];
    if (self)
    {
        self.data = object;
        origin_y = -1;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setrightbaritem_imgname:@"icon_more_all.png" title:@""];
    
    float x=10;
    float y=10;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenBoundwidth, kMainScreenBoundheight + 1)];
    [self.view addSubview:self.scrollView];
    
    imgview_header=[[UIImageView alloc]initWithFrame:CGRectMake(x, y, 60, 60)];
    imgview_header.userInteractionEnabled=YES;
    imgview_header.image=[UIImage imageNamed:@"userheader"];
    [self.scrollView addSubview:imgview_header];
    
    CALayer *layer = [imgview_header layer];
    [layer setMasksToBounds:YES];
    CGFloat radius=imgview_header.frame.size.width/2; //设置圆角的半径为图片宽度的一半
    [layer setCornerRadius:radius];
    [layer setBorderWidth:2.0];//添加白色的边框
    
    UIColor *mcolor=COLOR(60, 60, 60);
    
    [layer setBorderColor:[mcolor CGColor]];
    //--------------
    x=imgview_header.frame.origin.x+imgview_header.frame.size.width+20;
    lblnickname=[[UILabel alloc]initWithFrame:CGRectMake(x, y, 60, 25)];
    lblnickname.backgroundColor=[UIColor clearColor];
    lblnickname.text=self.data.nickname;
    lblnickname.textColor=COLOR(98, 98, 98);
    [self.scrollView addSubview:lblnickname];
    
    sexImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x+60, y, 25, 25)];
    if (self.data.gender.integerValue == 0)
    {
        [sexImageView setImage:[UIImage imageNamed:@"icon_woman"]];
    }
    else
    {
        [sexImageView setImage:[UIImage imageNamed:@"icon_man"]];
    }
    [self.scrollView addSubview:sexImageView];
    
    UILabel* cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y+40, 150, 20)];
    cityLabel.text = [NSString stringWithFormat:@"%@    %@",self.data.city,self.data.college];
    cityLabel.textColor = COLOR(98, 98, 98);
    cityLabel.font = [UIFont systemFontOfSize:14];
    [self.scrollView addSubview:cityLabel];
    
    y=imgview_header.frame.origin.y+imgview_header.frame.size.height+20;
    
    view_center=[[UIView alloc]initWithFrame:CGRectMake(10, y, kMainScreenBoundwidth-20, 155)];
    view_center.backgroundColor=COLOR(205, 40, 30);
    [self.scrollView addSubview:view_center];
    //---------------
    x=10;
    y=10;
    
    lbldesc=[[UILabel alloc]initWithFrame:CGRectMake(x, y, kMainScreenBoundwidth-40, 40)];
    lbldesc.textColor=[UIColor whiteColor];
    lbldesc.text= [NSString stringWithFormat:@"我宣布，我刚刚霸占了一条%@广告，谁也别想再碰：",self.data.product];
    lbldesc.font=[UIFont systemFontOfSize:15];
    lbldesc.backgroundColor=[UIColor clearColor];
    lbldesc.lineBreakMode = NSLineBreakByWordWrapping;
    lbldesc.numberOfLines=0;
    [view_center addSubview:lbldesc];
    //---------------
    y=lbldesc.frame.origin.y+lbldesc.frame.size.height;
    lblproduct=[[UILabel alloc]initWithFrame:CGRectMake(x, y, kMainScreenBoundwidth-40, 80)];
    
    lblproduct.textColor=[UIColor whiteColor];
    lblproduct.font=[UIFont systemFontOfSize:18];
    lblproduct.text=self.data.sentence;
    lblproduct.backgroundColor=[UIColor clearColor];
    lblproduct.lineBreakMode = NSLineBreakByWordWrapping;
    lblproduct.numberOfLines=0;
    
    [view_center addSubview:lblproduct];
    //---------------
    y=lblproduct.frame.origin.y+lblproduct.frame.size.height;
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
    y = view_center.frame.origin.y + view_center.frame.size.height + 10;
    UIImageView* goodImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, 25, 25)];
    [goodImageView setImage:[UIImage imageNamed:@"icon_good"]];
    [self.scrollView addSubview:goodImageView];
    
    goodLabel = [[UILabel alloc] initWithFrame:CGRectMake(x + 30, y, 60, 25)];
    goodLabel.textColor = COLOR(98, 98, 98);
    goodLabel.text = [NSString stringWithFormat:@"%@次赞",self.data.numberOfPraise];
    [self.scrollView addSubview:goodLabel];
    
    y= goodLabel.frame.origin.y + goodLabel.frame.size.height + 10;
    UIImageView* commentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, 20, 20)];
    [commentImageView setImage:[UIImage imageNamed:@"icon_talk"]];
    [self.scrollView addSubview:commentImageView];
    
    if (self.data.comments.count > 0)
    {
        x = x + 30;
        for (int i = 0; i < self.data.comments.count; i++)
        {
            if (i > 0)
            {
                y = y + 25;
            }
            
            UILabel* commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, 260, 25)];
            commentLabel.textColor = COLOR(98, 98, 98);
            commentLabel.text = [NSString stringWithFormat:@"%@ : %@",[self.data.comments[i] objectForKey:@"nickname"],[self.data.comments[i] objectForKey:@"content"]];
            [self.scrollView addSubview:commentLabel];
        }
        origin_y = y;
    }
    
    x = 20;
    y= y + 40;
    
    btnzan = [UIButton buttonWithType:UIButtonTypeCustom];
    btnzan.frame = CGRectMake(x, y, 80, 30);
    [btnzan setImage:[UIImage imageNamed:@"btn_good"] forState:UIControlStateNormal];
    [btnzan setTitle:@"赞" forState:UIControlStateNormal];
    [btnzan setTitleColor:COLOR(47, 44, 43) forState:UIControlStateNormal];
    btnzan.titleLabel.font = [UIFont systemFontOfSize:14];
    btnzan.backgroundColor=COLOR(142, 142, 143);
    btnzan.layer.cornerRadius = 5;
    [btnzan addTarget:self action:@selector(btnzanAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [btnzan setTitleEdgeInsets:UIEdgeInsetsMake(5, 10, 5, 0)];
    [btnzan setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 15)];
    [self.scrollView addSubview:btnzan];
    //---------------------
    x= btnzan.frame.origin.x + btnzan.frame.size.width + 10;
    
    btnping = [UIButton buttonWithType:UIButtonTypeCustom];
    btnping.frame = CGRectMake(x, y, 80, 30);
    [btnping setImage:[UIImage imageNamed:@"btn_tlak"] forState:UIControlStateNormal];
    [btnping setTitle:@"评" forState:UIControlStateNormal];
    [btnping setTitleColor:COLOR(47, 44, 43) forState:UIControlStateNormal];
    btnping.titleLabel.font = [UIFont systemFontOfSize:14];
    btnping.backgroundColor=COLOR(142, 142, 143);
    btnping.layer.cornerRadius = 5;
    [btnping addTarget:self action:@selector(btnpingAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [btnping setTitleEdgeInsets:UIEdgeInsetsMake(5, 10, 5, 0)];
    [btnping setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 15)];
    [self.scrollView addSubview:btnping];
    
    [self.scrollView setContentSize:CGSizeMake(kMainScreenBoundwidth, y + btnping.frame.size.height + 80)];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)btnzanAction:(UIButton*)mbtn
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    dispatch_queue_t currentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(currentQueue, ^{
        //后台处理代码, 一般 http 请求在这里发, 然后阻塞等待返回, 收到返回处理
        [[API sharedInstance] clickPraise:@{@"bizId":self.data.userOccupyId,@"bizType":self.data.ideaType,@"bizOwner":self.data.userCode}];
        //处理完上面的后回到主线程去更新UI
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        dispatch_async(mainQueue, ^{
            
            if ([API sharedInstance].code.integerValue == 0)
            {
                [SVProgressHUD showSuccessWithStatus:@"点赞成功"];
                goodLabel.text = [NSString stringWithFormat:@"%d次赞",[self.data.numberOfPraise integerValue]  + 1];
            }
            else
            {
                [SVProgressHUD showErrorWithStatus:[API sharedInstance].msg];
            }
        });
    });

}

-(void)btnpingAction:(UIButton*)mbtn
{
    [self showUpdateView];
}

-(void)btnright
{
    [self showMenuView];
}

-(void)showUpdateView
{
    if(view_update==nil)
    {
        view_update=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenBoundwidth, kMainScreenBoundheight-64)];
        view_update.backgroundColor=[UIColor clearColor];
        [self.view addSubview:view_update];
        //------
        UIButton *  btnclose = [UIButton buttonWithType:UIButtonTypeCustom];
        btnclose.frame = view_update.frame;
        
        btnclose.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [btnclose addTarget:self action:@selector(btncloseAction) forControlEvents:UIControlEventTouchUpInside];
        [view_update addSubview:btnclose];
        //------
        UIView *myView=[[UIView alloc]initWithFrame:CGRectMake(20, (kMainScreenBoundheight-64-150)/2-20, kMainScreenBoundwidth-40, 180)];
        myView.backgroundColor = COLOR(21, 21, 22);

        [myView.layer setCornerRadius:8.0f];
        [myView.layer setMasksToBounds:YES];
        
        [view_update addSubview:myView];
        //------
        txtcontent=[[UITextField alloc]initWithFrame:CGRectMake(10, 20, myView.frame.size.width-20, 30)];
        txtcontent.placeholder = @"限制140个字符";
        txtcontent.textColor=[UIColor blackColor];
        txtcontent.clearButtonMode=UITextFieldViewModeWhileEditing;
        txtcontent.font=[UIFont fontWithName:@"Arial" size:14];
        txtcontent.backgroundColor=[UIColor whiteColor];
        txtcontent.textAlignment=NSTextAlignmentLeft;
        txtcontent.delegate = self;
        txtcontent.returnKeyType = UIReturnKeyDone;
        
        [txtcontent.layer setBorderColor: [[UIColor whiteColor] CGColor]];
        [txtcontent.layer setBorderWidth: 1.0];
        [txtcontent.layer setCornerRadius:5.0f];
        [txtcontent.layer setMasksToBounds:YES];
        
        [txtcontent setBorderStyle:UITextBorderStyleRoundedRect];
        [myView addSubview:txtcontent];
        //------
        
        float y=txtcontent.frame.origin.y+txtcontent.frame.size.height+20;
        
        UIImageView* line = [[UIImageView alloc]initWithFrame:CGRectMake(0, y, myView.frame.size.width, 5)];
        [line setImage:[UIImage imageNamed:@"public/line"]];
        [myView addSubview:line];

        y = line.frame.origin.y + line.frame.size.height + 20;
        btncommit = [MyUIButton buttonWithType:UIButtonTypeCustom];
        btncommit.frame = CGRectMake((myView.frame.size.width-70)/2, y  , 70, 70);
        [btncommit setBackgroundImage:[UIImage imageNamed:@"all_btn_qd.png"] forState:UIControlStateNormal];
        [btncommit addTarget:self action:@selector(btncommitAction) forControlEvents:UIControlEventTouchUpInside];
        [myView addSubview:btncommit];
    }
    
    view_update.hidden=NO;
    [self.scrollView bringSubviewToFront:view_update];
}

-(void)btncommitAction
{
    [self btncloseAction];
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    dispatch_queue_t currentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(currentQueue, ^{
        //后台处理代码, 一般 http 请求在这里发, 然后阻塞等待返回, 收到返回处理
        [[API sharedInstance] saveComment:@{@"bizId":self.data.userOccupyId,@"bizType":self.data.ideaType,@"bizOwner":self.data.userCode,@"content":txtcontent.text}];
        //处理完上面的后回到主线程去更新UI
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        dispatch_async(mainQueue, ^{
            
            if ([API sharedInstance].code.integerValue == 0)
            {
                [SVProgressHUD dismiss];
                
                if (self.data.comments.count > 0)
                {
                    origin_y = origin_y + 25;
                }
                else
                {
                    origin_y = goodLabel.frame.origin.y + goodLabel.frame.size.height + 10;
                }
                UILabel* commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, origin_y, 260, 25)];
                commentLabel.textColor = COLOR(98, 98, 98);
                commentLabel.text = [NSString stringWithFormat:@"%@ : %@",self.data.nickname,txtcontent.text];
                [self.scrollView addSubview:commentLabel];
                
                btnzan.frame = CGRectMake(20, origin_y + 40, 80, 30);
                btnping.frame = CGRectMake(110, origin_y + 40, 80, 30);
            }
            else
            {
                [SVProgressHUD showErrorWithStatus:[API sharedInstance].msg];
            }
        });
    });
}

-(void)btncloseAction
{
    view_update.hidden=YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end

