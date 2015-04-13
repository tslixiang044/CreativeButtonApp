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
        self.baseURL = @"http://121.41.123.182:8091/web/mobile/api/";//             测试
        
        //        self.baseURL = @"http://223.6.252.147/web/mobile/api/";//         生产
        
        self.user = [[DB sharedInstance] queryUser];
    }
    return self;
}

- (User *)queryUser:(NSDictionary*)criteria
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",self.baseURL, @"login"];
    
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
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",self.baseURL, @"register"];
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

-(User*)updateUser:(NSDictionary*)userDict
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",self.baseURL, @"check/updateUser"];
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

-(User*)updateUserField:(NSDictionary*)userDict
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",self.baseURL, @"check/updateUserField"];
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

-(NSDictionary*)userInfo:(NSDictionary*)userDict
{
    NSMutableString *urlStr = [[NSMutableString alloc] initWithString:self.baseURL];
    [urlStr appendString:@"check/userInfo"];
    [urlStr appendString:[self constructQueryParamStr:userDict]];
    
    NSDictionary *retDict = [self doRequestAndParseWithURL:urlStr];
    
    if (!retDict)
    {
        return nil;
    }
    return retDict;
}

- (void)isEnabledNickname:(NSDictionary*)dict
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",self.baseURL, @"user/isEnabledNickname"];
    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    
    [self doPostAndParseWithURL:urlStr data:bodyData];
}

- (void)isEnabledEmail:(NSDictionary*)dict
{
    NSMutableString *urlStr = [[NSMutableString alloc] initWithString:self.baseURL];
    [urlStr appendString:@"user/isEnabledEmail"];
    [urlStr appendString:[self constructQueryParamStr:dict]];
    
    [self doRequestAndParseWithURL:urlStr];
}

- (NSDictionary*)userMessages:(NSDictionary*)criteria
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",self.baseURL, @"check/userMessages"];
    
    NSDictionary *userDict = [self doRequestAndParseWithURL:urlStr header:criteria];
    if(!userDict)
    {
        return nil;
    }
    
    return [userDict objectForKey:@"data"];
}

- (NSArray*)createIdea:(NSDictionary*)dict
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",self.baseURL, @"idea/genIdeas"];
    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSDictionary *retDict = [self doPostAndParseWithURL:urlStr data:bodyData];
    
    if (!retDict)
    {
        return nil;
    }
    
    return  [retDict objectForKey:@"data"];
}

- (NSString*)occupyIdea:(NSDictionary*)dict
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",self.baseURL, @"check/idea/occupyIdea"];
    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSDictionary *retDict = [self doPostAndParseWithURL:urlStr data:bodyData];
    
    if (!retDict)
    {
        return nil;
    }
    return  [retDict objectForKey:@"data"];
}

- (NSString*)collectIdea:(NSDictionary*)dict
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",self.baseURL, @"check/idea/collectIdea"];
    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSDictionary *retDict = [self doPostAndParseWithURL:urlStr data:bodyData];
    
    if (!retDict)
    {
        return nil;
    }
    return  [retDict objectForKey:@"data"];
}

- (NSString*)reformIdea:(NSDictionary*)dict
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",self.baseURL, @"check/idea/reformIdea"];
    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSDictionary *retDict = [self doPostAndParseWithURL:urlStr data:bodyData];
    
    if (!retDict)
    {
        return nil;
    }
    return  [retDict objectForKey:@"data"];
}

- (NSDictionary*)updateReformedIdea:(NSDictionary*)dict
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",self.baseURL, @"check/idea/updateReformedIdea"];
    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSDictionary *retDict = [self doPostAndParseWithURL:urlStr data:bodyData];
    
    if (!retDict)
    {
        return nil;
    }
    return  [retDict objectForKey:@"data"];
}

- (NSDictionary*)deleteOccupiedIdea:(NSDictionary*)dict
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",self.baseURL, @"check/idea/deleteOccupiedIdea"];
    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSDictionary *retDict = [self doPostAndParseWithURL:urlStr data:bodyData];
    
    if (!retDict)
    {
        return nil;
    }
    return  [retDict objectForKey:@"data"];
}

- (NSDictionary*)deleteCollectedIdea:(NSDictionary*)dict
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",self.baseURL, @"check/idea/deleteCollectedIdea"];
    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSDictionary *retDict = [self doPostAndParseWithURL:urlStr data:bodyData];
    
    if (!retDict)
    {
        return nil;
    }
    return  [retDict objectForKey:@"data"];
}

