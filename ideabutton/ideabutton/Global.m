//
//  Global.m
//  ideabutton
//
//  Created by Jian Hu on 15-2-6.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import "Global.h"

@implementation Global


@synthesize delegate;






static Global *mglobal;

+(Global *)getInstanse
{
    @synchronized(self)
    {
        if(!mglobal)
        {
            mglobal=[[Global alloc]init];
            
        }
        return mglobal;
    }
    
}
//---------------------------------------
-(void)getHttpRequest_url:(NSString *)murlstr  key:(NSString *)mkey delegate:(id)mdelegate
{
    @try
    {
        [self cancerallrequest:mkey];
        
        self.delegate=mdelegate;
        //-----------------------------
        NSLog(@"开始请求=%@",murlstr);
        //--------------------------
        if(netWorkQueue==nil)
        {
            netWorkQueue=[[ASINetworkQueue alloc]init];
            [netWorkQueue reset];
            [netWorkQueue setShowAccurateProgress:NO];
        }
        NSURL *murl=  [[NSURL alloc] initWithString:murlstr];
        ASIHTTPRequest *mrequest = [[ASIHTTPRequest alloc] initWithURL:murl];
        [mrequest setDelegate:self];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [mrequest setTimeOutSeconds:20];
        [mrequest setDidFinishSelector:@selector(uploadfinished:)];
        [mrequest setDidFailSelector:@selector(uploadfailed:)];
        mrequest.username=mkey;
        [netWorkQueue addOperation:mrequest];

        [netWorkQueue go];

    }
    @catch (NSException *exception)
    {
        NSLog(@"异常错误是:%@", exception);
    }
    @finally
    {
        
    }
}
- (void)uploadfinished:(ASIHTTPRequest *)request
{
    NSLog(@"请求成功:%@",request.username);

    NSData *myResponseData=[request responseData];
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingUTF8);
    NSString *myRespoonseStr=[[NSString alloc]initWithData:myResponseData encoding:enc ] ;
    
    //NSLog(@"responseStr=%@",myRespoonseStr);
    
    
    if(delegate)
    {
        [delegate  uploadfinished_global:myRespoonseStr key:request.username];
    }
}

- (void)uploadfailed:(ASIHTTPRequest *)request
{
    NSLog(@"请求失败:%@",request.username);
    if(delegate)
    {
        [delegate uploadfaild_global:request.username];
    }
}
//--------------------------------------------------------------------

-(void)postHttprequest_urlstr:(NSString *)urlstr dic:(NSMutableDictionary *)mdic imgdata:(NSMutableDictionary*)mimgdatadic key :(NSString *)mkey  delegate:(id)mdelegate
{
    self.delegate=mdelegate;
    NSLog(@"post开始请求=%@",urlstr);
    
    [self cancerallrequest:mkey];
    
    NSURL *murl=[[NSURL alloc]initWithString:urlstr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:murl];
   
    
    
    
    NSArray *keyarr=[mdic allKeys];
    for(int i=0;i<[keyarr count];i++)
    {
        NSString *key=[keyarr objectAtIndex:i];
        NSString *value=[mdic valueForKey:key];
        NSLog(@"key=%@     value=%@",key,value);
        if(key && value)
        {
            [request setPostValue:value forKey:key];
        }
    }
    
    NSArray *keyarr_img=[mimgdatadic allKeys];
    for(int i=0;i<[mimgdatadic count];i++)
    {
        NSString *key=[keyarr_img objectAtIndex:i];
        NSData *value=[mimgdatadic valueForKey:key];
        if(key && value)
        {
            if(value!=nil)
            {
                [request setData:value forKey:key];
            }
            
        }
    }
    
    
    request.timeOutSeconds = 20;
    request.username=mkey;
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(uploadfinished_post:)];
    [request setDidFailSelector:@selector(uploadfailed_post:)];
    [request startAsynchronous];
    
}
- (void)uploadfinished_post:(ASIHTTPRequest *)request
{
   
    NSLog(@"post请求成功:%@",request.username);
    NSData *myResponseData=[request responseData];
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingUTF8);
    
    NSString *myRespoonseStr= [[NSString alloc]initWithData:myResponseData encoding:enc ]  ;
    
    //NSLog(@"str=%@",myRespoonseStr);
    if(delegate)
    {
        [delegate  uploadfinished_global:myRespoonseStr key:request.username];
    }
}
- (void)uploadfailed_post:(ASIHTTPRequest *)request
{
   
    NSLog(@"post请求失败:%@",request.username);
   
    if(delegate)
    {
        if (request)
        {
            if (request.username)
            {
                if ([delegate respondsToSelector:@selector(uploadfaild_post_global:)])
                {
                    [delegate uploadfaild_post_global:request.username];
                }
                
                
            }
        }
    }
}

//--------------

-(void)cancerallrequest
{
    int i=0;
    for(ASIHTTPRequest *request in [netWorkQueue operations])
    {
        [request clearDelegatesAndCancel];
        i++;
    }
    if(i>0)
    {
        NSLog(@"请求已取消");
    }
}
-(void)cancerallrequest:(NSString *)mkey
{
    int i=0;
    
    for(ASIHTTPRequest *request in [netWorkQueue operations])
    {
        if([request.username isEqualToString:mkey])
        {
            [request clearDelegatesAndCancel];
            i++;
        }
        
    }
    if(i>0)
    {
        NSLog(@"请求已取消  %@",mkey);
    }
}







@end
