//
//  NSPredicate+AquaSyncSoftDeletion.m
//  AQSyncableObjectCoordinator
//
//  Created by kaiinui on 2014/11/07.
//  Copyright (c) 2014年 Aquamarine. All rights reserved.
//

#import "NSPredicate+AquaSync.h"

@implementation NSPredicate (AquaSync)

+ (instancetype)aq_predicateWithGid:(NSString *)aq_gid {
    return [NSPredicate predicateWithFormat:@"aq_isDeleted == 0 AND aq_gid == %@", aq_gid];
}

+ (instancetype)aq_predicateWithFormat:(NSString *)format, ... {
    va_list args;
    va_start(args, format);
    NSPredicate *predicate = [self predicateWithFormat:[NSString stringWithFormat:@"aq_isDeleted = 0 AND %@", format] arguments:args];
    va_end(args);
    
    return predicate;
}

+ (instancetype)aq_predicateForDirtySyncableObjects {
    return [self predicateWithFormat:@"aq_isDirty == 1"];
}

@end
