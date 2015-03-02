//
//  LoginView.h
//  ideabutton
//
//  Created by Li Xiang on 15/2/9.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyBaseViewController.h"


//---------------------
@class LoginViewController;
@protocol LoginViewControllerDelegate <NSObject>
@optional
-(void)loginSuccessfull;
@end
//---------------------

@interface LoginViewController : MyBaseViewController
{
    
}
@property(assign)id<LoginViewControllerDelegate>delegate;
@end
