//
//  MySegmentedControl.h
//  jintiApp
//
//  Created by jintimac on 13-1-25.
//  Copyright (c) 2013年 jintimac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyUIButton.h"


@class MySegmentedControl;
@protocol MySegmentedControlDelegate <NSObject>

-(void)msegment_selected:(MySegmentedControl *)mseg index:(int )mindex;

@end


@interface MySegmentedControl : UIView
{
    NSArray *items;
    
    int selectedSegmentIndex;
    
    
    NSMutableArray *btnlist;
    
    UIImageView *imgline;
 
}

@property(nonatomic,retain)NSArray *items;
@property(assign)id<MySegmentedControlDelegate>delegate;
@property(nonatomic)int selectedSegmentIndex;
//-------------单优
@property(nonatomic,retain)    NSMutableArray *btnlist;




//-(void)setItems:(NSArray *)mitems imgs:(NSArray *)mimgs;
-(void)scrollviewX:(float)x pagecount:(int)mpage;
-(void)showlineAnimaton;
@end
