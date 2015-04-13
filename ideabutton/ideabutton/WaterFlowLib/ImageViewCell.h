//
//  ImageViewCell.h
//  WaterFlowViewDemo
//
//  Created by Smallsmall on 12-6-12.
//  Copyright (c) 2012年 activation group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "WaterFlowViewCell.h"
#import "UIImageView+WebCache.h"
#import "WaterFlowObj.h"


//---------------------
@class ImageViewCell;
@protocol ImageViewCellDelegate <NSObject>
-(void)gotoviewcontroller_imageviewcell_usercode:(int )muserCode;
@end
//---------------------


@interface ImageViewCell : WaterFlowViewCell<UIGestureRecognizerDelegate>
{
    UIView *view_bg;
    
    UIImageView *imgview_header;
    UILabel *lblnickname;
    UILabel *lblsource;
    
    
    UIView *view_center;
    UILabel *lbldesc;
    UILabel *lblproduct;
    UILabel *lbltime;
    
    UILabel *lblPraise;
    UILabel *lblForward;
    UIImageView* sexImageView;
}

-(void)setImageWithURL:(NSURL *)imageUrl;
-(void)setImage:(UIImage *)image;
-(void)relayoutViews;
-(void)setbtnObjct:(WaterFlowObj*)mobj;
-(void)setcenterviewColor:(int)row;


@property(nonatomic,assign)id<ImageViewCellDelegate>delegate;

@end
