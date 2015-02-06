//
//  BaseEntity.m
//  HomeFurnishingApp
//
//  Created by 周同 on 15-1-6.
//
//

#import "BaseEntity.h"
#import "RMMapper.h"
#import "NSUserDefaults+RMSaveCustomObject.h"


@implementation BaseEntity




-(id)initwithDic:(NSDictionary*)mdic
{
    return [RMMapper objectWithClass:[self class] fromDictionary:mdic];
}
-(void)savetoUserdefault_key:(NSString *)mkey
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
     [defaults  rm_setCustomObject:self forKey:mkey];
}


@end
