//
//  PersonaInfomationViewController.h
//  ideabutton
//
//  Created by ZhouTong on 15-3-20.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyBaseViewController.h"
//#import "DB.h"
#import "ZTModel.h"
#import "ChooseCityViewController.h"

@interface PersonaInfomationViewController : MyBaseViewController
{
    User *user;
    BOOL isSelf;
    
    ChooseCityViewController* chooseCityViewController;
}
@property(nonatomic,strong)User *user;
@property(nonatomic,strong)NSDictionary *dic_data;
@property(nonatomic,strong)NSString *userCode;

@property(nonatomic,retain)NSMutableArray *mArr_1;


-(id)initwithuserCode:(NSString *)muserCode;

@end
