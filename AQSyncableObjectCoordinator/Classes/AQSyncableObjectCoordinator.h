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

@interface AQSyncableObjectCoordinator : NSObject

# pragma mark - Instantiation
/** @name Instantiation */

/**
 *  Returns an initialized coordinator
 *
 *  @return An initialized coordinator
 */
+ (instancetype)coordinator;

# pragma mark - Handling Dirtify / Undirtify Syncable Objects
/** @name Handling Dirtify / Undirtify Syncable Objects */

/**
 *  Make the object dirty.
 *
 *  @param object An object that you want to mark as requiring synchronization.
 */
- (void)dirtifySyncableObject:(id<AQSyncableObject>)object;

/**
 *  Make the object undirty if the object not updated by the user from pushing delta.
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
