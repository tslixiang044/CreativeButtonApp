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
        self.isVip = [[uDict objectForKey:@"isVip"] boolValue];
        self.nickName = [uDict objectForKey:@"nickname"];
        self.token = [uDict objectForKey:@"token"];
        self.userID = [uDict objectForKey:@"userCode"];
        self.userName = [uDict objectForKey:@"userName"];
        self.userStatus = [[uDict objectForKey:@"userStatus"] integerValue];
    }
    return self;
}

- (NSDictionary*)asDictionary
{
        NSDictionary *userDict = @{@"isVip":@(self.isVip),@"nickname":self.nickName,@"token":self.token,@"userCode":self.userID,@"userName":self.userName,@"userStatus":@(self.userStatus)};
        
        return userDict;
}

@end
