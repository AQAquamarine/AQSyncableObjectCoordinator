//
//  NSPredicateAquasyncSoftDeletion.m
//  AQSyncableObjectCoordinator
//
//  Created by kaiinui on 2014/11/07.
//  Copyright (c) 2014年 Aquamarine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "NSPredicate+AquaSync.h"

@interface NSPredicateAquasyncTests : XCTestCase

@end

@implementation NSPredicateAquasyncTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testItReturnsPredicateForQueryingWithAqGid {
    NSPredicate *predicate = [NSPredicate aq_predicateWithGid:@"somegid"];
    XCTAssertTrue([predicate.predicateFormat isEqualToString:@"aq_isDeleted == 0 AND aq_gid == \"somegid\""]);
}

- (void)testItReturnsAqIsDeletedCompliantPredicate {
    NSPredicate *predicate = [NSPredicate aq_predicateWithFormat:@"aq_gid = %@", @"somegid"];
    XCTAssertTrue([predicate.predicateFormat isEqualToString:@"aq_isDeleted == 0 AND aq_gid == \"somegid\""]);
}

- (void)testItReturnPredicateForDirtyObjects {
    NSPredicate *predicate = [NSPredicate aq_predicateForDirtySyncableObjects];
    XCTAssertTrue([predicate.predicateFormat isEqualToString:@"aq_isDirty == 1"]);
}

@end
