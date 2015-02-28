//
//  MytoolviewCell.h
//  ideabutton
//
//  Created by ZhouTong on 15-2-27.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCell.h"
@interface MytoolviewCell : UITableViewCell
{
    UIImageView *imgview_left;
    UILabel *lbltitle;
    
}

@property(nonatomic,strong)UIImageView *imgview_left;
@property(nonatomic,strong)UILabel *lbltitle;


@end
