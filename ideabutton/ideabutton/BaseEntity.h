//
//  BaseEntity.h
//  HomeFurnishingApp
//
//  Created by 周同 on 15-1-6.
//
//

#import <Foundation/Foundation.h>


@interface BaseEntity : NSObject


-(id)initwithDic:(NSDictionary*)mdic;
-(void)savetoUserdefault_key:(NSString *)mkey;

@end
