//
//  MyToolView.h
//  ideabutton
//
//  Created by ZhouTong on 15-2-27.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTModel.h"

//---------------------
@class MyToolView;
@protocol MyToolViewDelegate <NSObject>
@optional
-(void)LoginOUt;
@end
//---------------------



@interface MyToolView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UIButton *btnClose;
    UITableView *mtableview;
    NSMutableArray *marr;
    
    User* user;
}
@property(assign)id<MyToolViewDelegate>delegate;


-(void)hidentoolView;
-(void)showtoolView;

@end
