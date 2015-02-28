//
//  DB.h
//  zt906
//
//  Created by Jian Hu on 13-10-21.
//  Copyright (c) 2013年 zt906. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZTModel.h"


@class APLevelDB;

@interface DB : NSObject

@property(nonatomic, strong) APLevelDB *indb;

+ (DB *)sharedInstance;

- (User *)queryUser;
- (BOOL)saveUser:(User*)user;
- (BOOL)deleteUser;

- (BOOL)removeKey:(NSString*)key;

- (BOOL)clearCacheExcept:(NSArray*)keys;

//- (id<ZTModel>)queryModelWithID:(NSString*)modelID type:(enum ModelType)modelType;
- (BOOL)saveModel:(id<ZTModel>)model;

- (BOOL)saveArbitraryObject:(id)obj withKey:(NSString*)key;
- (id)queryArbitraryObjectWithKey:(NSString*)key;

@end
