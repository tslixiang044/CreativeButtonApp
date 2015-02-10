//
//  IoccupyViewController.h
//  ideabutton
//
//  Created by Xiang Li on 15-2-9.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyBaseViewController.h"


//---------------------
@class IoccupyViewController;
@protocol IoccupyViewControllerDelegate <NSObject>
-(void)gotoviewcontroller_Ioccupy:(UIViewController *)mviewcontroller;
@end
//---------------------

@interface IoccupyViewController : MyBaseViewController


@property(nonatomic,assign)id<IoccupyViewControllerDelegate>delegate;
@end