- (NSDictionary*)deleteReformedIdea:(NSDictionary*)dict
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",self.baseURL, @"check/idea/deleteReformedIdea"];
    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSDictionary *retDict = [self doPostAndParseWithURL:urlStr data:bodyData];
    
    if (!retDict)
    {
        return nil;
    }
    return  [retDict objectForKey:@"data"];
}

- (NSArray*)myOccupiedIdeas:(NSDictionary*)dict
{
    NSMutableString *urlStr = [[NSMutableString alloc] initWithString:self.baseURL];
    [urlStr appendString:@"check/idea/myOccupiedIdeas"];
    [urlStr appendString:[self constructQueryParamStr:dict]];
    
    NSDictionary *retDict = [self doRequestAndParseWithURL:urlStr];
    
    if (!retDict)
    {
        return nil;
    }
    
    return [retDict objectForKey:@"data"];
}

- (NSArray*)myCollectedIdeas:(NSDictionary*)dict
{
    NSMutableString *urlStr = [[NSMutableString alloc] initWithString:self.baseURL];
    [urlStr appendString:@"check/idea/myCollectedIdeas"];
    [urlStr appendString:[self constructQueryParamStr:dict]];
    
    NSDictionary *retDict = [self doRequestAndParseWithURL:urlStr];
    
    if (!retDict)
    {
        return nil;
    }
    
    return [retDict objectForKey:@"data"];
}

- (NSArray*)myReformedIdeas:(NSDictionary*)dict
{
    NSMutableString *urlStr = [[NSMutableString alloc] initWithString:self.baseURL];
    [urlStr appendString:@"check/idea/myReformedIdeas"];
    [urlStr appendString:[self constructQueryParamStr:dict]];
    
    NSDictionary *retDict = [self doRequestAndParseWithURL:urlStr];
    
    if (!retDict)
    {
        return nil;
    }
    
    return [retDict objectForKey:@"data"];
}


- (NSArray*)friendsIdeas:(NSDictionary*)dict
{
    NSMutableString *urlStr = [[NSMutableString alloc] initWithString:self.baseURL];
    [urlStr appendString:@"idea/friendsIdeas"];
    [urlStr appendString:[self constructQueryParamStr:dict]];
    
    NSDictionary *retDict = [self doRequestAndParseWithURL:urlStr];
    
    if (!retDict)
    {
        return nil;
    }
    
    return [retDict objectForKey:@"data"];
}

- (NSArray*)userIdeas:(NSDictionary*)dict
{
    NSMutableString *urlStr = [[NSMutableString alloc] initWithString:self.baseURL];
    [urlStr appendString:@"idea/userIdeas"];
    [urlStr appendString:[self constructQueryParamStr:dict]];
    
    NSDictionary *retDict = [self doRequestAndParseWithURL:urlStr];
    
    if (!retDict)
    {
        return nil;
    }
    
    return [retDict objectForKey:@"data"];
}

- (void)saveSuggestion:(NSDictionary*)dict
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",self.baseURL, @"check/suggestion/add"];
    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    [self doPostAndParseWithURL:urlStr data:bodyData];
}

- (NSArray*)suggestionList:(NSDictionary*)dict
{
    NSMutableString *urlStr = [[NSMutableString alloc] initWithString:self.baseURL];
    [urlStr appendString:@"suggestion/list"];
    [urlStr appendString:[self constructQueryParamStr:dict]];
    
    NSDictionary *retDict = [self doRequestAndParseWithURL:urlStr];
    
    if (!retDict)
    {
        return nil;
    }
    
    return [retDict objectForKey:@"data"];
}

- (NSDictionary*)suggestionDetail:(NSDictionary*)dict
{
    NSMutableString *urlStr = [[NSMutableString alloc] initWithString:self.baseURL];
    [urlStr appendString:@"suggestion/detail"];
    [urlStr appendString:[self constructQueryParamStr:dict]];
    
    NSDictionary *retDict = [self doRequestAndParseWithURL:urlStr];
    
    if (!retDict)
    {
        return nil;
    }
    
    return [retDict objectForKey:@"data"];
}

- (void)saveComment:(NSDictionary*)dict
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",self.baseURL, @"check/sns/addComment"];
    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    [self doPostAndParseWithURL:urlStr data:bodyData];
}

- (void)clickPraise:(NSDictionary*)dict
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",self.baseURL, @"check/sns/clickPraise"];
    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    [self doPostAndParseWithURL:urlStr data:bodyData];
}

- (void)saveAndForward:(NSDictionary*)dict
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",self.baseURL, @"check/sns/addForward"];
    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    [self doPostAndParseWithURL:urlStr data:bodyData];
}

