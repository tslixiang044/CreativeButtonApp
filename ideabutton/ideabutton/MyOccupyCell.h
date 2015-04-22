//
//  MyOccupyCell.h
//  ideabutton
//
//  Created by Li Xiang on 15/4/22.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCell.h"
#import "MyUIButton.h"

//---------------------
@class MyOccupyCell;
@protocol MyOccupyCellDelegate <NSObject>

-(void)btnshow:(NSString *)mid row:(int)mrow;


-(void)btndeleteAction:(MyUIButton *)mbtn;
-(void)btnwybzAction:(MyUIButton *)mbtn;
-(void)btnwygzAction:(MyUIButton *)mbtn;


@end
//---------------------

@interface MyOccupyCell : BaseCell
{
    UIImageView *imgview_left;
    UILabel *lbltitle;
    
    MyUIButton *btndelete;
    MyUIButton *btnwybz;
    MyUIButton *btnwygz;
    UIButton *btnadd;
}
@property(nonatomic,assign)id<MyOccupyCellDelegate>delegate;

@property(nonatomic,strong)NSString *strid;
@property(nonatomic,assign)int mrow;


@property(nonatomic,strong)UIImageView *imgview_left;
@property(nonatomic,strong)UILabel *lbltitle;

@property(nonatomic,strong)MyUIButton *btndelete;
@property(nonatomic,strong)MyUIButton *btnwybz;
@property(nonatomic,strong)MyUIButton *btnwygz;
@property(nonatomic,strong)UIButton *btnadd;
@end
