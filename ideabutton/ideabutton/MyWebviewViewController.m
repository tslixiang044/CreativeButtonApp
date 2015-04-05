//
//  MyWebviewViewController.m
//  jintiApp
//
//  Created by jintimac on 12-12-18.
//  Copyright (c) 2012年 jintimac. All rights reserved.
//

#import "MyWebviewViewController.h"






//----
@interface MyWebviewViewController ()

@end

@implementation MyWebviewViewController


@synthesize urlstr,filename;




- (void)viewDidLoad
{
    [super viewDidLoad];
    //-------------------
  
    
    
}




-(void)setUrlstr:(NSString *)murlstr
{
    if(murlstr==nil)
    {
        return;
    }
    if(urlstr!=nil)
    {
      
        urlstr = nil;
    }
    urlstr=murlstr;

    mwebview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenBoundwidth,kMainScreenBoundheight-64)];
    mwebview.delegate = self;
    mwebview.scalesPageToFit=YES;
    
	[self.view addSubview:mwebview];
    //-----------------------

    //------------------------------------------------------------------
    NSMutableURLRequest *newRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstr]];
    [mwebview loadRequest:newRequest];
    //------------------------------------------------------------------
    


}

-(void)setFilename:(NSString *)mfilename
{
    if(mfilename==nil)
    {
        return;
    }
    if(filename!=nil)
    {
        
        filename = nil;
    }
    filename=mfilename;
    //--------------------------
    mwebview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenBoundwidth,kMainScreenBoundheight-64)];
    mwebview.delegate = self;
    mwebview.scalesPageToFit=YES;
    mwebview.backgroundColor=[UIColor clearColor];
    mwebview.opaque=0;
    [self.view addSubview:mwebview];
    
    

    //------------------------------------------------------------------
    NSString *filePath = [[NSBundle mainBundle]pathForResource:filename ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    [mwebview loadHTMLString:htmlString baseURL:[NSURL URLWithString:filePath]];
    
    
    
}


@end
