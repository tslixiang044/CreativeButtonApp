//
//  UIImage+UIImageScale.h
//  jintiApp
//
//  Created by jintimac on 13-1-16.
//  Copyright (c) 2013年 jintimac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (UIImageScale)

-(UIImage*)getSubImage:(CGRect)rect;
-(UIImage *)scaleToSize:(CGSize)size;
- (UIImage*)rotateImage:(UIImage *)image;

@end
