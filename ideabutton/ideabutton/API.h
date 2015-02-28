//
//  API.h
//  ideabutton
//
//  Created by Li Xiang on 15/2/16.
//  Copyright (c) 2015年 ttt. All rights reserved.
//
@class User;
@class genIdeas;

#import <Foundation/Foundation.h>

@interface API : NSObject
@property(nonatomic, strong)User *user;
@property(nonatomic, strong)NSString *code;
@property(nonatomic, strong)NSString *msg;

+ (API *)sharedInstance;

- (User *)queryUser:(NSDictionary*)criteria;
- (User*)newUser:(NSDictionary*)userDict;
//- (User*)resetPSWWithParams:(NSDictionary *)params;
-(User*)updateUser:(NSDictionary*)userDict;

- (NSArray*)createIdea:(NSDictionary*)dict;    //生成创意
- (NSDictionary*)occupyIdea:(NSDictionary*)dict;    //霸占创意
- (NSDictionary*)collectIdea:(NSDictionary*)dict;   //收藏创意
- (NSDictionary*)reformIdea:(NSDictionary*)dict;    //改造创意
- (NSDictionary*)updateReformedIdea:(NSDictionary*)dict;    //修改已改造创意

- (NSDictionary*)deleteOccupiedIdea:(NSDictionary*)dict;    //删除霸占创意
- (NSDictionary*)deleteCollectedIdea:(NSDictionary*)dict;    //删除收藏创意
- (NSDictionary*)deleteReformedIdea:(NSDictionary*)dict;    //删除改造创意

- (NSArray*)myOccupiedIdeas:(NSDictionary*)dict;    //我霸占的创意
- (NSArray*)myReformedIdeas:(NSDictionary*)dict;    //我改造的创意
- (NSArray*)myCollectedIdeas:(NSDictionary*)dict;    //我收藏的创意

@end
