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

@interface User : NSObject <ZTModel>

@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, assign) NSInteger userStatus;
@property (nonatomic, strong) NSString* password;
@property (nonatomic, assign) BOOL isVip;
@property (nonatomic, assign) BOOL rememberPSW;

@end
