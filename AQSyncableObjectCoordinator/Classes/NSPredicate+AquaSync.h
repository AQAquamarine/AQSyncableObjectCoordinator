//
//  NSPredicate+AquaSyncSoftDeletion.h
//  AQSyncableObjectCoordinator
//
//  Created by kaiinui on 2014/11/07.
//  Copyright (c) 2014年 Aquamarine. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  A set of predicate for Aquasync.
 */
@interface NSPredicate (AquaSync)

/**
 *  Typically used on `- markAsPushedUsingDeltaPack:`, `- updateRecordsUsingDeltaPack:` of `AQSyncableObjectAggregator` protocol.
 *
 *  @return A predicate for querying syncable object with `aq_gid`.
 */
+ (instancetype)aq_predicateWithGid:(NSString *)aq_gid;

/**
 *  Returns a predicate that considers Aquasync's soft deletion.
 *  All of predicates you use should be instantiated by this method.
 *
 *  @return A predicate that consideres soft deletion with `aq_isDeleted`
 */
+ (instancetype)aq_predicateWithFormat:(NSString *)format, ...;

/**
 *  In `- deltaPackForSynchronization` of `AQSyncableObjectAggregator` protocol, it is recommended to use this predicate to find dirty objects.
 *
 *  @return A predicate for querying dirty syncable objects. (`aq_isDirty == YES`)
 */
+ (instancetype)aq_predicateForDirtySyncableObjects;

@end
