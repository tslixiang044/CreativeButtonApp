//
//  MymsgCell.m
//  ideabutton
//
//  Created by ZhouTong on 15-4-5.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import "MymsgCell.h"

@implementation MymsgCell
@synthesize imgview_left,lbltitle,lbltime;





- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
       
        imgview_left=[[MyUIImageView alloc]initWithFrame_head:CGRectMake(15, 15, 30, 30)];
        [self addSubview:imgview_left];
        //----------------
        lbltitle=[[UILabel alloc]initWithFrame:CGRectMake(60, 15, kMainScreenBoundwidth-60-80, 30)];
        lbltitle.font=[UIFont systemFontOfSize:14];
        lbltitle.textColor=[UIColor whiteColor];
        [self addSubview:lbltitle];
        //----------------
        lbltime=[[UILabel alloc]initWithFrame:CGRectMake(kMainScreenBoundwidth-80-10, 15, 80, 25)];
        lbltime.font=[UIFont systemFontOfSize:14];
        lbltime.textColor=[UIColor whiteColor];
        lbltime.textAlignment=NSTextAlignmentRight;
        [self addSubview:lbltime];
        //----------------
        
        
    }
    return self;
}


@end
