//
//  ImageViewCell.m
//  WaterFlowViewDemo
//
//  Created by Smallsmall on 12-6-12.
//  Copyright (c) 2012年 activation group. All rights reserved.
//

#import "ImageViewCell.h"



#define COLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define TOPMARGIN 8.0f
#define LEFTMARGIN 8.0f

#define IMAGEVIEWBG [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0]

@implementation ImageViewCell



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

-(id)initWithIdentifier:(NSString *)indentifier
{
	if(self = [super initWithIdentifier:indentifier])
	{

        float x=10;
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
        //--------------
         x=imgview_header.frame.origin.x+imgview_header.frame.size.width+5;
        lblnickname=[[UILabel alloc]initWithFrame:CGRectMake(x, y, 100, 25)];
        lblnickname.backgroundColor=[UIColor clearColor];
        lblnickname.font=[UIFont systemFontOfSize:13];
        lblnickname.textColor=COLOR(98, 98, 98);
        [view_bg addSubview:lblnickname];
        //--------------
        y=lblnickname.frame.origin.y+lblnickname.frame.size.height;
        
        lblsource=[[UILabel alloc]initWithFrame:CGRectMake(x, y, 100, 25)];
        lblsource.backgroundColor=[UIColor clearColor];
        lblsource.text=@"长沙 胜美广告";
        lblsource.font=[UIFont systemFontOfSize:12];
        lblsource.textColor=COLOR(98, 98, 98);
        [view_bg addSubview:lblsource];
        //---------------
        y=imgview_header.frame.origin.y+imgview_header.frame.size.height+5;
        
        view_center=[[UIView alloc]initWithFrame:CGRectMake(0, y, 150, 100)];
        view_center.backgroundColor=COLOR(124, 96, 33);
        [view_bg addSubview:view_center];
        //---------------
        x=10;
        y=10;
        
        lbldesc=[[UILabel alloc]initWithFrame:CGRectMake(x, y, 128, 35)];
        lbldesc.numberOfLines=2;
        lbldesc.textColor=[UIColor whiteColor];
        lbldesc.font=[UIFont systemFontOfSize:12];
        lbldesc.backgroundColor=[UIColor clearColor];
        [view_center addSubview:lbldesc];
        //---------------
        y=lbldesc.frame.origin.y+lbldesc.frame.size.height;
        lblproduct=[[UILabel alloc]initWithFrame:CGRectMake(x, y, 128, 25)];
        
        lblproduct.textColor=[UIColor whiteColor];
        lblproduct.font=[UIFont systemFontOfSize:14];
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
        x=10;
        y=view_center.frame.origin.y+view_center.frame.size.height+5;
        //--
        UIImageView *imgview_praise=[[UIImageView alloc]initWithFrame:CGRectMake(x, y+5, 15, 15)];
        imgview_praise.image=[UIImage imageNamed:@"icon_aixin.png"];
        [view_bg addSubview:imgview_praise];
        //--
        
        lblPraise=[[UILabel alloc]initWithFrame:CGRectMake(x+20, y, 128, 25)];
        lblPraise.textColor=[UIColor grayColor];
        lblPraise.font=[UIFont systemFontOfSize:12];
        lblPraise.backgroundColor=[UIColor clearColor];
        [view_bg addSubview:lblPraise];
        //--
        y=lblPraise.frame.origin.y+lblPraise.frame.size.height;
//        lblForward=[[UILabel alloc]initWithFrame:CGRectMake(x, y, 128, 25)];
//        lblForward.textColor=[UIColor grayColor];
//        lblForward.font=[UIFont systemFontOfSize:12];
//        lblForward.backgroundColor=[UIColor clearColor];
//        [view_bg addSubview:lblForward];
//        //--
//        
//        y=lblForward.frame.origin.y+lblForward.frame.size.height;
        
        UIImageView *imgview_comment=[[UIImageView alloc]initWithFrame:CGRectMake(x, y+5, 15, 15)];
        imgview_comment.image=[UIImage imageNamed:@"icon_qipao.png"];
        [view_bg addSubview:imgview_comment];
        //--
        lblcomment=[[UILabel alloc]initWithFrame:CGRectMake(x+20, y, 128, 25)];
        lblcomment.textColor=[UIColor grayColor];
        lblcomment.font=[UIFont systemFontOfSize:12];
        lblcomment.backgroundColor=[UIColor clearColor];
        [view_bg addSubview:lblcomment];
        
        
        
        
	}
	
	return self;
}

-(void)setImageWithURL:(NSURL *)imageUrl
{

    //[imageView setImageWithURL:imageUrl];
    
}

-(void)setImage:(UIImage *)image{

    //imageView.image = image;
}



-(void)setbtnObjct:(WaterFlowObj*)mobj
{
    lblnickname.text=mobj.nickname;
    
    NSURL *murl=[NSURL URLWithString:mobj.avatar];
    
    [imgview_header setImageWithURL:murl placeholderImage:[UIImage imageNamed:@"userheader.png"]];
    
    lbldesc.text=mobj.sentence;
    lblproduct.text=mobj.product;
    lbltime.text=mobj.timeStamp;
    
    lblPraise.text=@"1次赞";
    lblForward.text=@"10次转发";
    lblcomment.text=@"perter zhong也太酷了吧！";
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
    //imageView.frame = CGRectMake( originX, originY,width, height);
    view_bg.frame = CGRectMake( originX, originY,width, height);
    [super relayoutViews];

}

@end
