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

- (NSString *)dbKeyWithID:(NSString*)modelID type:(enum ModelType)modelType{
    NSString *keyModifier = nil;
    switch (modelType) {
        case ResourceType:
            keyModifier = @"res";
            break;
        case OrderType:
             keyModifier = @"order";
            break;
        case NoticeType:
            keyModifier = @"notice";
            break;
        case VendorType:
            keyModifier = @"vendor";
            break;
        case MemberType:
            keyModifier = @"member";
            break;
        case CartItemType:
            keyModifier = @"cart-item";
            break;
        case FetcherType:
            keyModifier = @"fetcher";
            break;
        case ReceiverType:
            keyModifier = @"receiver";
            break;
        case MessageType:
            keyModifier = @"message";
            break;
        default:
            break;
    }
    return [NSString stringWithFormat:@"model:%@:%@",keyModifier, modelID];
}

- (id<ZTModel>)createModelWithDict:(NSDictionary*)dict type:(enum ModelType)modelType{
    id<ZTModel> model = nil;
//    switch (modelType) {
//        case ResourceType:
//            model = [[Resource alloc]initWithDict:dict];
//            break;
//        case OrderType:
//            model = [[Order alloc]initWithDict:dict];
//            break;
//        case NoticeType:
//            model = [[Notice alloc]initWithDict:dict];
//            break;
//        case VendorType:
//            model = [[Vendor alloc]initWithDict:dict];
//            break;
//        case MemberType:
//            model = [[Member alloc]initWithDict:dict];
//            break;
//        case CartItemType:
//            model = [[CartItem alloc]initWithDict:dict];
//            break;
//        case FetcherType:
//            model = [[Fetcher alloc]initWithDict:dict];;
//            break;
//        case ReceiverType:
//            model = [[Receiver alloc]initWithDict:dict];;
//            break;
//        case MessageType:
//            model = [[Message alloc]initWithDict:dict];;
//            break;
//        case InfoType:
//            model=[[Info alloc] initWithDict:dict];
//            break;
//        default:
//            break;
//    }
    return model;
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

- (id<ZTModel>)queryModelWithID:(NSString*)modelID type:(enum ModelType)modelType;{
    
   NSDictionary *modelDict = [self queryArbitraryObjectWithKey:[self dbKeyWithID:modelID type:modelType]];
    if(!modelDict)
        return nil;
    
    id<ZTModel> model = [self createModelWithDict:modelDict type:modelType];
    
    return model;
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

- (BOOL)saveCountOfUnReadMessages:(NSString*)msgCount
{
    BOOL status = [self.indb setString:msgCount forKey:@"msg:UnRead"];
    return status;
}

- (NSString*)queryCountOfUnReadMessages
{
    NSString* msgCount = [self.indb stringForKey:@"msg:UnRead"];
    
    return msgCount;
}

@end
