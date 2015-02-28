//
//  MyBaseViewController.h
//  HomeFurnishingApp
//
//  Created by 周同 on 14-12-8.
//
//

#import <UIKit/UIKit.h>
#import "Global.h"


@interface MyBaseViewController : UIViewController
{
    
}
-(void)setrightbaritem_imgname:(NSString*)icon_img_name title:(NSString*)mtitle;
-(void)setleftbaritem_imgname:(NSString*)icon_img_name title:(NSString*)mtitle;
-(void)btnright;
-(void)btnleft;

-(void)showalertview_text:(NSString *)mstr imgname:(NSString *)mimgname autoHiden:(BOOL)isautohiden;
-(void)hidenalertView;
-(void)alert:(NSString *)str;

-(void)ShowLoadingView;
-(void)hidenLoadingView;

-(void)showMenuView;
-(void)hidenMenuView;

-(void)showAlertView_number:(int)Num;
@end
