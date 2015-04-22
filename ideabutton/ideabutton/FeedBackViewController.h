//
//  FeedBackViewController.h
//  jintiApp
//
//  Created by jintimac on 13-1-11.
//  Copyright (c) 2013年 jintimac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyBaseViewController.h"


//---------------------
@class FeedBackViewController;
@protocol FeedBackViewControllerDelegate <NSObject>
-(void)gotorootviewcontroller;
@end
//---------------------
@interface FeedBackViewController : MyBaseViewController<UITextViewDelegate,UIAlertViewDelegate,Globaldelegate>
{
    UITextView *txtfeedback;
    UITextField *txtcontact;
    //UIActivityIndicatorView *mactivity;
    UILabel *lbldesc;
    ASIHTTPRequest *mrequest;
}
@property(nonatomic,strong)id<FeedBackViewControllerDelegate>delegate;
@end
