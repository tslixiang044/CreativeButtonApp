//
//  API.h
//  ideabutton
//
//  Created by Li Xiang on 15/2/16.
//  Copyright (c) 2015年 ttt. All rights reserved.
//
@class User;

#import <Foundation/Foundation.h>

@interface API : NSObject
@property(nonatomic, strong)User *user;
@property(nonatomic, strong)NSString *code;
@property(nonatomic, strong)NSString *msg;

+ (API *)sharedInstance;

- (User *)queryUser:(NSDictionary*)criteria;
- (User*)newUser:(NSDictionary*)userDict;
//- (User*)resetPSWWithParams:(NSDictionary *)params;

@end
