//
//  MytoolviewCell.m
//  ideabutton
//
//  Created by ZhouTong on 15-2-27.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import "MytoolviewCell.h"

@implementation MytoolviewCell

@synthesize imgview_left,lbltitle;


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        imgview_left=[[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 30, 30)];
        [self addSubview:imgview_left];
        //----------------
        lbltitle=[[UILabel alloc]initWithFrame:CGRectMake(60, 15, 200-60, 30)];
        lbltitle.font=[UIFont systemFontOfSize:14];
        lbltitle.textColor=[UIColor whiteColor];
        [self addSubview:lbltitle];
        //----------------
        
        
        
    }
    return self;
}



@end
