//
//  MainViewController.h
//  ideabutton
//
//  Created by 周同 on 15-2-6.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyBaseViewController.h"

@interface MainViewController : MyBaseViewController
{
    UIScrollView *mscrollview;
    int k;
    BOOL isLoadingMore_1;
    BOOL isLoadingMore_2;
    
}
@property(nonatomic,strong)NSString *btntype;



@end
