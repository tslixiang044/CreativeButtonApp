//
//  UploadViewController.m
//  ideabutton
//
//  Created by Li Xiang on 15/4/13.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import "UploadViewController.h"
#import "UIImage+UIImageScale.h"
#import "SVProgressHUD.h"
#import "API.h"
#import "RegisterSuccessView.h"
#import "IAlsoPressViewController.h"
#import "DB.h"
#import "APLevelDB.h"

@interface UploadViewController ()<UIGestureRecognizerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,RegisterSuccessViewDelegate>
{
    UIImageView* pictureImage;
    NSInteger   remainderNum;
}

@property(nonatomic,strong)UIImage *image;

@end

@implementation UploadViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = kgettitle;
    
    [self setrightbaritem_imgname:@"icon_more_all" title:nil];
    
    [self getRemainderNum];
    
    [self createInputView];
}

-(void) createInputView
{
    UIImageView* backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 50, 300, 330)];
    backgroundView.userInteractionEnabled = YES;
    backgroundView.backgroundColor = COLOR(21, 21, 22);
    [self.view addSubview:backgroundView];
    
    UILabel* titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 20, 80, 20)];
    titleLabel.text = @"实名认证";
    titleLabel.textColor = [UIColor whiteColor];
    [backgroundView addSubview:titleLabel];
    
    float y = titleLabel.frame.origin.y + titleLabel.frame.size.height + 30;
    
    pictureImage = [[UIImageView alloc] initWithFrame:CGRectMake(30,  y, 240, 90)];
    [pictureImage setImage:[UIImage imageNamed:@"btn_add"]];
    pictureImage.userInteractionEnabled = YES;
    pictureImage.layer.cornerRadius = 5;
    
    UITapGestureRecognizer *singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setImageView:)];
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    [pictureImage addGestureRecognizer:singleRecognizer];
    
    [backgroundView addSubview:pictureImage];
    
    float x = pictureImage.frame.origin.x + 30;
    y = pictureImage.frame.origin.y + pictureImage.frame.size.height + 5;
    
    UILabel* noticelabel = [[UILabel alloc] initWithFrame:CGRectMake(x , y, 220, 20)];
    noticelabel.text = @"上传学生证有效信息页照片或复印件";
    noticelabel.font = [UIFont systemFontOfSize:12];
    noticelabel.textColor = [UIColor grayColor];
    [backgroundView addSubview:noticelabel];
    
    y = noticelabel.frame.origin.y + noticelabel.frame.size.height + 30;
    
    UIImageView* line = [[UIImageView alloc] initWithFrame:CGRectMake(0, y, 300, 3)];
    [line setImage:[UIImage imageNamed:@"public/line"]];
    [backgroundView addSubview:line];
    
    y = line.frame.origin.y + line.frame.size.height + 30;
    
    UIButton* doneBtn = [[UIButton alloc] initWithFrame:CGRectMake(120, y, 60, 60)];
    [doneBtn setImage:[UIImage imageNamed:@"register/btn_ok"] forState:UIControlStateNormal];
    [doneBtn addTarget:self action:@selector(uploadPicture) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:doneBtn];
}

-(void)setImageView:(UIPinchGestureRecognizer*)pinchGestureRecognizer
{
    UIActionSheet *sheet=[[UIActionSheet alloc]initWithTitle:@"上传图像" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil ];
    
    [sheet addButtonWithTitle:@"相册"];
    [sheet addButtonWithTitle:@"拍照"];
    
    [sheet addButtonWithTitle:@"取消"];
    
    sheet.cancelButtonIndex=sheet.numberOfButtons-1;
    
    [sheet showInView:[UIApplication sharedApplication].keyWindow];
}

-(void)btnright
{
    [self showMenuView];
}

-(void)uploadPicture
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    dispatch_queue_t currentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(currentQueue, ^{
        //后台处理代码, 一般 http 请求在这里发, 然后阻塞等待返回, 收到返回处理
        NSData *imagesmallData1 = nil;
        if(self.image!=nil)
        {
            imagesmallData1 = UIImageJPEGRepresentation(self.image,0.1f);
        }
        User* user = [[API sharedInstance]realNameAuth:imagesmallData1];
        //处理完上面的后回到主线程去更新UI
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        dispatch_async(mainQueue, ^{
            
            if ([API sharedInstance].code.integerValue == 0)
            {
                [SVProgressHUD dismiss];
                
                DB *db = [DB sharedInstance];
                [db saveUser:user];
                [db.indb setData:[user.nickName dataUsingEncoding:NSUTF8StringEncoding] forKey:@"ctrler:login:last-login-name"];
                
                RegisterSuccessView *suc=[[RegisterSuccessView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenBoundwidth, kMainScreenBoundheight) Flag:3];
                suc.delegate = self;
                
                [[UIApplication sharedApplication].keyWindow addSubview:suc];
            }
            else
            {
                [SVProgressHUD showErrorWithStatus:[API sharedInstance].msg];
            }
        });
    });
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)
    {
        UIImagePickerController *picker=[[UIImagePickerController alloc] init];
        picker.delegate=self;
        
        picker.allowsEditing=YES;
        
        
        picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:picker animated:YES completion:nil];
    }
    else if(buttonIndex==1)
    {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        {
            UIImagePickerController *picker=[[UIImagePickerController alloc] init];
            picker.delegate=self;
            picker.allowsEditing=YES;
            picker.sourceType=UIImagePickerControllerSourceTypeCamera;
            
            [self presentViewController:picker animated:YES completion:nil];
        }
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker  didFinishPickingImage:(UIImage  *)image
                 editingInfo:(NSDictionary *)editinginfo
{
    //------------------------------------
    self.image=[image rotateImage:image];
    [pictureImage setImage:self.image];
    //------------------------------------
    [picker dismissModalViewControllerAnimated:YES];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)start
{
    if (remainderNum == 0)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else
    {
        IAlsoPressViewController *press=[[IAlsoPressViewController alloc]init];
        [self.navigationController pushViewController:press animated:YES];
    }
}

-(void)perfectInfo
{
    
}

-(void)uploadData
{
    
}


-(void)getRemainderNum
{
    User* user = [[DB sharedInstance]queryUser];
    if (user)
    {
        dispatch_queue_t currentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(currentQueue, ^{
            //后台处理代码, 一般 http 请求在这里发, 然后阻塞等待返回, 收到返回处理
            remainderNum = [[API sharedInstance]userIdeasRemainderNumber:@{@"userCode":[NSString stringWithFormat:@"%d",user.userCode]}];
            //处理完上面的后回到主线程去更新UI
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            dispatch_async(mainQueue, ^{
                
            });
        });
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
