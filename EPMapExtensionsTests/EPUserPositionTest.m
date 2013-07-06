//
//  EPUserPositionTest.m
//  iOSMapExtension
//
//  Created by epacces on 7/5/13.
//  Copyright (c) 2013 it.reply. All rights reserved.
//

#import "EPUserPositionTest.h"
#import "EPUserPosition.h"

@implementation EPUserPositionTest {
    CLLocation     *_simulatedUserLocation;
    EPUserPosition *_simulatedUserPosition;
}


- (void)testInitWithValidUserPosition
{
    _simulatedUserLocation = [[CLLocation alloc] initWithLatitude:45.11 longitude:7.67];
    _simulatedUserPosition = [[EPUserPosition alloc] initWithUserPosition:_simulatedUserLocation];
    
    //get coordinates
    CLLocationCoordinate2D coord1 = _simulatedUserLocation.coordinate;
    CLLocationCoordinate2D coord2 = _simulatedUserPosition.coordinate;
    
    STAssertEquals(coord1.latitude, coord2.latitude, @"latitudes should be equal");
    STAssertEquals(coord1.longitude, coord2.longitude, @"latitudes should be equal");
}

- (void)testInitWithInvalidUserPosition
{
    _simulatedUserLocation = [[CLLocation alloc] initWithLatitude:12323.11 longitude:212812.67];
    _simulatedUserPosition = [[EPUserPosition alloc] initWithUserPosition:_simulatedUserLocation];
    
    //get coordinates
    CLLocationCoordinate2D coord1 = _simulatedUserLocation.coordinate;
    CLLocationCoordinate2D coord2 = _simulatedUserPosition.coordinate;
    
    STAssertEquals(coord1.latitude, coord2.latitude, @"latitudes should be equal");
    STAssertEquals(coord1.longitude, coord2.longitude, @"latitudes should be equal");
}

- (void)testUpdateUserPositionWithValidPosition
{
    
}

- (void)testUpdateUserPositionWithInvalidPosition
{
    
}

- (void)testUpdateUserPositionWithValidPositionBelowThreshold
{
    
}


@end
