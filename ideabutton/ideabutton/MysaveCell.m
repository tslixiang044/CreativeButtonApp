//
//  MysaveCell.m
//  ideabutton
//
//  Created by ZhouTong on 15-2-27.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import "MysaveCell.h"

@implementation MysaveCell



@synthesize imgview_left,lbltitle;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        imgview_left=[[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 5, 30)];
        imgview_left.backgroundColor=[UIColor redColor];
        [self addSubview:imgview_left];
        //----------------
        lbltitle=[[UILabel alloc]initWithFrame:CGRectMake(60, 15, kMainScreenBoundwidth-100 , 30)];
        lbltitle.font=[UIFont systemFontOfSize:14];
        lbltitle.textColor=[UIColor whiteColor];
        [self addSubview:lbltitle];
        //----------------
        UIButton *  btndelete = [UIButton buttonWithType:UIButtonTypeCustom];
        btndelete.frame = CGRectMake(kMainScreenBoundwidth-100, 15, 30, 30);
        //[btndelete setImage:[UIImage imageNamed:@"userheader.png"] forState:UIControlStateNormal];
        [btndelete setTitle:@"-" forState:UIControlStateNormal];
        [btndelete addTarget:self action:@selector(btndeleteAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btndelete];
        //----------------
        UIButton *  btnadd = [UIButton buttonWithType:UIButtonTypeCustom];
        btnadd.frame = CGRectMake(kMainScreenBoundwidth-100+50, 15, 30, 30);
        //[btndelete setImage:[UIImage imageNamed:@"userheader.png"] forState:UIControlStateNormal];
        [btnadd setTitle:@"+" forState:UIControlStateNormal];
        [btnadd addTarget:self action:@selector(btnaddAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnadd];
        
    }
    return self;
}
-(void)btndeleteAction:(UIButton*)mbtn
{
    NSLog(@"delete");
}
-(void)btnaddAction:(UIButton*)mbtn
{
    NSLog(@"add");
}
@end
