//
//  AQSyncableObjectCoordinatorTests.m
//  AQSyncableObjectCoordinatorTests
//
//  Created by kaiinui on 2014/11/06.
//  Copyright (c) 2014年 Aquamarine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <OCMock.h>

#import "AQSyncableObject.h"
#import "AQSyncableObjectCoordinator.h"

@interface AQSyncableObjectCoordinatorTests : XCTestCase

@end

@implementation AQSyncableObjectCoordinatorTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

# pragma mark - Low Level Dirtify / Undirtify

- (void)testItUndirtifyObject {
    id syncableObjectMock = [OCMockObject niceMockForProtocol:@protocol(AQSyncableObject)];
    
    [[syncableObjectMock expect] setAq_isDirty:@NO];
    
    [[AQSyncableObjectCoordinator coordinator] undirtifySyncableObject:syncableObjectMock];
    
    [syncableObjectMock verify];
}

# pragma mark - Should Update For Merging Delta

- (void)testItShouldUpdateForMergingDeltaIfDeltaTimestampIsEqual {
    id syncableObjectMock = [OCMockObject niceMockForProtocol:@protocol(AQSyncableObject)];
    OCMStub([syncableObjectMock aq_localTimestamp]).andReturn(@(1));
    AQDelta *delta = @{
                       @"aq_localTimestamp": @(1)
                       };
    
    XCTAssertTrue([[AQSyncableObjectCoordinator coordinator] shouldUpdateObjectForMergingData:syncableObjectMock withDelta:delta]);
}

- (void)testItShouldUpdateForMergingDeltaIfDeltaTimestampIsBigger {
    id syncableObjectMock = [OCMockObject niceMockForProtocol:@protocol(AQSyncableObject)];
    OCMStub([syncableObjectMock aq_localTimestamp]).andReturn(@(1));
    AQDelta *delta = @{
                       @"aq_localTimestamp": @(2)
                       };
    
    XCTAssertTrue([[AQSyncableObjectCoordinator coordinator] shouldUpdateObjectForMergingData:syncableObjectMock withDelta:delta]);
}

- (void)testItShouldNotUpdateForMergingDeltaIfDeltaTimestampIsSmaller {
    id syncableObjectMock = [OCMockObject niceMockForProtocol:@protocol(AQSyncableObject)];
    OCMStub([syncableObjectMock aq_localTimestamp]).andReturn(@(1));
    AQDelta *delta = @{
                       @"aq_localTimestamp": @(0)
                       };
    
    XCTAssertFalse([[AQSyncableObjectCoordinator coordinator] shouldUpdateObjectForMergingData:syncableObjectMock withDelta:delta]);
}

# pragma mark - Should Update For Marking As Pushed

- (void)testItShouldUpdateForMarkingAsPushedIfDeltaTimestampIsEqual {
    id syncableObjectMock = [OCMockObject niceMockForProtocol:@protocol(AQSyncableObject)];
    OCMStub([syncableObjectMock aq_localTimestamp]).andReturn(@(1));
    AQDelta *delta = @{
                       @"aq_localTimestamp": @(1)
                       };
    
    XCTAssertTrue([[AQSyncableObjectCoordinator coordinator] shouldUpdateObjectForMarkingAsPushed:syncableObjectMock withDelta:delta]);
}

- (void)testItShouldUpdateForMarkingAsPushedIfDeltaTimestampIsBigger {
    id syncableObjectMock = [OCMockObject niceMockForProtocol:@protocol(AQSyncableObject)];
    OCMStub([syncableObjectMock aq_localTimestamp]).andReturn(@(1));
    AQDelta *delta = @{
                       @"aq_localTimestamp": @(2)
                       };
    
    XCTAssertTrue([[AQSyncableObjectCoordinator coordinator] shouldUpdateObjectForMarkingAsPushed:syncableObjectMock withDelta:delta]);
}

- (void)testItShouldNotUpdateForMarkingAsPushedIfDeltaTimestampIsSmaller {
    id syncableObjectMock = [OCMockObject niceMockForProtocol:@protocol(AQSyncableObject)];
    OCMStub([syncableObjectMock aq_localTimestamp]).andReturn(@(1));
    AQDelta *delta = @{
                       @"aq_localTimestamp": @(0)
                       };
    
    XCTAssertFalse([[AQSyncableObjectCoordinator coordinator] shouldUpdateObjectForMarkingAsPushed:syncableObjectMock withDelta:delta]);
}

# pragma mark - Soft Deletion

- (void)testItMarkAsDeleteObject {
    id syncableObjectMock = [OCMockObject niceMockForProtocol:@protocol(AQSyncableObject)];
    
    [[syncableObjectMock expect] setAq_isDeleted:@YES];
    
    [[AQSyncableObjectCoordinator coordinator] markAsDeleteObject:syncableObjectMock];
    
    [syncableObjectMock verify];
}

# pragma mark - Dirtyify / Undirtify

- (void)testItDirtifyObject {
    id syncableObjectMock = [OCMockObject niceMockForProtocol:@protocol(AQSyncableObject)];
    
    [[syncableObjectMock expect] setAq_isDirty:@YES];
    [[syncableObjectMock expect] setAq_localTimestamp:[OCMArg checkWithBlock:^BOOL(NSNumber *obj) {
        return [obj unsignedIntegerValue] > 1000000000;
    }]];
    
    [[AQSyncableObjectCoordinator coordinator] dirtifySyncableObject:syncableObjectMock];
    
    [syncableObjectMock verify];
}

- (void)testItUndirtifyObjectIfNotUpdated {
    id syncableObjectMock = [OCMockObject niceMockForProtocol:@protocol(AQSyncableObject)];
    AQDelta *delta = @{
                       @"aq_localTimestamp": @(1)
                       };
    OCMStub([syncableObjectMock aq_localTimestamp]).andReturn(@(1));
    
    [[syncableObjectMock expect] setAq_isDirty:@NO];
    
    [[AQSyncableObjectCoordinator coordinator] undirtifySyncableObjectIfNotUpdated:syncableObjectMock withDelta:delta];

    [syncableObjectMock verify];
}

- (void)testItShouldNotUndirtifyObjectIfUpdated {
    id syncableObjectMock = [OCMockObject niceMockForProtocol:@protocol(AQSyncableObject)];
    AQDelta *delta = @{
                       @"aq_localTimestamp": @(1)
                       };
    OCMStub([syncableObjectMock aq_localTimestamp]).andReturn(@(2));
    
    [[syncableObjectMock reject] setAq_isDirty:@NO];
    
    [[AQSyncableObjectCoordinator coordinator] undirtifySyncableObjectIfNotUpdated:syncableObjectMock withDelta:delta];
    
    [syncableObjectMock verify];
}

@end
