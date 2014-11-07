//
//  AQSyncableObjectCoordinator+AQSDictionarySerialization.m
//  AQSyncableObjectCoordinator
//
//  Created by kaiinui on 2014/11/07.
//  Copyright (c) 2014年 Aquamarine. All rights reserved.
//

#import "AQSyncableObjectCoordinator+AQSDictionarySerialization.h"

#import "AQSyncableObjectCoordinator.h"
#import <AQSDictionarySerializer.h>

@implementation AQSyncableObjectCoordinator (AQSDictionarySerialization)

- (id)patchAppliedObjectIfNotUpdatedWithSyncableObject:(NSObject<AQSyncableObject, AQSDictionarySerialization> *)syncableObject withDelta:(NSDictionary *)delta {
    if ([self shouldUpdateObjectForMergingData:syncableObject withDelta:delta] == NO) { return syncableObject; }
    
    return [self patchAppliedObjectWithSyncableObject:syncableObject withDelta:delta];
}

- (id)patchAppliedObjectWithSyncableObject:(NSObject<AQSyncableObject,AQSDictionarySerialization> *)syncableObject withDelta:(NSDictionary *)delta {
    [[AQSDictionarySerializer serializer] patchAppliedObjectForObject:syncableObject withDictionary:delta];
    return syncableObject;
}

@end
