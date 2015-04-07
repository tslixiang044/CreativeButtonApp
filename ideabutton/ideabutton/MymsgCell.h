//
//  MymsgCell.h
//  ideabutton
//
//  Created by ZhouTong on 15-4-5.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCell.h"
#import "MyUIImageView.h"


@interface MymsgCell : BaseCell
{
    MyUIImageView *imgview_left;
    UILabel *lbltitle;
    UILabel *lbltime;
}

@property(nonatomic,strong)UIImageView *imgview_left;
@property(nonatomic,strong)UILabel *lbltitle;
@property(nonatomic,strong)UILabel *lbltime;

@end
