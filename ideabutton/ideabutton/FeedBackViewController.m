//
//  FeedBackViewController.m
//  jintiApp
//
//  Created by jintimac on 13-1-11.
//  Copyright (c) 2013年 jintimac. All rights reserved.
//

#import "FeedBackViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface FeedBackViewController ()<UITextFieldDelegate>

@end

@implementation FeedBackViewController




- (void)viewDidLoad
{
    [super viewDidLoad];
	self.title=@"意见反馈";
    //--
   
   [self setrightbaritem_imgname:@"icon_more_all.png" title:@""];
    //--
    
    txtfeedback=[[UITextView alloc]init];
    txtfeedback.frame=CGRectMake(5+5, 5+5, 310-10, 100);

    txtfeedback.font=[UIFont fontWithName:@"Arial" size:16];
    [txtfeedback.layer setBackgroundColor:[[UIColor whiteColor] CGColor]];
	[txtfeedback.layer setBorderColor: [[UIColor grayColor] CGColor]];
	[txtfeedback.layer setBorderWidth: 1.0];
	[txtfeedback.layer setCornerRadius:8.0f];
	[txtfeedback.layer setMasksToBounds:YES];
    txtfeedback.textColor=[UIColor whiteColor];
   // [txtfeedback becomeFirstResponder];
    txtfeedback.backgroundColor=[UIColor clearColor];
    txtfeedback.delegate=self;
    [self.view addSubview:txtfeedback];
    //-------
  
    txtcontact=[[UITextField alloc]initWithFrame:CGRectMake(5+5, 110+8, 310-10, 30)];
    txtcontact.textColor=[UIColor whiteColor];
    txtcontact.clearButtonMode=UITextFieldViewModeWhileEditing;
    txtcontact.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入你的手机/邮箱/qq(选填)" attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
    txtcontact.font=[UIFont fontWithName:@"Arial" size:16];
    txtcontact.backgroundColor=[UIColor clearColor];
    txtcontact.textAlignment=NSTextAlignmentLeft;
  
    [txtcontact.layer setBorderColor: [[UIColor grayColor] CGColor]];
    [txtcontact.layer setBorderWidth: 1.0];
    [txtcontact.layer setCornerRadius:8.0f];
    [txtcontact.layer setMasksToBounds:YES];
    
    [txtcontact setBorderStyle:UITextBorderStyleRoundedRect];
    [self.view addSubview:txtcontact];
    //----
    lbldesc=[[UILabel alloc]initWithFrame:CGRectMake(13, 10, 300, 30)];
    lbldesc.text=@"我的建议，请考虑一下:.....";
    lbldesc.backgroundColor=[UIColor clearColor];
    lbldesc.textColor=[UIColor lightGrayColor];
    [self.view addSubview:lbldesc];
    //----
    float y=txtcontact.frame.origin.y+txtcontact.frame.size.height+30;
    
    
    UIButton *btncommit = [UIButton buttonWithType:UIButtonTypeCustom];
    btncommit.frame = CGRectMake((kMainScreenBoundwidth-70)/2, y  , 70, 70);
    [btncommit setBackgroundImage:[UIImage imageNamed:@"all_btn_qd.png"] forState:UIControlStateNormal];
    [btncommit addTarget:self action:@selector(btncommitAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btncommit];
    
}
-(void)btnright
{
    [self showMenuView];
    
}
-(void)btncommitAction
{
    NSLog(@"aaa");
}
-(void)textViewDidChange:(UITextView *)textView
{
    if(textView.text == nil || [textView.text isEqualToString:@""])
    {
        lbldesc.hidden=NO;
    }
    else
    {
        lbldesc.hidden=YES;
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
