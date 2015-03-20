//
//  MyWebviewViewController.h
//  jintiApp
//
//  Created by jintimac on 12-12-18.
//  Copyright (c) 2012年 jintimac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyBaseViewController.h"
@interface MyWebviewViewController : MyBaseViewController<UIWebViewDelegate,Globaldelegate>
{
    UIWebView *mwebview;
    
    NSString *urlstr;
    
    NSString *httpurl;
    
    NSString *filename;
}
@property(nonatomic,strong)NSString *urlstr;
@property(nonatomic,strong)NSString *filename;
@end
