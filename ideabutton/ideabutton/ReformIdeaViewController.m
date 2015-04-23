//
//  ReformIdeaViewController.m
//  ideabutton
//
//  Created by Li Xiang on 15/3/3.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReformIdeaViewController.h"
#import "API.h"
#import "SVProgressHUD.h"

#define SaveBtnTag    0
#define CancelBtnTag    1

@interface ReformIdeaViewController() <UITextViewDelegate>
{
    UITextView* sentenceTextView;
    NSString* userOccupyId;
    NSString* userCollectId;
    NSString* newSentence;
}

@property(nonatomic, strong)NSDictionary* dict;
@property(nonatomic, assign)BOOL agreementChecked;
@property(nonatomic, assign)NSInteger   type;

@end


@implementation ReformIdeaViewController

-(id)initWithDict:(NSDictionary*)dict Type:(NSInteger)type
{
    self = [super init];
    if (self)
    {
        self.dict = dict;
        self.agreementChecked = NO;
        self.type = type;
        userOccupyId = @"";
        userCollectId = @"";
        newSentence = @"";
        
        if ([self.dict objectForKey:@"shared"])
        {
            if ([[self.dict objectForKey:@"shared"] integerValue] == 0)
            {
                self.agreementChecked = YES;
            }
        }
        
        if ([[self.dict objectForKey:@"occupyId"] integerValue] > 0)
        {
            userOccupyId = [self.dict objectForKey:@"occupyId"];
        }
        
        if ([[self.dict objectForKey:@"collectID"] integerValue] > 0)
        {
            userCollectId = [self.dict objectForKey:@"collectID"];
        }
    }
    
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = kgettitle;
    
    [self setrightbaritem_imgname:@"icon_more_all" title:nil];
    
    [self createInputView];
}

-(void)btnright
{
    [self showMenuView];
}

-(void)createInputView
{
    NSString* titleStr = @"";
    
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, 280, 120)];
    titleLabel.layer.borderColor = [[UIColor grayColor] CGColor];
    titleLabel.layer.borderWidth = 1;
    titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    titleLabel.numberOfLines = 0;
    
    if (self.type == 1)
    {
        titleStr = [NSString stringWithFormat:@"#霸占宣言#我宣布,我刚刚霸占了一条%@广告,谁也别想再碰!\n\n\n  ",[self.dict objectForKey:@"product"]];
    }
    else
    {
        titleStr = [NSString stringWithFormat:@"#改造声明#我宣布,我刚刚改造了一条%@广告,谁也别想再碰!\n\n\n  ",[self.dict objectForKey:@"product"]];
    }
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:titleStr];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,6)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(6,str.length - 7)];
    titleLabel.attributedText = str;
    
    [self.view addSubview:titleLabel];
    
    UIImageView* backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 185, 280, 260)];
    [backgroundView setBackgroundColor:COLOR(21, 21, 22)];
    backgroundView.userInteractionEnabled = YES;
    [self.view addSubview:backgroundView];
    
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 90, 90)];
    [imageView setImage:[UIImage imageNamed:@"logo_anniu"]];
    [backgroundView addSubview:imageView];
    
    sentenceTextView = [[UITextView alloc] initWithFrame:CGRectMake(110, 10, 160, 90)];
    [sentenceTextView setBackgroundColor:[UIColor blackColor]];
    sentenceTextView.delegate = self;
    sentenceTextView.layer.borderColor = [[UIColor grayColor] CGColor];
    sentenceTextView.layer.borderWidth = 1;
    sentenceTextView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    sentenceTextView.text = [self.dict objectForKey:@"sentence"];
    if (self.agreementChecked)
    {
        NSString* textStr = [sentenceTextView.text substringFromIndex:sentenceTextView.text.length - 6];
        NSString* subStr = [sentenceTextView.text stringByReplacingCharactersInRange:NSMakeRange(3,sentenceTextView.text.length - 3) withString:@"*********"];
        sentenceTextView.text = [subStr stringByAppendingString:textStr];
    }

    sentenceTextView.textColor = [UIColor whiteColor];
    sentenceTextView.font = [UIFont systemFontOfSize:15];
    sentenceTextView.returnKeyType = UIReturnKeyDone;
    [backgroundView addSubview:sentenceTextView];
    
    UIButton *checkboxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    checkboxBtn.frame = CGRectMake(50, 115, 20, 20);
    if (!self.agreementChecked)
    {
        [checkboxBtn setImage:[UIImage imageNamed:@"login/checkbox-unchecked"] forState:UIControlStateNormal];
        [checkboxBtn addTarget:self action:@selector(checkboxClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        [checkboxBtn setImage:[UIImage imageNamed:@"login/checkbox-checked"] forState:UIControlStateNormal];
        [checkboxBtn addTarget:self action:@selector(checkboxClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    [backgroundView addSubview:checkboxBtn];
    
    UILabel* hiddenLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 115, 150, 20)];
    hiddenLabel.text = @"隐藏并30天后显示";
    hiddenLabel.textColor = [UIColor whiteColor];
    [backgroundView addSubview:hiddenLabel];
    
    UIImageView* line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 150, 280, 5)];
    [line setImage:[UIImage imageNamed:@"public/line"]];
    [backgroundView addSubview:line];
    
    UIButton* shareBtn = [[UIButton alloc] initWithFrame:CGRectMake(90, 160, 100, 100)];
    [shareBtn setImage:[UIImage imageNamed:@"btn_bzfx"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(shareIdea) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:shareBtn];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        newSentence = textView.text;
        
        return NO;
    }
    
    return YES;
}


