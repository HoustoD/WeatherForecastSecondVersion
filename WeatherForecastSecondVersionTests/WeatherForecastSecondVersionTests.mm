//
//  WeatherForecastSecondVersionTests.m
//  WeatherForecastSecondVersionTests
//
//  Created by Анюта on 11.08.18.
//  Copyright © 2018 Roman. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GetDate.h"

@interface WeatherForecastSecondVersionTests : XCTestCase

@end

@implementation WeatherForecastSecondVersionTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    GetDate *date = GetDate::Instance();
    NSString *testDate = [NSString alloc];
    NSString *rightDate = [NSString alloc];
    
    rightDate = @"1999-00-05";
    testDate = date->checkDate(1999, 0, 5);
    
    XCTAssertEqualObjects(testDate, rightDate);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
