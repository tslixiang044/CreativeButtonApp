//
//  FeedBackViewController.m
//  jintiApp
//
//  Created by jintimac on 13-1-11.
//  Copyright (c) 2013年 jintimac. All rights reserved.
//

#import "FeedBackViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "API.h"
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
    txtfeedback.frame=CGRectMake(10, 10, 300, 150);
    
    txtfeedback.font=[UIFont fontWithName:@"Arial" size:16];
    [txtfeedback.layer setBackgroundColor:[[UIColor whiteColor] CGColor]];
    [txtfeedback.layer setBorderColor: [[UIColor grayColor] CGColor]];
    [txtfeedback.layer setBorderWidth: 1.0];
//    [txtfeedback.layer setCornerRadius:8.0f];
    [txtfeedback.layer setMasksToBounds:YES];
    txtfeedback.textColor=[UIColor whiteColor];
    // [txtfeedback becomeFirstResponder];
    txtfeedback.backgroundColor=[UIColor clearColor];
    txtfeedback.delegate=self;
    [self.view addSubview:txtfeedback];
    //-------
    
    UIImageView* backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 170, 300, 100)];
    backgroundView.backgroundColor = COLOR(21, 21, 22);
    [self.view addSubview:backgroundView];
    
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 50, 20)];
    titleLabel.text = @"联系方式";
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = [UIColor grayColor];
    [backgroundView addSubview:titleLabel];
    
    txtcontact=[[UITextField alloc]initWithFrame:CGRectMake(10, 110+8, 310-10, 30)];
    txtcontact.textColor=[UIColor whiteColor];
    txtcontact.clearButtonMode=UITextFieldViewModeWhileEditing;
    txtcontact.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入你的手机/邮箱/qq(选填)" attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
    txtcontact.font=[UIFont fontWithName:@"Arial" size:16];
    txtcontact.backgroundColor=[UIColor clearColor];
    txtcontact.textAlignment=NSTextAlignmentLeft;
    txtcontact.delegate = self;
    [txtcontact.layer setBorderColor: [[UIColor grayColor] CGColor]];
    [txtcontact.layer setBorderWidth: 1.0];
    [txtcontact.layer setCornerRadius:8.0f];
    [txtcontact.layer setMasksToBounds:YES];
    
    [txtcontact setBorderStyle:UITextBorderStyleRoundedRect];
    [self.view addSubview:txtcontact];
    //----
    lbldesc=[[UILabel alloc]initWithFrame:CGRectMake(13, 10, 300, 30)];
    lbldesc.text=@"我的建议，请考虑一下.....";
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
    NSString *str_content=[txtfeedback.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *str_phone=[txtcontact.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    CGRect frame = CGRectMake(90,380,150,20);
    
    if([str_content isEqualToString:@""])
    {
        [self showalertview_text:@"建议不能为空" frame:frame autoHiden:YES];
        return;
    }
    if([str_phone isEqualToString:@""])
    {
        [self showalertview_text:@"联系方式不能为空" frame:frame autoHiden:YES];
        return;
    }
    
    dispatch_queue_t currentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(currentQueue, ^{
        //后台处理代码, 一般 http 请求在这里发, 然后阻塞等待返回, 收到返回处理
        
        NSMutableDictionary *mdic=[[NSMutableDictionary alloc]init];
        [mdic setValue:str_content forKey:@"content"];
        [mdic setValue:str_phone forKey:@"contactWay"];
        
        NSDictionary *back_dic=[[API sharedInstance]postFeedBackurl:mdic];
        
        //处理完上面的后回到主线程去更新UI
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        dispatch_async(mainQueue, ^{
            
            NSInteger codeValue = [[back_dic objectForKey:@"code"] integerValue];
            if(codeValue==0)
            {
                [self showalertview_text:@"提交成功" frame:frame autoHiden:YES];
            }
            else
            {
                [self showalertview_text:@"提交失败" frame:frame autoHiden:YES];
            }
        });
    });
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

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        
        return NO;
    }
    
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
