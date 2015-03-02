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



@interface ImageViewCell : WaterFlowViewCell
{
   // UIImageView *imageView;
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
    UILabel *lblcomment;
    
    
}

-(void)setImageWithURL:(NSURL *)imageUrl;
-(void)setImage:(UIImage *)image;
-(void)relayoutViews;
-(void)setbtnObjct:(WaterFlowObj*)mobj;
@end
