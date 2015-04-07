//
//  MyInformationCell.m
//  ideabutton
//
//  Created by ZhouTong on 15-4-6.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import "MyInformationCell.h"

@implementation MyInformationCell
@synthesize lbltitle,lbldesc;



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //----------------
        lbltitle=[[UILabel alloc]initWithFrame:CGRectMake(10, 15, 80, 30)];
        lbltitle.font=[UIFont systemFontOfSize:14];
        lbltitle.textColor=COLOR(104, 104, 104);
        [self addSubview:lbltitle];
        //----------------
        lbldesc=[[UILabel alloc]initWithFrame:CGRectMake(10+80, 15, kMainScreenBoundwidth-100, 25)];
        lbldesc.font=[UIFont systemFontOfSize:14];
        lbldesc.textColor=[UIColor whiteColor];
        [self addSubview:lbldesc];
        //----------------
    }
    return self;
}

@end
