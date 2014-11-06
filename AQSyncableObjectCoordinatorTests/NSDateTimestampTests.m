//
//  NSDateTimestampTests.m
//  AQSyncableObjectCoordinator
//
//  Created by kaiinui on 2014/11/06.
//  Copyright (c) 2014年 Aquamarine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "NSDate+Timestamp.h"

@interface NSDateTimestampTests : XCTestCase

@end

@implementation NSDateTimestampTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testItReturnsTimestamp {
    NSUInteger timestamp = [[NSDate date] timestamp];
    
    // Thu, 06 Nov 2014 14:28:33 GMT
    //  to
    // Tue, 19 Jan 2038 03:14:07 GMT
    XCTAssertTrue(timestamp > 1415284113 && timestamp < 2147483647);
}

@end
