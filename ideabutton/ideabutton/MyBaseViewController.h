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
@property(nonatomic,strong)NSString *mtag;



-(void)setrightbaritem_imgname:(NSString*)icon_img_name title:(NSString*)mtitle;
-(void)setleftbaritem_imgname:(NSString*)icon_img_name title:(NSString*)mtitle;
-(void)btnright;
-(void)btnleft;

-(void)showalertview_text:(NSString *)mstr frame:(CGRect)frame autoHiden:(BOOL)isautohiden;
-(void)hidenalertView;
-(void)alert:(NSString *)str;

-(void)ShowLoadingView;
-(void)hidenLoadingView;

-(void)showMenuView;
-(void)hidenMenuView;

-(void)showAlertView_desc:(NSString *)desc btntitle:(NSString *)mtitle;
-(void) PushToTop:(UIViewController*)mviewcontroller;
-(void) PopToParent;







@end