- (NSArray*)productList:(NSDictionary*)dict
{
    NSMutableString *urlStr = [[NSMutableString alloc] initWithString:self.baseURL];
    [urlStr appendString:@"check/param/product/list"];
    [urlStr appendString:[self constructQueryParamStr:dict]];
    
    NSDictionary *retDict = [self doRequestAndParseWithURL:urlStr];
    
    if (!retDict)
    {
        return nil;
    }
    
    return [retDict objectForKey:@"data"];
}

- (NSArray*)appealList:(NSDictionary*)dict
{
    NSMutableString *urlStr = [[NSMutableString alloc] initWithString:self.baseURL];
    [urlStr appendString:@"check/param/appeal/list"];
    [urlStr appendString:[self constructQueryParamStr:dict]];
    
    NSDictionary *retDict = [self doRequestAndParseWithURL:urlStr];
    
    if (!retDict)
    {
        return nil;
    }
    
    return [retDict objectForKey:@"data"];
}

- (NSInteger)userIdeasRemainderNumber:(NSDictionary*)dict
{
    NSMutableString *urlStr = [[NSMutableString alloc] initWithString:self.baseURL];
    [urlStr appendString:@"idea/userIdeasRemaining"];
    [urlStr appendString:[self constructQueryParamStr:dict]];
    
    NSDictionary *retDict = [self doRequestAndParseWithURL:urlStr];
    
    if (!retDict)
    {
        return 0;
    }
    
    return [[retDict objectForKey:@"data"] integerValue];
}

//Common
- (NSString *)constructQueryParamStr:(NSDictionary *)criteria
{
    NSMutableString *paramStr = [[NSMutableString alloc]init];
    [paramStr appendString:@"?"];
    
    NSArray *allKeys = [criteria allKeys];
    NSInteger index = 0;
    for(NSString *key in allKeys)
    {
        [paramStr appendString:key];
        [paramStr appendString:@"="];
        [paramStr appendString:[NSString stringWithFormat:@"%@",[criteria objectForKey:key]]];
        
        if(index++!=allKeys.count-1)
        {
            [paramStr appendString:@"&"];
        }
    }
    
    NSString *retStr = [paramStr stringByAppendingString:@""];
    retStr = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)retStr, NULL, CFSTR("!*'();:@+$,/%#[]\" "),kCFStringEncodingUTF8));
    return retStr;
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
        NSString *authStr = [NSString stringWithFormat:@"%@:%@", self.user.nickName,self.user.token];
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
    NSInteger codeValue = [[retObj objectForKey:@"code"] integerValue];
    if(retObj==nil || codeValue == 0 != YES)
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
        NSString *authStr = [NSString stringWithFormat:@"%@:%@", self.user.nickName,self.user.token];
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
    NSInteger codeValue = [[retObj objectForKey:@"code"] integerValue];
    if(retObj==nil || codeValue == 0 != YES)
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
        NSString *authStr = [NSString stringWithFormat:@"%@:%@", self.user.nickName,self.user.token];
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

