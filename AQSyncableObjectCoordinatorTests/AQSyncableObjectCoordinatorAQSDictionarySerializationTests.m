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

- (void)testItAppliesPatch {
    AQTestBook *book = [[AQTestBook alloc] init];
    AQDelta *delta = @{
                       @"aq_deviceToken": @"devicetoken"
                       };
    
    AQTestBook *patchAppliedBook = [[AQSyncableObjectCoordinator coordinator] patchAppliedObjectWithSyncableObject:book withDelta:delta];
    
    XCTAssertTrue([patchAppliedBook.aq_deviceToken isEqualToString:@"devicetoken"]);
}

@end
