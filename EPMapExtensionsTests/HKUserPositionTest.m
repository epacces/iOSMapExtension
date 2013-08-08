//
//  EPUserPositionTest.m
//  iOSMapExtension
//
//  Created by epacces on 7/5/13.
//  Copyright (c) 2013 it.hepakkes. All rights reserved.
//

#import "HKUserPositionTest.h"
#import "HKUserPosition.h"

@implementation HKUserPositionTest {
    CLLocation     *_simulatedUserLocation;
    HKUserPosition *_simulatedUserPosition;
}


- (void)testInitWithValidUserPosition
{
    _simulatedUserLocation = [[CLLocation alloc] initWithLatitude:45.11 longitude:7.67];
    _simulatedUserPosition = [[HKUserPosition alloc] initWithUserPosition:_simulatedUserLocation];
    
    //get coordinates
    CLLocationCoordinate2D coord1 = _simulatedUserLocation.coordinate;
    CLLocationCoordinate2D coord2 = _simulatedUserPosition.coordinate;
    
    STAssertEquals(coord1.latitude, coord2.latitude, @"latitudes should be equal");
    STAssertEquals(coord1.longitude, coord2.longitude, @"latitudes should be equal");
}

- (void)testInitWithInvalidUserPosition
{
    _simulatedUserLocation = [[CLLocation alloc] initWithLatitude:12323.11 longitude:212812.67];
    _simulatedUserPosition = [[HKUserPosition alloc] initWithUserPosition:_simulatedUserLocation];
    
    //get coordinates
    CLLocationCoordinate2D coord1 = _simulatedUserLocation.coordinate;
    CLLocationCoordinate2D coord2 = _simulatedUserPosition.coordinate;
    
    STAssertTrue(coord1.latitude != coord2.latitude && coord1.longitude != coord2.longitude, @"latitudes and longitudes should be different");
    STAssertTrue(coord2.latitude == 0 && coord2.longitude == 0, @"latitudes & longitude should be zero");
}

- (void)testUpdateUserPositionWithValidPosition
{
    _simulatedUserLocation = [[CLLocation alloc] initWithLatitude:12323.11 longitude:212812.67];
    _simulatedUserPosition = [[HKUserPosition alloc] initWithUserPosition:_simulatedUserLocation];
    
    [_simulatedUserPosition updatePosition:[[CLLocation alloc] initWithLatitude:45.11 longitude:7.67]];
    
    STAssertTrue(_simulatedUserPosition.coordinate.longitude == 7.67 && _simulatedUserPosition.coordinate.latitude == 45.11,
                 @"latitude should be 45.11 and logitude should be 7.67");

}

- (void)testUpdateUserPositionWithInvalidPosition
{
    _simulatedUserLocation = [[CLLocation alloc] initWithLatitude:45.11 longitude:7.67];
    _simulatedUserPosition = [[HKUserPosition alloc] initWithUserPosition:_simulatedUserLocation];
    
    [_simulatedUserPosition updatePosition:[[CLLocation alloc] initWithLatitude:1232432.4343 longitude:-212331.3]];
    
    STAssertTrue(_simulatedUserPosition.coordinate.longitude == 7.67 && _simulatedUserPosition.coordinate.latitude == 45.11,
                 @"latitude should be 45.11 and logitude should be 7.67");
    
}

- (void)testUpdateUserPositionWithValidPositionBelowThreshold
{
    _simulatedUserLocation = [[CLLocation alloc] initWithLatitude:45.11 longitude:7.67];
    _simulatedUserPosition = [[HKUserPosition alloc] initWithUserPosition:_simulatedUserLocation];
    
    _simulatedUserPosition.minThresholdToUpdatePosition = 2000.0;
    
    [_simulatedUserPosition updatePosition:[[CLLocation alloc] initWithLatitude:45.1112 longitude:7.67014]];
    
    STAssertTrue(_simulatedUserPosition.coordinate.longitude == 7.67 && _simulatedUserPosition.coordinate.latitude == 45.11,
                 @"latitude should be 45.11 and logitude should be 7.67");
}

- (void)testUpdateUserPositionWithValidPositionBeyondThreshold
{
    _simulatedUserLocation = [[CLLocation alloc] initWithLatitude:45.11 longitude:7.67];
    _simulatedUserPosition = [[HKUserPosition alloc] initWithUserPosition:_simulatedUserLocation];
    
    _simulatedUserPosition.minThresholdToUpdatePosition = 2000.0;
    
    [_simulatedUserPosition updatePosition:[[CLLocation alloc] initWithLatitude:45.1812 longitude:7.67014]];
    
    STAssertTrue(_simulatedUserPosition.coordinate.longitude == 7.67014 && _simulatedUserPosition.coordinate.latitude == 45.1812,
                 @"latitude should be 45.11 and logitude should be 7.67");
}

@end