- (User*)realNameAuth:(NSData*)data
{
    NSString *boundry=@"------";
    
    NSMutableString *urlstring = [[NSMutableString alloc] initWithString:self.baseURL];
    [urlstring appendString:@"check/realNameAuth"];
    
    NSString  *contentType=[NSString  stringWithFormat:@"multipart/form-data;boundary=%@" ,boundry];
    NSMutableURLRequest  *request=[[NSMutableURLRequest alloc] init] ;
    [request  setURL: [NSURL URLWithString:urlstring]];
    [request  setHTTPMethod:@"POST" ];
    [request  addValue:contentType forHTTPHeaderField:@"Content-Type" ];
    
    NSMutableData  *body=[NSMutableData  data];
    NSMutableString *str=[[NSMutableString alloc] init];
    
    NSMutableString *bodyContent = [NSMutableString string];
    
    if(self.user && [request valueForHTTPHeaderField:@"Auth"] ==nil)
    {
        NSString *authStr = [NSString stringWithFormat:@"%@:%@", self.user.nickName,self.user.token];
        NSString *encodedAuthStr = [[authStr dataUsingEncoding:NSUTF8StringEncoding] base64EncodedString];
        [request setValue:encodedAuthStr forHTTPHeaderField:@"Auth"];
    }
    
    [bodyContent appendFormat:@"--%@--\r\n",boundry];
    [body appendData:[str  dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString  stringWithFormat:@"\r\n--%@\r\n" ,boundry] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSString *str_imgname=[self getnowtime:@"yyyyMMddHHmmss"];
    [body appendData:[[NSString	stringWithFormat: @"Content-Disposition:form-data; name=\"cert\"; filename=\"%@.jpg\"\r\nContent-Type:application/octet-stream\r\nContent-Transfer-Encoding: binary\r\n\r\n",str_imgname] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData  dataWithData:data]];
    [body appendData:[[NSString	stringWithFormat:@"\r\n--%@--\r\n" ,boundry] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setHTTPBody:body];
    
    NSURLResponse  *response;
    NSError *err;
    NSData *returnData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    
    NSDictionary *mdic = [NSJSONSerialization JSONObjectWithData:returnData options:NSJSONReadingMutableContainers error:&err];
    
    self.code = [mdic objectForKey:@"code"];
    self.msg = [mdic objectForKey:@"msg"];
    
    User* user = [[User alloc] initWithDict:[mdic objectForKey:@"data"]];
    if (user)
    {
        self.user = user;
    }
    
    return user;
}

-(User*)newUserHaveIcon:(NSData *)data1 paramArr:(NSDictionary *)mparamArr
{
    NSString *boundry=@"------";
    
    NSMutableString *urlstring = [[NSMutableString alloc] initWithString:self.baseURL];
    [urlstring appendString:@"registerIcon"];

    NSString  *contentType=[NSString  stringWithFormat:@"multipart/form-data;boundary=%@" ,boundry];
    NSMutableURLRequest  *request=[[NSMutableURLRequest alloc] init] ;
    [request  setURL: [NSURL URLWithString:urlstring]];
    [request  setHTTPMethod:@"POST" ];
    [request  addValue:contentType forHTTPHeaderField:@"Content-Type" ];
    NSMutableData  *body=[NSMutableData  data];
    NSMutableString *str=[[NSMutableString alloc] init];
    
    NSMutableString *bodyContent = [NSMutableString string];
    
    for(NSString *key in mparamArr.allKeys)
    {
        id value = [mparamArr objectForKey:key];
        [str appendFormat:@"--%@\r\n",boundry];
        [str appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",key];
        [str appendFormat:@"%@\r\n",value];
    }
    
    [bodyContent appendFormat:@"--%@--\r\n",boundry];
    [body appendData:[str  dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString  stringWithFormat:@"\r\n--%@\r\n" ,boundry] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSString *str_imgname=[self getnowtime:@"yyyyMMddHHmmss"];
    [body appendData:[[NSString	stringWithFormat: @"Content-Disposition:form-data; name=\"icon\"; filename=\"%@.jpg\"\r\nContent-Type:application/octet-stream\r\nContent-Transfer-Encoding: binary\r\n\r\n",str_imgname] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData  dataWithData:data1]];
    [body appendData:[[NSString	stringWithFormat:@"\r\n--%@--\r\n" ,boundry] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setHTTPBody:body];

    NSURLResponse  *response;
    NSError *err;
    NSData *returnData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    
    NSDictionary *mdic = [NSJSONSerialization JSONObjectWithData:returnData options:NSJSONReadingMutableContainers error:&err];
    
    self.code = [mdic objectForKey:@"code"];
    self.msg = [mdic objectForKey:@"msg"];
    
    User* user = [[User alloc] initWithDict:[mdic objectForKey:@"data"]];
    if(user)
    {
        self.user = user;
    }
    return user;
}

-(NSString *)getnowtime:(NSString *)mstr
{
    NSDate* date = [NSDate date];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:mstr];
    NSString* str = [formatter stringFromDate:date];
    return str ;
}

- (void)logIdeaViewed:(NSDictionary*)dict
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",self.baseURL, @"check/idea/logIdeaViewed"];
    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    [self doPostAndParseWithURL:urlStr data:bodyData];
}

- (NSDictionary*)hasIdeaBeenUsed:(NSDictionary*)dict
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",self.baseURL, @"check/idea/hasIdeaBeenUsed"];
    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSDictionary* IdeaDict = [self doPostAndParseWithURL:urlStr data:bodyData];
    
    if (!IdeaDict)
    {
        return nil;
    }
    
    return [IdeaDict objectForKey:@"data"];
}



- (NSDictionary*)postFeedBackurl:(NSDictionary*)dict
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",self.baseURL, @"check/suggestion/add"];
    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSDictionary* IdeaDict = [self doPostAndParseWithURL:urlStr data:bodyData];
    
    if (!IdeaDict)
    {
        return nil;
    }
    
    return IdeaDict;
}
@end
