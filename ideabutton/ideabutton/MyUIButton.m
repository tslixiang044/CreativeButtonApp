//
//  MyUIButton.m
//  jintiApp
//
//  Created by jintimac on 12-12-11.
//  Copyright (c) 2012年 jintimac. All rights reserved.
//

#import "MyUIButton.h"


@implementation MyUIButton

@synthesize mtag,index;



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}



- (id)initWithFrame:(CGRect)frame bgimg:(NSString *)mimg title:(NSString*)mtitle 
{
    self = [super initWithFrame:frame];
    if (self)
    {
        if(![mimg isEqualToString:@""])
        {
            NSString *imgpath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:mimg];
            UIImage * img = [[UIImage alloc] initWithContentsOfFile:imgpath];
            
            [self setBackgroundImage:img forState:UIControlStateNormal];
         
        }
        
        [self setTitle:mtitle forState:UIControlStateNormal];
        
        self.titleLabel.font=[UIFont boldSystemFontOfSize:15];
        
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        
        

    }
    return self;
}

- (id)initWithRoundButton_Frame:(CGRect)frame bgimg:(NSString *)mimg title:(NSString*)mtitle
{
    self = [super initWithFrame:frame];
    if (self)
    {
        if(![mimg isEqualToString:@""])
        {
            NSString *imgpath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:mimg];
            UIImage * img = [[UIImage alloc] initWithContentsOfFile:imgpath];
            
            [self setBackgroundImage:img forState:UIControlStateNormal];
            
        }
        
        [self setTitle:mtitle forState:UIControlStateNormal];
        
        self.titleLabel.font=[UIFont boldSystemFontOfSize:15];
        
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        //------------------------------------
        CALayer *layer = [self layer];
        [layer setMasksToBounds:YES];
        CGFloat radius=frame.size.width/2; //设置圆角的半径为图片宽度的一半
        [layer setCornerRadius:radius];
        //[layer setBorderWidth:2.0];//添加白色的边框
        //[layer setBorderColor:[UIColor whiteColor].CGColor];
        
    }
    return self;
}
@end
