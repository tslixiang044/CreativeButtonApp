//
//  MychangedCell.m
//  ideabutton
//
//  Created by ZhouTong on 15-2-27.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import "MychangedCell.h"

@implementation MychangedCell
@synthesize imgview_left,lbltitle;
@synthesize mrow,strid;
@synthesize delegate;
@synthesize btndelete;
@synthesize btnwybz,btnwygz;
@synthesize btnadd;


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        imgview_left=[[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 5, 30)];
        imgview_left.backgroundColor=[UIColor redColor];
        [self addSubview:imgview_left];
        //----------------
        lbltitle=[[UILabel alloc]initWithFrame:CGRectMake(30, 15, kMainScreenBoundwidth-100 , 30)];
        lbltitle.font=[UIFont systemFontOfSize:14];
        lbltitle.textColor=[UIColor whiteColor];
        [self addSubview:lbltitle];
        //----------------

        btnadd = [UIButton buttonWithType:UIButtonTypeCustom];
        btnadd.frame = CGRectMake(kMainScreenBoundwidth-30, 15, 30, 30);
        [btnadd setImage:[UIImage imageNamed:@"btn_pull"] forState:UIControlStateNormal];
        [btnadd addTarget:self action:@selector(btnaddAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnadd];
        //----------------
        btndelete = [MyUIButton buttonWithType:UIButtonTypeCustom];
        btndelete.frame =CGRectMake(kMainScreenBoundwidth-80-10-80-10-80-20, 10, 80, 40);
        [btndelete setTitle:@"我要删除" forState:UIControlStateNormal];
        btndelete.backgroundColor=COLOR(141, 144, 143);
        [btndelete setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btndelete addTarget:self action:@selector(btndeleteAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btndelete];
        //--------------------
        btnwybz = [MyUIButton buttonWithType:UIButtonTypeCustom];
        btnwybz.frame =CGRectMake(kMainScreenBoundwidth-80-10-80-20, 10, 80, 40);
        btnwybz.backgroundColor=COLOR(141, 144, 143);
        [btnwybz setTitle:@"我要霸占" forState:UIControlStateNormal];
        [btnwybz setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnwybz addTarget:self action:@selector(btnwybzAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnwybz];
        //--------------------
        btnwygz = [MyUIButton buttonWithType:UIButtonTypeCustom];
        btnwygz.frame =CGRectMake(kMainScreenBoundwidth-80-20, 10, 80, 40);
        btnwygz.backgroundColor=COLOR(141, 144, 143);
        [btnwygz setTitle:@"我要改造" forState:UIControlStateNormal];
        [btnwygz setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnwygz addTarget:self action:@selector(btnwygzAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnwygz];
    }
    
    return self;
}


-(void)btnaddAction:(UIButton*)mbtn
{
    if(delegate)
    {
        [delegate btnshow:self.strid row:self.mrow];
    }
}
-(void)btndeleteAction:(MyUIButton *)mbtn
{
    if(delegate)
    {
        [delegate btndeleteAction:mbtn];
    }
}
-(void)btnwybzAction:(MyUIButton *)mbtn
{
    if(delegate)
    {
        [delegate btnwybzAction:mbtn];
    }
}
-(void)btnwygzAction:(MyUIButton *)mbtn
{
    if(delegate)
    {
        [delegate btnwygzAction:mbtn];
    }
}
@end
