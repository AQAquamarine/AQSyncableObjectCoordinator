//
//  AQSyncableObjectCoordinatorAQSDictionarySerializationTests.m
//  AQSyncableObjectCoordinator
//
//  Created by kaiinui on 2014/11/07.
//  Copyright (c) 2014年 Aquamarine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <OCMock.h>

#import "AQSyncableObjectCoordinator.h"
#import "AQSyncableObjectCoordinator+AQSDictionarySerialization.h"

#import "AQTestBook.h"

@interface AQSyncableObjectCoordinatorAQSDictionarySerializationTests : XCTestCase

@end

@implementation AQSyncableObjectCoordinatorAQSDictionarySerializationTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

# pragma mark - Low-Level

- (void)testItAppliesPatch {
    AQTestBook *book = [[AQTestBook alloc] init];
    AQDelta *delta = @{
                       @"aq_deviceToken": @"devicetoken"
                       };
    
    AQTestBook *patchAppliedBook = [[AQSyncableObjectCoordinator coordinator] patchAppliedObjectWithSyncableObject:book withDelta:delta];
    
    XCTAssertTrue([patchAppliedBook.aq_deviceToken isEqualToString:@"devicetoken"]);
}

# pragma mark - Public

- (void)testItShouldNotApplyPatchIfNotUpdated {
    AQTestBook *book = [[AQTestBook alloc] init];
    book.aq_localTimestamp = @(100);
    AQDelta *delta = @{
                       @"aq_localTimestamp": @(99),
                       @"aq_deviceToken": @"devicetoken"
                       };
    AQTestBook *patchMayAppliedBook = [[AQSyncableObjectCoordinator coordinator] patchAppliedObjectIfUpdatedWithSyncableObject:book withDelta:delta];
    
    XCTAssertFalse([patchMayAppliedBook.aq_deviceToken isEqualToString:@"devicetoken"]);
}

- (void)testItShouldApplyPatchIfUpdated {
    AQTestBook *book = [[AQTestBook alloc] init];
    book.aq_localTimestamp = @(100);
    AQDelta *delta = @{
                       @"aq_localTimestamp": @(101),
                       @"aq_deviceToken": @"devicetoken"
                       };
    AQTestBook *patchMayAppliedBook = [[AQSyncableObjectCoordinator coordinator] patchAppliedObjectIfUpdatedWithSyncableObject:book withDelta:delta];
    
    XCTAssertTrue([patchMayAppliedBook.aq_deviceToken isEqualToString:@"devicetoken"]);
}

- (void)testItShouldNotApplyPatchIfDeltaHasSameTimestamp {
    AQTestBook *book = [[AQTestBook alloc] init];
    book.aq_localTimestamp = @(100);
    AQDelta *delta = @{
                       @"aq_localTimestamp": @(100),
                       @"aq_deviceToken": @"devicetoken"
                       };
    AQTestBook *patchMayAppliedBook = [[AQSyncableObjectCoordinator coordinator] patchAppliedObjectIfUpdatedWithSyncableObject:book withDelta:delta];
    
    XCTAssertFalse([patchMayAppliedBook.aq_deviceToken isEqualToString:@"devicetoken"]);
}

@end
