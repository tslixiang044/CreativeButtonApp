//
//  MyInformationCell.h
//  ideabutton
//
//  Created by ZhouTong on 15-4-6.
//  Copyright (c) 2015年 ttt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCell.h"
@interface MyInformationCell : BaseCell
{
   
    UILabel *lbltitle;
    UILabel *lbldesc;
}


@property(nonatomic,strong)UILabel *lbltitle;
@property(nonatomic,strong)UILabel *lbldesc;


@end
