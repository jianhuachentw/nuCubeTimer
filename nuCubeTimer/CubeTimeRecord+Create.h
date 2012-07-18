//
//  CubeTimeRecord+Create.h
//  nuCubeTimer
//
//  Created by Jian Hua Chen on 12/7/9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CubeTimeRecord.h"

@interface CubeTimeRecord (Create)

+ (CubeTimeRecord *) cubeTimeRecordWithTime:(NSNumber *)time 
                     inManagedObjectContext:(NSManagedObjectContext *) context;

@end
