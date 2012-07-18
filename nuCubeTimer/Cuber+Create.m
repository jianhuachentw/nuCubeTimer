//
//  Cuber+Create.m
//  nuCubeTimer
//
//  Created by Jian Hua Chen on 12/7/9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Cuber+Create.h"

@implementation Cuber (Create)

+ (Cuber *) cuberWithName:(NSString *) name
    inManagedObjectConext:(NSManagedObjectContext *) context
{
    Cuber *cuber = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Cuber"];
    request.predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:descriptor];
    
    NSError *error = nil;
    NSArray *cubers = [context executeFetchRequest:request error:&error];
    
    if (!cubers || [cubers count] > 1) {
        // handle error
    } else if (![cubers count]) {
        cuber = [NSEntityDescription insertNewObjectForEntityForName:@"name" inManagedObjectContext:context];
        cuber.name = name;
    } else {
        cuber = [cubers lastObject];
    }
    
    return cuber;
}

@end
