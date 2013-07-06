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

@implementation EPUserPosition

- (id)initWithUserPosition:(CLLocation *)userLocation
{
    if (self = [super init]) {
        _minThresholdToUpdatePosition = TSMinimumDefaultThresholdToUpdateUserPosition;
        _userPosition = userLocation;
    }
    return self;
}

- (void)updatePosition:(CLLocation *)newUserPosition
{
    if (!newUserPosition) return;
    if(isHorizontalAccuracyWithinARange(newUserPosition, _minThresholdToUpdatePosition)) {
        if ([newUserPosition distanceFromLocation:_userPosition] > _minThresholdToUpdatePosition)
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
            [newLocation distanceFromLocation:_userPosition] >= _minThresholdToUpdatePosition &&
            YES
            );
}

@end