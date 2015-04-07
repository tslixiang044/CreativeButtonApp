//
//  User.m
//  zt907
//
//  Created by Jian Hu on 13-8-13.
//  Copyright (c) 2013年 Jian Hu. All rights reserved.
//

#import "ZTModel.h"

@implementation User

- (User*)initWithDict:(NSDictionary*)uDict{
    if(!uDict){
        return nil;
    }

    self = [super init];
    if(self)
    {
        self.collegePrivate = [[uDict objectForKey:@"collegePrivate"] integerValue];
        self.nickName = [uDict objectForKey:@"nickname"];
        self.token = [uDict objectForKey:@"token"];
        self.userStatus = [[uDict objectForKey:@"userStatus"] integerValue];
        self.gender = [[uDict objectForKey:@"gender"] integerValue];
        self.majorPrivate = [[uDict objectForKey:@"majorPrivate"] integerValue];
        self.userCode = [[uDict objectForKey:@"userCode"] integerValue];
        self.userFullnamePrivate = [[uDict objectForKey:@"userFullnamePrivate"] integerValue];
        self.userLevel = [[uDict objectForKey:@"userLevel"] integerValue];
        self.auditStatus = [[uDict objectForKey:@"auditStatus"] integerValue];
    }
    return self;
}

- (NSDictionary*)asDictionary
{
        NSDictionary *userDict = @{@"collegePrivate":@(self.collegePrivate),@"nickname":self.nickName,@"token":self.token,@"userCode":@(self.userCode),@"gender":@(self.gender),@"userStatus":@(self.userStatus),@"majorPrivate":@(self.majorPrivate),@"userFullnamePrivate":@(self.userFullnamePrivate),@"userLevel":@(self.userLevel),@"auditStatus":@(self.auditStatus)};
        
        return userDict;
}

@end
