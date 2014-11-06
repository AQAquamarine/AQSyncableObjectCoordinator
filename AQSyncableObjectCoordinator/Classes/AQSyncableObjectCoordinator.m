//
//  AQSyncableObjectCoordinator.m
//  AQSyncableObjectCoordinator
//
//  Created by kaiinui on 2014/11/06.
//  Copyright (c) 2014年 Aquamarine. All rights reserved.
//

#import "AQSyncableObjectCoordinator.h"
#import "AQSyncableObject.h"
#import "NSDate+Timestamp.h"

@implementation AQSyncableObjectCoordinator

# pragma mark - Instantiation

+ (instancetype)coordinator {
    return [[self alloc] init];
}

# pragma mark - Handling Undirtify / Dirtify

- (void)dirtifySyncableObject:(id<AQSyncableObject>)object {
    [object setAq_isDirty:@(YES)];
    [object setAq_localTimestamp:@([[NSDate date] timestamp])];
}

- (void)undirtifySyncableObjectIfNotUpdated:(id<AQSyncableObject>)object withDelta:(NSDictionary *)delta {
    if ([self shouldUpdateObjectForMarkingAsPushed:object withDelta:delta] == NO) { return; }
    
    [self undirtifySyncableObject:object];
}

# pragma mark - Working with Soft Deletion

- (void)markAsDeleteObject:(id<AQSyncableObject>)object {
    [object setAq_isDeleted:@(YES)];
}

# pragma mark - Low-Level Undirtify / Dirtify

- (void)undirtifySyncableObject:(id<AQSyncableObject>)object {
    [object setAq_isDirty:@(NO)];
}

- (BOOL)shouldUpdateObjectForMergingData:(id<AQSyncableObject>)object withDelta:(AQDelta *)delta {
    NSUInteger objectTimestamp = [[object aq_localTimestamp] unsignedIntegerValue];
    NSUInteger deltaTimestamp = [delta[@"aq_localTimestamp"] unsignedIntegerValue];
    
    return deltaTimestamp >= objectTimestamp;
}

- (BOOL)shouldUpdateObjectForMarkingAsPushed:(id<AQSyncableObject>)object withDelta:(AQDelta *)delta {
    NSUInteger objectTimestamp = [[object aq_localTimestamp] unsignedIntegerValue];
    NSUInteger deltaTimestamp = [delta[@"aq_localTimestamp"] unsignedIntegerValue];
    
    return deltaTimestamp >= objectTimestamp;
}

@end
