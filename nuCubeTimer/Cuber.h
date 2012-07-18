//
//  Cuber.h
//  nuCubeTimer
//
//  Created by Jian Hua Chen on 12/7/3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CubeTimeRecord;

@interface Cuber : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *records;
@end

@interface Cuber (CoreDataGeneratedAccessors)

- (void)addRecordsObject:(CubeTimeRecord *)value;
- (void)removeRecordsObject:(CubeTimeRecord *)value;
- (void)addRecords:(NSSet *)values;
- (void)removeRecords:(NSSet *)values;

@end
