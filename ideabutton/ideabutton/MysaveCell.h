//
//  MysaveCell.h
//  ideabutton
//
//  Created by ZhouTong on 15-2-27.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCell.h"




//---------------------
@class MysaveCell;
@protocol MysaveCellDelegate <NSObject>

-(void)btnshow:(NSString *)mid row:(int)mrow;

@end
//---------------------



@interface MysaveCell : BaseCell
{
    UIImageView *imgview_left;
    UILabel *lbltitle;
    
}
@property(nonatomic,strong)NSString *strid;
@property(nonatomic,assign)int mrow;


@property(nonatomic,assign)id<MysaveCellDelegate>delegate;

@property(nonatomic,strong)UIImageView *imgview_left;
@property(nonatomic,strong)UILabel *lbltitle;





@end
