//
//  PersonaInfomationViewController.h
//  ideabutton
//
//  Created by ZhouTong on 15-3-20.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyBaseViewController.h"
#import "DB.h"

@interface PersonaInfomationViewController : MyBaseViewController
{
    User *user;
    BOOL isSelf;
}
@property(nonatomic,strong)User *user;
@property(nonatomic,strong)NSDictionary *dic_data;
@property(nonatomic,strong)NSString *userCode;




-(id)initwithuserCode:(NSString *)muserCode;

@end
