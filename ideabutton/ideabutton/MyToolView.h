//
//  MyToolView.h
//  ideabutton
//
//  Created by ZhouTong on 15-2-27.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import <UIKit/UIKit.h>

//---------------------
@class MyToolView;
@protocol MyToolViewDelegate <NSObject>
@optional

@end
//---------------------



@interface MyToolView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UIButton *btnClose;
    UITableView *mtableview;
    NSMutableArray *marr;
}



-(void)hidentoolView;
-(void)showtoolView;

@end
