//
//  ImageViewCell.m
//  WaterFlowViewDemo
//
//  Created by Smallsmall on 12-6-12.
//  Copyright (c) 2012年 activation group. All rights reserved.
//

#import "ImageViewCell.h"
#import "MyUILabel.h"


#define COLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define TOPMARGIN 8.0f
#define LEFTMARGIN 8.0f

#define IMAGEVIEWBG [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0]

@implementation ImageViewCell
@synthesize delegate;


-(void)dealloc
{
    [lblsource release];
    [lbltime release];
    [lblproduct release];
    [lbldesc release];
    [view_center release];
    [lblnickname release];
    [imgview_header release];
    [view_bg release];
    
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
    }
    return self;
}
-(void)handleSingleTapFrom:(UIPinchGestureRecognizer*)pinchGestureRecognizer
{
    
    if(delegate)
    {
        [delegate gotoviewcontroller_imageviewcell_usercode:imgview_header.tag];
    }
      
}
-(id)initWithIdentifier:(NSString *)indentifier
{
	if(self = [super initWithIdentifier:indentifier])
	{
        float x=5;
        float y=10;
        
        view_bg=[[UIView alloc]init];
        view_bg.backgroundColor=COLOR(28, 28, 29);
        [self addSubview:view_bg];
        view_bg.layer.cornerRadius = 10;//设置那个圆角的有多圆
        view_bg.layer.masksToBounds = YES;//设为NO去试试
        //--------------
        imgview_header=[[UIImageView alloc]initWithFrame:CGRectMake(x, y, 50, 50)];
        imgview_header.userInteractionEnabled=YES;
        [view_bg addSubview:imgview_header];
        
        CALayer *layer = [imgview_header layer];
        [layer setMasksToBounds:YES];
        CGFloat radius=imgview_header.frame.size.width/2; //设置圆角的半径为图片宽度的一半
        [layer setCornerRadius:radius];
        [layer setBorderWidth:2.0];//添加白色的边框
        
        UIColor *mcolor=COLOR(60, 60, 60);
        
        [layer setBorderColor:[mcolor CGColor]];

        UITapGestureRecognizer *singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapFrom:)];

        singleRecognizer.numberOfTapsRequired = 1; // 单击
        [imgview_header addGestureRecognizer:singleRecognizer];
        //--------------
         x=imgview_header.frame.origin.x+imgview_header.frame.size.width+5;
        lblnickname=[[UILabel alloc]initWithFrame:CGRectMake(x, y, 65, 30)];
        lblnickname.backgroundColor=[UIColor clearColor];
        lblnickname.font=[UIFont systemFontOfSize:12];
        lblnickname.textColor=COLOR(98, 98, 98);
        lblnickname.lineBreakMode = NSLineBreakByWordWrapping;
        lblnickname.numberOfLines = 0;
        
        [view_bg addSubview:lblnickname];
        
        sexImageView = [[UIImageView alloc] initWithFrame:CGRectMake(lblnickname.frame.origin.x + lblnickname.frame.size.width, y + 3, 20, 20)];
        [view_bg addSubview:sexImageView];
        //--------------
        
        y=lblnickname.frame.origin.y+lblnickname.frame.size.height;
        
        lblsource=[[UILabel alloc]initWithFrame:CGRectMake(x, y - 5, 100, 25)];
        lblsource.backgroundColor=[UIColor clearColor];
        lblsource.font=[UIFont systemFontOfSize:12];
        lblsource.textColor=COLOR(98, 98, 98);
        [view_bg addSubview:lblsource];
        //---------------
        y=imgview_header.frame.origin.y+imgview_header.frame.size.height+5;
        
        view_center=[[UIView alloc]initWithFrame:CGRectMake(0, y, 150, 100)];
        //view_center.backgroundColor=COLOR(124, 96, 33);
        [view_bg addSubview:view_center];
        //---------------
        x=10;
        y=5;
        
        lbldesc=[[UILabel alloc]initWithFrame:CGRectMake(x, y, 128, 40)];
        lbldesc.numberOfLines=0;
        lbldesc.textColor=[UIColor whiteColor];
        lbldesc.font=[UIFont systemFontOfSize:11];
        lbldesc.backgroundColor=[UIColor clearColor];
        [view_center addSubview:lbldesc];
        //---------------
        y=lbldesc.frame.origin.y+lbldesc.frame.size.height;
        lblproduct=[[UILabel alloc]initWithFrame:CGRectMake(x, y, 128, 35)];
        lblproduct.numberOfLines=0;
        lblproduct.textColor=[UIColor whiteColor];
        lblproduct.font=[UIFont systemFontOfSize:12.5];
        lblproduct.backgroundColor=[UIColor clearColor];
        [view_center addSubview:lblproduct];
        //---------------
        y=lblproduct.frame.origin.y+lblproduct.frame.size.height;
        lbltime=[[UILabel alloc]initWithFrame:CGRectMake(x, y, 128, 25)];
        lbltime.textAlignment=NSTextAlignmentRight;
        lbltime.textColor=[UIColor whiteColor];
        lbltime.font=[UIFont systemFontOfSize:12];
        lbltime.backgroundColor=[UIColor clearColor];
        [view_center addSubview:lbltime];
        //---------------
        x=5;
        y=view_center.frame.origin.y+view_center.frame.size.height+5;
        //--
        UIImageView *imgview_praise=[[UIImageView alloc]initWithFrame:CGRectMake(x, y+5, 15, 15)];
        imgview_praise.image=[UIImage imageNamed:@"icon_good"];
        [view_bg addSubview:imgview_praise];
        //--
        
        lblPraise=[[UILabel alloc]initWithFrame:CGRectMake(x+20, y, 40, 25)];
        lblPraise.textColor=[UIColor grayColor];
        lblPraise.font=[UIFont systemFontOfSize:12];
        lblPraise.backgroundColor=[UIColor clearColor];
        [view_bg addSubview:lblPraise];
        //--
        x=lblPraise.frame.origin.x+lblPraise.frame.size.width;

        UIImageView *imgview_comment=[[UIImageView alloc]initWithFrame:CGRectMake(x + 5, y + 5, 15, 15)];
        imgview_comment.image=[UIImage imageNamed:@"icon_talk"];
        [view_bg addSubview:imgview_comment];
        
        lblComments = [[UILabel alloc]initWithFrame:CGRectMake(x + 25, y, 50, 25)];
        lblComments.textColor = [UIColor grayColor];
        lblComments.font = [UIFont systemFontOfSize:12];
        lblComments.backgroundColor = [UIColor clearColor];
        [view_bg addSubview:lblComments];
        //--
	}
	
	return self;
}

