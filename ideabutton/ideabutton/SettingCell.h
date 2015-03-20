//
//  SettingCell.h
//  TeamTalk
//
//  Created by ZhouTong on 15-3-18.
//  Copyright (c) 2015年 dujia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCell.h"
@interface SettingCell : BaseCell
{
    UILabel *lbldesc;
    UISwitch *mswitch;
}
@property(nonatomic,strong)UILabel *lbldesc;
@property(nonatomic,strong)UISwitch *mswitch;

@end
