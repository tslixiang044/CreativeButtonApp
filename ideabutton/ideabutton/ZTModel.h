//
//  model.h
//
//  Created by Xiang Li on 15-2-10.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZTModel <NSObject>

@optional

- (NSString*)dbKey;
- (id<ZTModel>)initWithDict:(NSDictionary*)dict;
- (NSDictionary*)asDictionary;

@end

@interface User : NSObject <ZTModel,NSCoding>

@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, assign) NSInteger collegePrivate;
@property (nonatomic, assign) NSInteger gender;
@property (nonatomic, assign) NSInteger userStatus;
@property (nonatomic, assign) NSInteger userCode;
@property (nonatomic, assign) NSInteger userFullnamePrivate;
@property (nonatomic, assign) NSInteger userLevel;
@property (nonatomic, assign) NSInteger majorPrivate;
@property (nonatomic, assign) NSInteger auditStatus;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *password;

+(User*) GetInstance;
+(void)setLogin:(User *)obj;
+(void)ClearLoginResult;

@end
