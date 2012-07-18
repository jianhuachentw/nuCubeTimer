//
//  Cuber+Create.h
//  nuCubeTimer
//
//  Created by Jian Hua Chen on 12/7/9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Cuber.h"

@interface Cuber (Create)

+ (Cuber *) cuberWithName:(NSString *) name
    inManagedObjectConext:(NSManagedObjectContext *) context; 

@end
