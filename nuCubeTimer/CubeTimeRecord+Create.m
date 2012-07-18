//
//  CubeTimeRecord+Create.m
//  nuCubeTimer
//
//  Created by Jian Hua Chen on 12/7/9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CubeTimeRecord+Create.h"
#import "Cuber+Create.h"

@implementation CubeTimeRecord (Create)

+ (CubeTimeRecord *) cubeTimeRecordWithTime:(NSNumber *)time 
                     inManagedObjectContext:(NSManagedObjectContext *) context
{
    CubeTimeRecord *record = nil;
    
    record = [NSEntityDescription insertNewObjectForEntityForName:@"CubeTimeRecord" 
                                           inManagedObjectContext:context];
    record.time = time;
    record.whoCreate = [Cuber cuberWithName:@"mint" inManagedObjectConext:context];
    
    return record;
}

@end
