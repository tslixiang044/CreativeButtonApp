//
//  MyUIButton.h
//  jintiApp
//
//  Created by jintimac on 12-12-11.
//  Copyright (c) 2012年 jintimac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyUIButton : UIButton
{
    NSString *mtag;
    int index;
    
    
}

@property(nonatomic,strong)NSString *mtag;
@property(nonatomic)int index;



- (id)initWithFrame:(CGRect)frame bgimg:(NSString *)mimg title:(NSString*)mtitle ;





@end
