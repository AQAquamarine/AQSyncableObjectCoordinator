//
//  AQSyncableObjectCoordinator.h
//  AQSyncableObjectCoordinator
//
//  Created by kaiinui on 2014/11/06.
//  Copyright (c) 2014年 Aquamarine. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AQSyncableObject;
typedef NSDictionary AQDelta;

/**
 *  A class that handles preparing syncable objects for Aquasync process.
 *
 *  This class contains methos that should be called on..
 *
 *  - When syncable objects is created or updated
 *  - When you want to delete syncable objects
 *  - `- markAsPushedUsingDeltaPack:` of `AQSyncableObjectAggregator` protocol
 *  - `- updateRecordsUsingDeltaPack:` of `AQSyncableObjectAggregator` protocol
 */
@interface AQSyncableObjectCoordinator : NSObject

# pragma mark - Instantiation
/** @name Instantiation */

/**
 *  Returns an initialized coordinator
 *
 *  @return An initialized coordinator
 */
+ (instancetype)coordinator;

# pragma mark - Methods that should be called when the objects updated
/** @name Methods that should be called when the objects updated */

/**
 *  Make the object dirty.
 *
 *  **This method should be called when syncable objects are created / updated.**
 *
 *  @param object An object that you want to mark as requiring synchronization.
 */
- (void)dirtifySyncableObject:(id<AQSyncableObject>)object;

# pragma mark - Methods that should be called when Marking as Pushed
/** @name Methods that should be called when Marking as Pushed */

/**
 *  Make the object undirty if the object not updated by the user from pushing delta.
 *
 *  **Typically, this method is called on `- markAsPushedUsingDeltaPack:` of `AQSyncableObjectAggregator`**
 *
 *  @param object An object that you want to mark as pushed
 *  @param delta  A delta that used to push changes.
 */
- (void)undirtifySyncableObjectIfNotUpdated:(id<AQSyncableObject>)object withDelta:(AQDelta *)delta;

# pragma mark - Working with Soft Deletion
/** @name Working with Soft Deletion */

/**
 *  Mark the object as deleted.
 *  To make the effect, you should query objects with additional predicate: `aq_isDirty == NO`
 *
 *  **This method should be called when you want to delete syncable objects. Do not do hard deletion.**
 *
 *  @param object An object you want to delete
 */
- (void)markAsDeleteObject:(id<AQSyncableObject>)object;

# pragma mark - Handling Low-Level Dirtying / Undirtying Objects
/** @name Handling Low-Level Dirtying / Undirtying Objects */

/**
 *  Make the object undirty.
 *
 *  @warning This method is Low-Level.
 *
 *  @param object An object that you want to mark as pushed.
 */
- (void)undirtifySyncableObject:(id<AQSyncableObject>)object;

/**
 *  Returns whether the object should be updated for merging data using a delta.
 *
 *  @warning This method is Low-Level.
 *
 *  @param object An object that you want to marge a delta
 *  @param delta  A delta you want to merge
 *
 *  @return Whether the object should be updated for merging data using a delta.
 */
- (BOOL)shouldUpdateObjectForMergingData:(id<AQSyncableObject>)object withDelta:(AQDelta *)delta;

/**
 *  Returns whether the object should be updated for marking as pushed.
 *
 *  @warning This method is Low-Level.
 *
 *  @param object An object that you want to mark as pushed.
 *  @param delta  A delta you want to mark as pushed
 *
 *  @return Whether the object should be updated for marking as pushed
 */
- (BOOL)shouldUpdateObjectForMarkingAsPushed:(id<AQSyncableObject>)object withDelta:(AQDelta *)delta;

@end

#import "AQSyncableObjectCoordinator+AQSDictionarySerialization.h"