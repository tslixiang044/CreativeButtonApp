//
//  IChangedViewController.h
//  ideabutton
//
//  Created by Jian Hu on 15-2-9.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyBaseViewController.h"


//---------------------
@class IChangedViewController;
@protocol IChangedViewControllerDelegate <NSObject>
-(void)gotoviewcontroller_changed:(UIViewController *)mviewcontroller;
@end
//---------------------
@interface IChangedViewController : MyBaseViewController
{
    
}
@property(nonatomic,assign)id<IChangedViewControllerDelegate>delegate;
@end
