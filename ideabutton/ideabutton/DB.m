//
//  DB.m
//  zt906
//
//  Created by Jian Hu on 13-10-21.
//  Copyright (c) 2013年 zt906. All rights reserved.
//

#import "DB.h"
#import "APLevelDB.h"

@interface DB ()

@end

@implementation DB

+ (DB *)sharedInstance
{
    static DB *sharedInstance = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        NSString *dbPath = [NSString stringWithFormat:@"%@db", NSTemporaryDirectory()];
        sharedInstance = [[DB alloc]init];
        NSError *err = nil;
        sharedInstance.indb = [APLevelDB levelDBWithPath:dbPath error:&err];
        
        if(err){
            [[NSFileManager defaultManager] removeItemAtPath:dbPath error:nil];
            sharedInstance.indb = [APLevelDB levelDBWithPath:dbPath error:&err];
        }
});
    
    return sharedInstance;
}

- (User *)queryUser{
    NSData * userData = [self.indb dataForKey:@"user:owner"];
    if(!userData)
        return nil;
    
    NSDictionary *userDict = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    User *user = [[User alloc]initWithDict:userDict];
    
    return user;
}

- (BOOL)saveUser:(User*)user{
    if(!user)
        return NO;
    
    NSDictionary *userDict = [user asDictionary];
    NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:userDict];
    BOOL status = [self.indb setData:userData forKey:@"user:owner"];
    return status;
}

- (BOOL)deleteUser{
    BOOL status = [self.indb removeKey:@"user:owner"];

    return status;
}

- (BOOL)removeKey:(NSString*)key{
    BOOL status = [self.indb removeKey:key];
    
    return status;
}

- (BOOL)clearCacheExcept:(NSArray*)keys{
    BOOL succ = YES;
    NSArray *allKeys = [self.indb allKeys];
    for(NSString *key in allKeys){
        if(![keys containsObject:key]){
            BOOL delSucc = [self.indb removeKey:key];
            if(!delSucc)
                succ = NO;
        }
    }
    
    return YES;
}

- (BOOL)saveModel:(id<ZTModel>)model{
    if(!model)
        return NO;
    
    NSDictionary *modelDict = [model asDictionary];
    BOOL status = [self saveArbitraryObject:modelDict withKey:[model dbKey]];
    return status;
}

- (BOOL)saveArbitraryObject:(id)obj withKey:(NSString *)key{
    if(!obj)
        return NO;
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:obj];
    BOOL status = [self.indb setData:data forKey:key];
    return status;
}

- (id)queryArbitraryObjectWithKey:(NSString*)key{
    NSData *storedData = [self.indb dataForKey:key];
    
    if(!storedData)
        return nil;
    
    id obj = [NSKeyedUnarchiver unarchiveObjectWithData:storedData];
    return obj;
}

@end
