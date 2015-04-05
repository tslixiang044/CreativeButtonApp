//
//  MySegmentedControl.m
//  jintiApp
//
//  Created by jintimac on 13-1-25.
//  Copyright (c) 2013年 jintimac. All rights reserved.
//

#import "MySegmentedControl.h"
#import "Config.h"

@implementation MySegmentedControl
@synthesize items;
@synthesize delegate,selectedSegmentIndex;
//--------
@synthesize btnlist;






- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        selectedSegmentIndex=0;
        btnlist=[[NSMutableArray alloc]init ];
        self.backgroundColor=[UIColor lightGrayColor];
    }
    return self;
}


-(void)setItems:(NSArray *)mitems
{
     if(mitems==nil)
     {
         return;
     }
    if(items)
    {
       
        items=nil;
    }
    
    items=mitems;
    
    int count=(int)[items count];
    
    
    float width=self.frame.size.width/count;
    float height=self.frame.size.height;
    float x=0;
    
    for(int i=0;i<count;i++)
    {
        x=width*i;
        
        
        
        
        //-------------
        //NSString *imgname1=[Global getInstanse].isDay==0?@"msegment.png":@"msegment_night.png";
        MyUIButton  *mbtn=[[MyUIButton alloc]initWithFrame:CGRectMake(x, 0, width, height) bgimg:@"msegment.png" title:[items objectAtIndex:i]] ;
        mbtn.tag=i;
        [mbtn addTarget:self action:@selector(btnsegmentAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [mbtn setTitleColor:COLOR(106, 105, 105) forState:UIControlStateNormal];
        [mbtn setTitleColor:COLOR(106, 105, 105) forState:UIControlStateHighlighted];
        
        [self addSubview:mbtn];
        
      
        

        
        if(i==0)
        {
            
            [mbtn setBackgroundImage:[UIImage imageNamed:@"msegmented.png"] forState:UIControlStateNormal];
            [mbtn setTitleColor:COLOR(106, 105, 105) forState:UIControlStateNormal];
            [mbtn setTitleColor:COLOR(106, 105, 105) forState:UIControlStateHighlighted];
        }
        
        [btnlist addObject:mbtn];
      
        
       
        
        
        
    }
    //-------------------------------------
//    imgline=[[UIImageView alloc]initWithFrame:CGRectMake(0, height-1, 320 , 1)];
//    
//    NSString *img_line=[Global getInstanse].isDay==0?@"comment_line.png":@"comment_line_night.png";
//    imgline.image=[UIImage imageNamed:img_line];
//    [self addSubview:imgline];
    
    //-------------------------------------
    
    
    UILabel *lblline=[[UILabel alloc]initWithFrame:CGRectMake(0, height-1, width, 1)];
    lblline.tag=100;
    lblline.backgroundColor=[UIColor redColor];;
    [self addSubview:lblline];
 
    
    
    
}
-(void)btnsegmentAction:(MyUIButton*)mbtn
{
    
   
    
    if(selectedSegmentIndex==mbtn.tag)
    {
        return;
    }
    MyUIButton *btn=(MyUIButton*)[btnlist objectAtIndex:selectedSegmentIndex];
    
     [btn setBackgroundImage:[UIImage imageNamed:@"msegment.png"] forState:UIControlStateNormal];
    [btn setTitleColor:COLOR(106, 105, 105) forState:UIControlStateNormal];
    [btn setTitleColor:COLOR(106, 105, 105) forState:UIControlStateHighlighted];
    //-------------------------------------------------
    selectedSegmentIndex=(int)mbtn.tag ;
    //-------------------------------------------------
    
    
    
    [mbtn setBackgroundImage:[UIImage imageNamed:@"msegmented.png"] forState:UIControlStateNormal];
   
    
    
    [mbtn setTitleColor:COLOR(106, 105, 105) forState:UIControlStateNormal];
    [mbtn setTitleColor:COLOR(106, 105, 105) forState:UIControlStateHighlighted];
    //-------------------------------------------------
    
    if(delegate)
    {
        [delegate msegment_selected:self index:(int )mbtn.tag];
    }
    //---------------------------------------------------
    
    

    
    
}
-(void)scrollviewX:(float)x pagecount:(int)mpage
{
    
    //if(iscliced)return;
    
    UILabel *lblline=(UILabel *)[self viewWithTag:100];
    float xx=x/items.count;
    lblline.frame=CGRectMake(xx, lblline.frame.origin.y, lblline.frame.size.width, 2);
    
    //NSLog(@"pagecoun=    %i",mpage);
    
    if(mpage != selectedSegmentIndex)
    {
        //NSLog(@"分页了");
        
        
        
        
        MyUIButton *btn=(MyUIButton*)[btnlist objectAtIndex:selectedSegmentIndex];
        [btn setBackgroundImage:[UIImage imageNamed:@"msegment.png"] forState:UIControlStateNormal];
        [btn setTitleColor:COLOR(106, 105, 105) forState:UIControlStateNormal];
        [btn setTitleColor:COLOR(106, 105, 105) forState:UIControlStateHighlighted];
        //-------------------------------------------------
      
        MyUIButton *mbtn=(MyUIButton*)[btnlist objectAtIndex:mpage];
        //-------------------------------------------------
        
        
        
        
        [mbtn setBackgroundImage:[UIImage imageNamed:@"msegmented.png"] forState:UIControlStateNormal];
        [mbtn setTitleColor:COLOR(106, 105, 105) forState:UIControlStateNormal];
        [mbtn setTitleColor:COLOR(106, 105, 105) forState:UIControlStateHighlighted];
        
        
        selectedSegmentIndex=mpage;
    }
    
    
}


-(void)showlineAnimaton
{
        [UIView animateWithDuration:0.2 animations:^{
            UILabel *lblline=(UILabel*)[self viewWithTag:100];
            int x=selectedSegmentIndex*lblline.frame.size.width;
            
            lblline.frame=CGRectMake(x, lblline.frame.origin.y, lblline.frame.size.width, lblline.frame.size.height) ;
    
        }];
}

@end
