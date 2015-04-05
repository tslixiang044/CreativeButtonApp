//
//  Global.h
//  ideabutton
//
//  Created by Jian Hu on 15-2-6.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Config.h"
#import "ASIFormDataRequest.h"
#import "ASINetworkQueue.h"

//-------------------------------------------------delegate
@protocol Globaldelegate <NSObject>

@optional
-(void)uploadfinished_global:(NSData *)responseData key:(NSString *)mkey ;
-(void)uploadfaild_global:(NSString *)mkey;
//----
-(void)uploadfinished_post_global:(NSString *)resultStr key:(NSString *)mkey;
-(void)uploadfaild_post_global:(NSString *)mkey;

@end
//-------------------------------------------------



@interface Global : NSObject
{
    ASINetworkQueue *netWorkQueue;
}
@property(assign)id<Globaldelegate>delegate;

+(Global *)getInstanse;
-(void)getHttpRequest_url:(NSString *)murlstr  key:(NSString *)mkey delegate:(id)mdelegate;
-(void)postHttprequest_urlstr:(NSString *)urlstr dic:(NSMutableDictionary *)mdic imgdata:(NSMutableDictionary*)mimgdatadic key :(NSString *)mkey  delegate:(id)mdelegate;

-(void)cancerAllRequest;
-(void)cancerRequest_key:(NSString *)mkey;
+(NSDictionary*)GetdicwithData:(NSData*)mdata;

+(NSString*) encodedUrlString:(NSString *)str;
+(NSString *)deEncodedUrlString:(NSString *)str;

+(BOOL)CheckisFirst:(NSString *)str_check_key;
+(void)setisfirstFalse:(NSString *)str_check_key;


@end
