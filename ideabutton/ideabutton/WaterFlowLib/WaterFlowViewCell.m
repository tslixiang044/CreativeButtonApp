//
//  WaterFlowViewCell.m
//  WaterFlowViewDemo
//
//  Created by Smallsmall on 12-6-11.
//  Copyright (c) 2012年 activation group. All rights reserved.
//

#import "WaterFlowViewCell.h"
#define COLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]



@implementation WaterFlowViewCell
@synthesize columnCount = _columnCount;
@synthesize indexPath = _indexPath;
@synthesize strReuseIndentifier = _strReuseIndentifier;

-(id)initWithIdentifier:(NSString *)indentifier
{
	if(self = [super init])
	{
		self.strReuseIndentifier = indentifier;
        self.backgroundColor=COLOR(4, 4, 4);
	}
	
	return self;
}

-(void)relayoutViews
{

    
}

- (void)dealloc
{
	self.indexPath = nil;
	self.strReuseIndentifier = nil;
	[super dealloc];
}

@end


@implementation IndexPath
@synthesize row = _row,column = _column;

+(IndexPath *)initWithRow:(NSInteger)indexRow withColumn:(NSInteger)indexColumn{

    IndexPath *indexPath = [[IndexPath alloc] init];
    indexPath.row = indexRow;
    indexPath.column = indexColumn;
    return [indexPath autorelease]; //autoRelease
}

@end