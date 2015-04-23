//
//  User.m
//  zt907
//
//  Created by Jian Hu on 13-8-13.
//  Copyright (c) 2013年 Jian Hu. All rights reserved.
//

#import "ZTModel.h"

@implementation User

static User *mlogin;

+(void)setLogin:(User *)obj
{
    if(mlogin)
    {
        mlogin = nil;
    }
    
    mlogin= obj;
}

+(User*) GetInstance
{
    @synchronized(self)
    {
        if (!mlogin)
        {
            mlogin = [[User alloc] init];
        }
        return mlogin;
    }
}

+(void)ClearLoginResult
{
    mlogin = nil;
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userDataInfo"];
    [[NSUserDefaults standardUserDefaults] synchronize]; 
}

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
        self.avatar = [uDict objectForKey:@"avatar"];
        self.email = [uDict objectForKey:@"email"];
        self.password = [uDict objectForKey:@"password"];
    }
    return self;
}

- (NSDictionary*)asDictionary
{
    if (self.email)
    {
        self.email = @"";
    }
    
    if (self.avatar.length > 0)
    {
        NSDictionary *userDict = @{@"collegePrivate":@(self.collegePrivate),@"nickname":self.nickName,@"token":self.token,@"userCode":@(self.userCode),@"gender":@(self.gender),@"userStatus":@(self.userStatus),@"majorPrivate":@(self.majorPrivate),@"userFullnamePrivate":@(self.userFullnamePrivate),@"userLevel":@(self.userLevel),@"auditStatus":@(self.auditStatus),@"avatar":self.avatar};
        
        return userDict;
    }
    else
    {
        NSDictionary *userDict = @{@"collegePrivate":@(self.collegePrivate),@"nickname":self.nickName,@"token":self.token,@"userCode":@(self.userCode),@"gender":@(self.gender),@"userStatus":@(self.userStatus),@"majorPrivate":@(self.majorPrivate),@"userFullnamePrivate":@(self.userFullnamePrivate),@"userLevel":@(self.userLevel),@"auditStatus":@(self.auditStatus)};
        
        return userDict;
    }
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:[NSString stringWithFormat:@"%ld",(long)self.collegePrivate] forKey:@"collegePrivate"];
    [aCoder encodeObject:self.nickName forKey:@"nickname"];
    [aCoder encodeObject:self.token forKey:@"token"];
    [aCoder encodeObject:[NSString stringWithFormat:@"%ld",(long)self.userStatus] forKey:@"userStatus"];
    [aCoder encodeObject:[NSString stringWithFormat:@"%ld",(long)self.gender] forKey:@"gender"];
    [aCoder encodeObject:[NSString stringWithFormat:@"%ld",(long)self.majorPrivate] forKey:@"majorPrivate"];
    [aCoder encodeObject:[NSString stringWithFormat:@"%ld",(long)self.userCode] forKey:@"userCode"];
    
    [aCoder encodeObject:[NSString stringWithFormat:@"%ld",(long)self.userFullnamePrivate] forKey:@"userFullnamePrivate"];
    [aCoder encodeObject:[NSString stringWithFormat:@"%ld",(long)self.userLevel] forKey:@"userLevel"];
    
    [aCoder encodeObject:[NSString stringWithFormat:@"%ld",(long)self.auditStatus] forKey:@"auditStatus"];
    
    [aCoder encodeObject:self.avatar forKey:@"avatar"];
    [aCoder encodeObject:self.email forKey:@"email"];
    [aCoder encodeObject:self.password forKey:@"password"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        self.collegePrivate = [[aDecoder decodeObjectForKey:@"collegePrivate"] integerValue];
        self.nickName = [aDecoder decodeObjectForKey:@"nickname"];
        self.token = [aDecoder decodeObjectForKey:@"token"];
        self.userStatus = [[aDecoder decodeObjectForKey:@"userStatus"] integerValue];
        self.gender = [[aDecoder decodeObjectForKey:@"gender"] integerValue];
        self.majorPrivate = [[aDecoder decodeObjectForKey:@"majorPrivate"] integerValue];
        self.userCode = [[aDecoder decodeObjectForKey:@"userCode"] integerValue];
        self.userFullnamePrivate = [[aDecoder decodeObjectForKey:@"userFullnamePrivate"] integerValue];
        self.userLevel = [[aDecoder decodeObjectForKey:@"userLevel"] integerValue];
        self.auditStatus = [[aDecoder decodeObjectForKey:@"auditStatus"] integerValue];
        self.avatar = [aDecoder decodeObjectForKey:@"avatar"];
        self.email = [aDecoder decodeObjectForKey:@"email"];
        self.password = [aDecoder decodeObjectForKey:@"password"];
        
    }
    return self;
}


@end
