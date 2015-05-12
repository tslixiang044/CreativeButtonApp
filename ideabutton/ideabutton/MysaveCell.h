//
//  MysaveCell.h
//  ideabutton
//
//  Created by ZhouTong on 15-2-27.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCell.h"
#import "MyUIButton.h"



//---------------------
@class MysaveCell;
@protocol MysaveCellDelegate <NSObject>

-(void)btnshow:(NSString *)mid row:(NSInteger)mrow ;


-(void)btndeleteAction:(MyUIButton *)mbtn;
-(void)btnwybzAction:(MyUIButton *)mbtn;
-(void)btnwygzAction:(MyUIButton *)mbtn;
@end
//---------------------



@interface MysaveCell : BaseCell
{
    UIImageView *imgview_left;
    UILabel *lbltitle;
    
    MyUIButton *btndelete;
    MyUIButton *btnwybz;
    MyUIButton *btnwygz;
    UIButton *btnadd;
}
@property(nonatomic,strong)NSString *strid;
@property(nonatomic,assign)NSInteger mrow;


@property(nonatomic,assign)id<MysaveCellDelegate>delegate;

@property(nonatomic,strong)UIImageView *imgview_left;
@property(nonatomic,strong)UILabel *lbltitle;
@property(nonatomic,strong)MyUIButton *btndelete;
@property(nonatomic,strong)MyUIButton *btnwybz;
@property(nonatomic,strong)MyUIButton *btnwygz;
@property(nonatomic,strong)UIButton *btnadd;


@end
