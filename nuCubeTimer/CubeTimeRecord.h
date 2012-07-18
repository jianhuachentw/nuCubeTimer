//
//  CubeTimeRecord.h
//  nuCubeTimer
//
//  Created by Jian Hua Chen on 12/7/3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Cuber;

@interface CubeTimeRecord : NSManagedObject

@property (nonatomic, retain) NSNumber * time;
@property (nonatomic, retain) Cuber *whoCreate;

@end
