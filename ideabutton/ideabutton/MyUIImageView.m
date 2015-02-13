//
//  MyUIImageView.m
//  ideabutton
//
//  Created by Jian Hu on 15-2-12.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import "MyUIImageView.h"

@implementation MyUIImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
    }
    return self;
}
- (id)initWithFrame_head:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        self.userInteractionEnabled=YES;
        CALayer *layer = [self layer];
        [layer setMasksToBounds:YES];
        CGFloat radius=frame.size.width/2; //设置圆角的半径为图片宽度的一半
        [layer setCornerRadius:radius];
        [layer setBorderWidth:2.0];//添加白色的边框
        [layer setBorderColor:[UIColor whiteColor].CGColor];
        
    }
    return self;
}
@end
