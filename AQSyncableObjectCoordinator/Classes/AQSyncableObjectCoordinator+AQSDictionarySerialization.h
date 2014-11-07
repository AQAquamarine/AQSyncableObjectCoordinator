//
//  AQSyncableObjectCoordinator+AQSDictionarySerialization.h
//  AQSyncableObjectCoordinator
//
//  Created by kaiinui on 2014/11/07.
//  Copyright (c) 2014年 Aquamarine. All rights reserved.
//

#import "AQSyncableObjectCoordinator.h"

#import "AQSyncableObject.h"
#import <AQSDictionarySerialization.h>

@interface AQSyncableObjectCoordinator (AQSDictionarySerialization)

/**
 *  Returns the Delta patch applied syncable object if the delta's localTimestamp is newer than syncable object's.
 *  Otherwise, it returns original syncable object.
 *
 *  @param syncableObject A syncable object you want to apply a patch with a delta. This object should conforms to both `AQSyncableObject` and `AQSDictionarySerialization`.
 *  @param delta          A delta you want to apply a patch with
 *
 *  @return The delta patch applied syncable object or the syncable object
 */
- (id)patchAppliedObjectIfNotUpdatedWithSyncableObject:(NSObject <AQSyncableObject, AQSDictionarySerialization>*)syncableObject withDelta:(AQDelta *)delta;

/**
 *  Returns the given Delta patch applied syncable object.
 *
 *  @param syncableObject A syncable object you want to apply a patch with a delta. This object should conforms to both `AQSyncableObject` and `AQSDictionarySerialization`.
 *  @param delta          A delta you want to apply a patch with
 *
 *  @return The delta patch applied syncable object
 */
- (id)patchAppliedObjectWithSyncableObject:(NSObject <AQSyncableObject, AQSDictionarySerialization> *)syncableObject withDelta:(AQDelta *)delta;

@end
