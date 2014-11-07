//
//  AQTestBook.m
//  AQSyncableObjectCoordinator
//
//  Created by kaiinui on 2014/11/07.
//  Copyright (c) 2014年 Aquamarine. All rights reserved.
//

#import "AQTestBook.h"

@implementation AQTestBook

- (NSDictionary *)aqs_keyPathsByPropertyKey {
    return @{
             @"aq_gid": @"aq_gid",
             @"aq_localTimestamp": @"aq_localTimestamp",
             @"aq_deviceToken": @"aq_deviceToken",
             @"aq_isDirty": @"aq_isDirty",
             @"aq_isDeleted": @"aq_isDeleted"
             };
}

- (NSString *)aq_modelName {
    return @"TestBook";
}

@end
