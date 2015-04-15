//
//  ISavedViewController.h
//  ideabutton
//
//  Created by Jian Hu on 15-2-9.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyBaseViewController.h"



//---------------------
@class ISavedViewController;
@protocol ISavedViewControllerDelegate <NSObject>
-(void)gotoviewcontroller_save:(UIViewController *)mviewcontroller;
@end
//---------------------


@interface ISavedViewController : MyBaseViewController
{
    
}
@property(nonatomic,assign)id<ISavedViewControllerDelegate>delegate;
@end
 