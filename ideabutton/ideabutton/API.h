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

- (User *)queryUser:(NSDictionary*)criteria;    //用户登录
- (User*)newUser:(NSDictionary*)userDict;       //用户注册
- (User*)newUserHaveIcon:(NSData *)data1 paramArr:(NSDictionary *)mparamArr;   //用户注册(带头像)
- (User*)updateUser:(NSDictionary*)userDict;     //完善用户信息
- (NSDictionary*)updateUserField:(NSDictionary*)dict;    //用户信息按字段更新
- (NSDictionary*)userInfo:(NSDictionary*)dict;       //用户信息查看

- (void)realNameAuth:(NSData*)data;           //实名认证

- (void)isEnabledNickname:(NSDictionary*)dict;      //用户名是否合法
- (void)isEnabledEmail:(NSDictionary*)dict;     //邮箱是否合法

- (NSDictionary*)userMessages:(NSDictionary*)dict;      //用户消息列表

- (NSArray*)createIdea:(NSDictionary*)dict;    //生成创意
- (NSString*)occupyIdea:(NSDictionary*)dict;    //霸占创意
- (NSString*)collectIdea:(NSDictionary*)dict;   //收藏创意
- (NSString*)reformIdea:(NSDictionary*)dict;    //改造创意
- (NSDictionary*)updateReformedIdea:(NSDictionary*)dict;    //修改已改造创意

- (NSDictionary*)deleteOccupiedIdea:(NSDictionary*)dict;    //删除霸占创意
- (NSDictionary*)deleteCollectedIdea:(NSDictionary*)dict;    //删除收藏创意
- (NSDictionary*)deleteReformedIdea:(NSDictionary*)dict;    //删除改造创意

- (NSArray*)myOccupiedIdeas:(NSDictionary*)dict;    //我霸占的创意
- (NSArray*)myReformedIdeas:(NSDictionary*)dict;    //我改造的创意
- (NSArray*)myCollectedIdeas:(NSDictionary*)dict;    //我收藏的创意

- (NSArray*)friendsIdeas:(NSDictionary*)dict;   //朋友们的创意
- (NSDictionary*)userIdeas:(NSDictionary*)dict;   //用户的创意

- (void)saveSuggestion:(NSDictionary*)dict;     //保存建议
- (NSArray*)suggestionList:(NSDictionary*)dict;      //建议列表
- (NSDictionary*)suggestionDetail:(NSDictionary*)dict;      //建议详情

- (void)saveComment:(NSDictionary*)dict;        //保存评论
- (void)clickPraise:(NSDictionary*)dict;        //点赞
- (void)saveAndForward:(NSDictionary*)dict;     //保存转发

- (NSArray*)productList:(NSDictionary*)dict;        //产品选项列表
- (NSArray*)appealList:(NSDictionary*)dict;         //诉求点选项列表

- (NSInteger)userIdeasRemainderNumber:(NSDictionary*)dict;     //用户当日剩余点子数
- (void)logIdeaViewed:(NSDictionary*)dict;      //记录浏览日志
- (NSDictionary*)hasIdeaBeenUsed:(NSDictionary*)dict;       //判断点子是否已经被(霸占/收藏/改造)
- (NSDictionary*)postFeedBackurl:(NSDictionary*)dict;//提交建议
@end