-(void)setImageWithURL:(NSURL *)imageUrl
{
    //[imageView setImageWithURL:imageUrl];
}

-(void)setImage:(UIImage *)image
{
    //imageView.image = image;
}

-(void)setbtnObjct:(WaterFlowObj*)mobj
{
    lblnickname.text=mobj.nickname;
    
    if (mobj.gender.integerValue == 0)
    {
        [sexImageView setImage:[UIImage imageNamed:@"icon_women_on"]];
    }
    else
    {
        [sexImageView setImage:[UIImage imageNamed:@"icon_man"]];
    }
    
    NSURL *murl=[NSURL URLWithString:mobj.avatar];
    
    [imgview_header setImageWithURL:murl placeholderImage:[UIImage imageNamed:@"register_head"]];
    imgview_header.tag=[mobj.userCode intValue];
    
    
    
    if (mobj.ideaType.integerValue == 1)
    {
        lbldesc.text= [NSString stringWithFormat:@"我宣布,我刚刚霸占了一条%@广告,谁也别想再碰:",mobj.product];
    }
    else if (mobj.ideaType.integerValue == 2)
    {
        lbldesc.text= [NSString stringWithFormat:@"我宣布,我刚刚改造了一条%@广告,谁也别想再碰:",mobj.product];
    }
    else if (mobj.suggestionId)
    {
        lbldesc.text= @"我认真建议,请认真考虑一下:";
    }
    
    if (mobj.sentence.length > 0)
    {
        if (![mobj.shared boolValue])
        {
            NSString* textStr = [mobj.sentence substringFromIndex:mobj.sentence.length - 6];
            NSString* subStr = [mobj.sentence stringByReplacingCharactersInRange:NSMakeRange(3,mobj.sentence.length - 3) withString:@"*********"];
            lblproduct.text = [subStr stringByAppendingString:textStr];
        }
        else
        {
            lblproduct.text = mobj.sentence;
        }
    }
    else if (mobj.content.length > 0)
    {
        lblproduct.text = mobj.content;
    }
    
    lbltime.text=mobj.timeStamp;
    
    if (mobj.carrerType.integerValue == 0)
    {
        if (mobj.college.length > 0 && !mobj.collegePrivate.boolValue)
        {
            lblsource.text = [NSString stringWithFormat:@"%@",mobj.college];
        }
        else
        {
            lblsource.text = [NSString stringWithFormat:@"%@",mobj.city];
        }
    }
    else if (mobj.carrerType.integerValue == 2)
    {
        if (mobj.favCompany.length > 0 && !mobj.favCompanyPrivate.boolValue)
        {
            lblsource.text = [NSString stringWithFormat:@"%@",mobj.favCompany];
        }
        else
        {
            lblsource.text = [NSString stringWithFormat:@"%@",mobj.city];
        }
    }
    
    if (mobj.numberOfPraise.integerValue >= 100)
    {
        lblPraise.font = [UIFont systemFontOfSize:10];
    }
    
    if (mobj.comments.count >= 100)
    {
        lblComments.font = [UIFont systemFontOfSize:10];
    }
    lblPraise.text = [NSString stringWithFormat:@"%@次赞",mobj.numberOfPraise];
    lblForward.text = [NSString stringWithFormat:@"%@次转发",mobj.numberOfForward];
    lblComments.text = [NSString stringWithFormat:@"%lu条评论",(unsigned long)[mobj.comments count]];

    for(UIView *v in [view_bg subviews])
    {
        if([v isMemberOfClass:[MyUILabel class]])
        {
            [v removeFromSuperview];
        }
    }
    if (mobj.comments.count > 0)
    {
        float y = lblPraise.frame.origin.y+lblPraise.frame.size.height;
        
        for (int i = 0; i < mobj.comments.count; i++)
        {
            if (i == 3)
            {
                break;
            }
            
            if (i > 0)
            {
                y = y + 15;
            }
            
            MyUILabel *lblcomment =[[MyUILabel alloc]initWithFrame:CGRectMake(25, y - 5, 128, 25)];
            lblcomment.textColor=[UIColor grayColor];
            lblcomment.font=[UIFont systemFontOfSize:11];
            lblcomment.backgroundColor=[UIColor clearColor];
            lblcomment.lineBreakMode = NSLineBreakByWordWrapping;
            lblcomment.numberOfLines = 0;
            lblcomment.text = [NSString stringWithFormat:@"%@ : %@",[mobj.comments[i] objectForKey:@"nickname"],[mobj.comments[i] objectForKey:@"content"]];
            [view_bg addSubview:lblcomment];
        }
    }
    
}

