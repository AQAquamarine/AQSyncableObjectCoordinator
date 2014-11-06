//
//  AQSyncableObjectCoodinator.h
//  AQSyncableObjectCoordinator
//
//  Created by kaiinui on 2014/11/06.
//  Copyright (c) 2014年 Aquamarine. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AQSyncableObject;
@class AQDelta;

@interface AQSyncableObjectCoodinator : NSObject

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

/**
 *  Make the object undirty.
 *
 *  @param object An object that you want to mark as pushed.
 */
- (void)undirtifySyncableObject:(id<AQSyncableObject>)object;

/**
 *  Returns whether the object should be updated for merging data using a delta.
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
 *  @param object An object that you want to mark as pushed.
 *  @param delta  A delta you want to mark as pushed
 *
 *  @return Whether the object should be updated for marking as pushed
 */
- (BOOL)shouldUpdateObjectForMarkingAsPushed:(id<AQSyncableObject>)object withDelta:(AQDelta *)delta;

@end
