//
//  NSDate+Timestamp.m
//  AQSyncableObjectCoordinator
//
//  Created by kaiinui on 2014/11/06.
//  Copyright (c) 2014年 Aquamarine. All rights reserved.
//

#import "NSDate+Timestamp.h"

@implementation NSDate (Timestamp)

- (NSUInteger)timestamp {
    return (time_t) [self timeIntervalSince1970];
}

@end