- (void)checkboxClicked:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    if(self.agreementChecked)
    {
        if (newSentence.length > 0)
        {
            sentenceTextView.text = newSentence;
        }
        else
        {
            sentenceTextView.text = [self.dict objectForKey:@"sentence"];
        }
        
        [btn setImage:[UIImage imageNamed:@"login/checkbox-unchecked"] forState:UIControlStateNormal];
        self.agreementChecked = NO;
    }
    else
    {
        newSentence = sentenceTextView.text;
        NSString* textStr = [sentenceTextView.text substringFromIndex:sentenceTextView.text.length - 6];
        NSString* subStr = [sentenceTextView.text stringByReplacingCharactersInRange:NSMakeRange(3,sentenceTextView.text.length - 3) withString:@"*********"];
        sentenceTextView.text = [subStr stringByAppendingString:textStr];
        [btn setImage:[UIImage imageNamed:@"login/checkbox-checked"] forState:UIControlStateNormal];
        self.agreementChecked = YES;
    }
}

- (void)shareIdea
{
    if (newSentence.length == 0)
    {
        newSentence = [self.dict objectForKey:@"sentence"];
    }
    
    if (self.type == 1)
    {
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        dispatch_queue_t currentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(currentQueue, ^{
            //后台处理代码, 一般 http 请求在这里发, 然后阻塞等待返回, 收到返回处理
            NSString* occupyID = [[API sharedInstance] occupyIdea:@{@"algorithmRule":[self.dict objectForKey:@"algorithmRule"],
                                                                    @"sentence":[self.dict objectForKey:@"sentence"],
                                                                    @"adtype":[self.dict objectForKey:@"adtype"],
                                                                    @"product":[self.dict objectForKey:@"product"],
                                                                    @"share":@(!self.agreementChecked)}];
            //处理完上面的后回到主线程去更新UI
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            dispatch_async(mainQueue, ^{
                
                if ([API sharedInstance].code.integerValue == 0)
                {
                    [SVProgressHUD showSuccessWithStatus:@"你今天可霸占3条idea!"];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"reformIdeaSuccess" object:nil userInfo:@{@"occupyID":occupyID}];
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else
                {
                    [SVProgressHUD showErrorWithStatus:[API sharedInstance].msg];
                }
            });
        });
    }
    else if(self.type == 2)
    {
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        dispatch_queue_t currentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(currentQueue, ^{
            
            //后台处理代码, 一般 http 请求在这里发, 然后阻塞等待返回, 收到返回处理
            [[API sharedInstance] reformIdea:@{@"type":[self.dict objectForKey:@"type"],
                                                                    @"userOccupyId":userOccupyId,
                                                                    @"userCollectId":userCollectId,
                                                                    @"algorithmRule":[self.dict objectForKey:@"algorithmRule"],
                                                                    @"reformedSentence":newSentence,
                                                                    @"sentence":[self.dict objectForKey:@"sentence"],
                                                                    @"adtype":[self.dict objectForKey:@"adtype"],
                                                                    @"product":[self.dict objectForKey:@"product"],
                                                                    @"share":@(!self.agreementChecked)}];
            //处理完上面的后回到主线程去更新UI
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            dispatch_async(mainQueue, ^{
                
                if ([API sharedInstance].code.integerValue == 0)
                {
                    [SVProgressHUD showSuccessWithStatus:@"改造即为霸占,今天仅剩三条!"];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"reformIdeaSuccess" object:nil];
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else
                {
                    [SVProgressHUD showErrorWithStatus:[API sharedInstance].msg];
                }
            });
        });
    }
    else
    {
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        dispatch_queue_t currentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(currentQueue, ^{
            //后台处理代码, 一般 http 请求在这里发, 然后阻塞等待返回, 收到返回处理
            [[API sharedInstance] updateReformedIdea:@{@"userReformId":[self.dict objectForKey:@"userReformId"],
                                               @"reformedSentence":newSentence,
                                               @"adtype":[self.dict objectForKey:@"adType"],
                                               @"product":@"product"}];
            //处理完上面的后回到主线程去更新UI
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            dispatch_async(mainQueue, ^{
                
                if ([API sharedInstance].code.integerValue == 0)
                {
                    [SVProgressHUD showSuccessWithStatus:@"改造成功!"];
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else
                {
                    [SVProgressHUD showErrorWithStatus:[API sharedInstance].msg];
                }
            });
        });
    }
}
@end
