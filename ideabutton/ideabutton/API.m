//
//  API.m
//  ideabutton
//
//  Created by Li Xiang on 15/2/16.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import "API.h"
#import "DB.h"
#import "Base64.h"

@interface API ()

@property(nonatomic, strong)NSString *baseURL;

- (id)doRequestAndParseWithURL:(NSString*)urlStr;
- (id)doPostAndParseWithURL:(NSString*)urlStr data:(NSData*)data;

@end

@implementation API

+ (API *)sharedInstance
{
    static API *sharedInstance = nil;
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^{
        sharedInstance = [[API alloc]init];
    });
    
    return sharedInstance;
}

- (id)init
{
    self=[super init];
    if(self)
    {
        self.baseURL = @"http://223.6.252.147/web/mobile/api/";//             测试
        
        //        self.baseURL = @"http://mobile.zt906.com:8092/channel/api/mobile/";//         生产
    }
    return self;
}

- (User *)queryUser:(NSDictionary*)criteria
{
    NSMutableString *urlStr = [[NSMutableString alloc]initWithString:self.baseURL];
    [urlStr appendString:@"login.pfv"];
    
    NSDictionary *userDict = [self doRequestAndParseWithURL:urlStr header:criteria];
    if(!userDict)
    {
        return nil;
    }
    
    User *user = [[User alloc]initWithDict:[userDict objectForKey:@"data"]];
    if(user)
    {
        self.user = user;
    }
    return user;
}

- (User*)newUser:(NSDictionary*)userDict
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",self.baseURL, @"register.pfv"];
    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:userDict options:0 error:nil];
    NSDictionary *retDict = [self doPostAndParseWithURL:urlStr data:bodyData];
    
    if(!retDict)
    {
        return nil;
    }
    
    User *user = [[User alloc]initWithDict:[retDict objectForKey:@"data"]];
    if(user)
    {
        self.user = user;
    }
    return user;
}

- (id)doRequestAndParseWithURL:(NSString*)urlStr
{
    return [self doRequestAndParseWithURL:urlStr header:nil];
}

- (id)doRequestAndParseWithURL:(NSString*)urlStr header:(NSDictionary *)headers
{
    NSMutableString *urlStr1 = [[NSMutableString alloc]initWithString:urlStr];
    
    NSURL *urlObj = [NSURL URLWithString:urlStr1];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlObj cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    if(headers)
    {
        for(NSString* keyStr in headers.allKeys)
        {
            NSString *encodedAuthStr = [[[headers objectForKey:keyStr] dataUsingEncoding:NSUTF8StringEncoding]base64EncodedString];
            [request setValue:encodedAuthStr forHTTPHeaderField:keyStr];
        }
    }
    
    if(self.user && [request valueForHTTPHeaderField:@"Auth"] ==nil)
    {
        NSString *authStr = [NSString stringWithFormat:@"%@:%@", self.user.userName,self.user.token];
        NSString *encodedAuthStr = [[authStr dataUsingEncoding:NSUTF8StringEncoding] base64EncodedString];
        [request setValue:encodedAuthStr forHTTPHeaderField:@"Auth"];
    }
    
    NSURLResponse *resp = nil;
    NSError *err = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&resp error:&err];
    
    if(!data)
    {
        return nil;
    }
    
    //Remove control characters
    NSString *toProcessStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSData *processedData = [[self removeUnescapedCharacter:toProcessStr] dataUsingEncoding:NSUTF8StringEncoding];
    //Hope someday we can remove this, this is evil
#ifdef DEBUG
    NSLog(@"response string:\n%@",[[NSString alloc]initWithData:processedData encoding:NSUTF8StringEncoding]);
#endif
    
    id retObj = [NSJSONSerialization JSONObjectWithData:processedData options:NSJSONReadingMutableContainers error:&err];
    if(retObj==nil || [[retObj objectForKey:@"code"] isEqualToString:@"0"]!=YES)
    {
        self.code = [retObj objectForKey:@"code"];
        self.msg = [retObj objectForKey:@"msg"];
        
        return nil;
    }
    
    self.code = @"0";
    self.msg = @"";
    
    return retObj;
}

- (id)doPostAndParseWithURL:(NSString*)urlStr data:(NSData*)data
{
    NSURL *urlObj = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8)]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlObj cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
    if(self.user && [request valueForHTTPHeaderField:@"Auth"] ==nil)
    {
        NSString *authStr = [NSString stringWithFormat:@"%@:%@", self.user.userName,self.user.token];
        NSString *encodedAuthStr = [[authStr dataUsingEncoding:NSUTF8StringEncoding] base64EncodedString];
        [request setValue:encodedAuthStr forHTTPHeaderField:@"Auth"];
    }
    [request setHTTPBody:data];
    
    NSURLResponse *resp = nil;
    NSError *err = nil;
    NSData *retData = [NSURLConnection sendSynchronousRequest:request returningResponse:&resp error:&err];
    
#ifdef DEBUG
    NSLog(@"response string:\n%@",[[NSString alloc]initWithData:retData encoding:NSUTF8StringEncoding]);
#endif
    
    if(!retData)
    {
        return nil;
    }
    
    id retObj = [NSJSONSerialization JSONObjectWithData:retData options:0 error:&err];
    if(retObj==nil || [[retObj objectForKey:@"code"] isEqualToString:@"0"]!=YES)
    {
        self.code = [retObj objectForKey:@"code"];
        self.msg = [retObj objectForKey:@"msg"];
        
        return nil;
    }
    
    self.code = @"0";
    self.msg = @"";
    return retObj;
}

- (id)doDeleteAndParseWithURL:(NSString*)urlStr
{
    NSURL *urlObj = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8)]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlObj cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    request.HTTPMethod = @"DELETE";
    
    if(self.user && [request valueForHTTPHeaderField:@"Auth"] ==nil)
    {
        NSString *authStr = [NSString stringWithFormat:@"%@:%@", self.user.userName,self.user.token];
        NSString *encodedAuthStr = [[authStr dataUsingEncoding:NSUTF8StringEncoding] base64EncodedString];
        [request setValue:encodedAuthStr forHTTPHeaderField:@"Auth"];
    }
    
    NSURLResponse *resp = nil;
    NSError *err = nil;
    NSData *retData = [NSURLConnection sendSynchronousRequest:request returningResponse:&resp error:&err];
    
    if(!retData)
    {
        return nil;
    }
    
    id retObj = [NSJSONSerialization JSONObjectWithData:retData options:0 error:&err];
    if(retObj==nil || [[retObj objectForKey:@"code"] isEqualToString:@"0"]!=YES)
    {
        self.code = [retObj objectForKey:@"code"];
        self.msg = [retObj objectForKey:@"msg"];
        
        return nil;
    }
    
    self.code = @"0";
    self.msg = @"";
    
    return retObj;
}

- (NSString *)removeUnescapedCharacter:(NSString *)inputStr
{
    NSCharacterSet *controlChars = [NSCharacterSet controlCharacterSet];
    NSRange range = [inputStr rangeOfCharacterFromSet:controlChars];
    
    if (range.location != NSNotFound)
    {
        NSMutableString *mutable = [NSMutableString stringWithString:inputStr];
        
        while (range.location != NSNotFound)
        {
            [mutable deleteCharactersInRange:range];
            range = [mutable rangeOfCharacterFromSet:controlChars];
        }
        return mutable;
    }
    return inputStr;
}

@end
