//
//  AQSyncableObject.h
//  AQSyncableObjectCoordinator
//
//  Created by kaiinui on 2014/11/06.
//  Copyright (c) 2014年 Aquamarine. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  This protocol represents Aquasync-able object.
 *
 *  Objects that conforms to `AQSyncableObject` can be handled with `AQSyncableObjectCoordinator` for preparing objects for Aquasync process.
 */
@protocol AQSyncableObject <NSObject>

/**
 *  It should return Aquasync DeltaPack compliant model name such as "Book".
 *
 *  @return The name of the model like "Book"
 */
- (NSString *)aq_modelName;

- (NSString *)aq_gid;
- (void)setAq_gid:(NSString *)aq_gid;

- (NSString *)aq_deviceToken;
- (void)setAq_deviceToken:(NSString *)aq_deviceToken;

- (NSNumber /* NSUInteger */ *)aq_localTimestamp;
- (void)setAq_localTimestamp:(NSNumber /* BOOL */ *)aq_localTimestamp;

- (NSNumber /* BOOL */ *)aq_isDirty;
- (void)setAq_isDirty:(NSNumber /* BOOL */ *)aq_isDirty;

- (NSNumber /* BOOL */ *)aq_isDeleted;
- (void)setAq_isDeleted:(NSNumber /* BOOL */ *)aq_isDeleted;

@end
