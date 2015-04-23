//
//  RegisterSuccessView.h
//  ideabutton
//
//  Created by ZhouTong on 15-4-7.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import <UIKit/UIKit.h>
//---------------------
@class RegisterSuccessViewController;
@protocol RegisterSuccessViewDelegate <NSObject>

-(void)start;
-(void)perfectInfo;
-(void)uploadData;
@end
//---------------------

@interface RegisterSuccessView : UIView
{
    NSInteger flag;
}

@property(nonatomic,assign)NSInteger flag;
@property(assign)id<RegisterSuccessViewDelegate>delegate;

-(id)initWithFrame:(CGRect)frame Flag:(NSInteger)flag;

@end
