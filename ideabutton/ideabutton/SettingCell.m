//
//  SettingCell.m
//  TeamTalk
//
//  Created by ZhouTong on 15-3-18.
//  Copyright (c) 2015年 dujia. All rights reserved.
//

#import "SettingCell.h"

@implementation SettingCell

@synthesize lbldesc,mswitch;


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        lbldesc=[[UILabel alloc]initWithFrame:CGRectMake(20, 10 , kMainScreenBoundwidth-100, 30)];
        lbldesc.font=[UIFont systemFontOfSize:16];
        lbldesc.textColor=COLOR(206, 206, 206);
        [self addSubview:lbldesc];
        //-------------
        mswitch=[[UISwitch alloc]initWithFrame:CGRectMake(kMainScreenBoundwidth-70, 5, 60, 30)];
        mswitch.onTintColor =[UIColor redColor];
        mswitch.tintColor=[UIColor whiteColor];
        mswitch.thumbTintColor=[UIColor whiteColor];
        [self addSubview:mswitch];
        //-------------
        
        
        
    }
    return self;
}

@end