//保持图片上下左右有固定间距
-(void)relayoutViews
{
    float originX = 0.0f;
    float originY = 0.0f;
    float width = 0.0f;
    float height = 0.0f;
    
    originY = TOPMARGIN;
    height = CGRectGetHeight(self.frame) - TOPMARGIN;
    if (self.indexPath.column == 0)
    {
        originX = LEFTMARGIN;
        width = CGRectGetWidth(self.frame) - LEFTMARGIN - 1/2.0*LEFTMARGIN;
    }
    else if (self.indexPath.column < self.columnCount - 1)
    {
        originX = LEFTMARGIN/2.0;
        width = CGRectGetWidth(self.frame) - LEFTMARGIN;
    }
    else
    {
        originX = LEFTMARGIN/2.0;
        width = CGRectGetWidth(self.frame) - LEFTMARGIN - 1/2.0*LEFTMARGIN;
    }
    view_bg.frame = CGRectMake( originX, originY,width, height);
    [super relayoutViews];

}

-(void)setcenterviewColor:(int)row
{
    if(row==0)
    {
        view_center.backgroundColor=COLOR(240, 41, 32);
    }
    else if(row==1)
    {
        view_center.backgroundColor=COLOR(143, 143, 143);
    }
    else if(row==2)
    {
        view_center.backgroundColor=COLOR(47, 44, 43);
    }
    else if(row==3)
    {
        view_center.backgroundColor=COLOR(124, 96, 33);
    }
}
@end
