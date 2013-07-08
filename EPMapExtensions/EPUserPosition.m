//
//  EPUserPosition.m
//  iOSMapExtension
//
//  Created by epacces on 5/6/13.
//  Copyright (c) 2013 it.reply. All rights reserved.
//

#import "EPUserPosition.h"

const CLLocationDistance TSMinimumDefaultThresholdToUpdateUserPosition = 100.f;

static inline BOOL isHorizontalAccuracyWithinARange(CLLocation *location, CLLocationDistance range)
{
    return location.horizontalAccuracy >= 0 && location.horizontalAccuracy <= range;
}

static inline BOOL isValidLocation(CLLocation *location)
{
    return location.horizontalAccuracy >= 0 && CLLocationCoordinate2DIsValid(location.coordinate);
}

@implementation EPUserPosition

- (id)initWithUserPosition:(CLLocation *)userLocation
{
    if (self = [super init]) {
        _minThresholdToUpdatePosition = TSMinimumDefaultThresholdToUpdateUserPosition;
        [self updatePosition:userLocation];
    }
    return self;
}

- (void)updatePosition:(CLLocation *)newUserPosition
{
    if (!isValidLocation(newUserPosition)) return;
    
    if (!_userPosition) {
        _userPosition = newUserPosition; 
    } else if([self locationNeedsUpdate:newUserPosition]){
        _userPosition = newUserPosition;
    }
}

- (CLLocation *)userPosition
{
    return [_userPosition copy];
}

- (NSDate *)lastValidPositionDate
{
    return [_userPosition timestamp];
}

- (CLLocationCoordinate2D)coordinate
{
    return [_userPosition coordinate];
}

- (BOOL)locationNeedsUpdate:(CLLocation *)newLocation
{
    return (isHorizontalAccuracyWithinARange(newLocation, _minThresholdToUpdatePosition) &&
            [newLocation distanceFromLocation:_userPosition] >= _minThresholdToUpdatePosition
            );
}

@end