//
//  JsonResult.h
//  ideabutton
//
//  Created by 周同 on 15-2-12.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseEntity.h"
@interface JsonResult : BaseEntity


@property(nonatomic,retain)NSString *code;
@property(nonatomic,retain)NSString *msg;
@property(nonatomic,retain)NSArray *data;


@end
