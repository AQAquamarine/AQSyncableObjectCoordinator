//
//  AQTestBook.h
//  AQSyncableObjectCoordinator
//
//  Created by kaiinui on 2014/11/07.
//  Copyright (c) 2014年 Aquamarine. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AQSyncableObject.h"
#import <AQSDictionarySerialization.h>

@interface AQTestBook : NSObject <AQSyncableObject, AQSDictionarySerialization>

@property NSString *aq_gid;
@property NSString *aq_deviceToken;
@property NSNumber *aq_localTimestamp;
@property NSNumber *aq_isDirty;
@property NSNumber *aq_isDeleted;

@end
