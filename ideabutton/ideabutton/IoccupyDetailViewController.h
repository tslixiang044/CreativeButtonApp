//
//  IoccupyDetailViewController.h
//  ideabutton
//
//  Created by ZhouTong on 15-3-3.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyBaseViewController.h"



//---------------------
@class IoccupyDetailViewController;
@protocol IoccupyDetailViewControllerDelegate <NSObject>
-(void)gotoviewcontroller_Ioccupy_detail:(UIViewController *)mviewcontroller;
@end
//---------------------

@interface IoccupyDetailViewController : MyBaseViewController

 @property(nonatomic,assign)id<IoccupyDetailViewControllerDelegate>delegate;
@end
