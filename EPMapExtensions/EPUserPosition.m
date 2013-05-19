//
//  EPUserPosition.m
//  iOSMapExtension
//
//  Created by epacces on 5/6/13.
//  Copyright (c) 2013 it.reply. All rights reserved.
//

#import "EPUserPosition.h"

@implementation EPUserPosition

const CLLocationDistance TSMinimumDefaultThresholdToUpdateUserPosition = 100.f;

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
    if([newUserPosition horizontalAccuracy] > 0 && [newUserPosition horizontalAccuracy] < _minThresholdToUpdatePosition) {
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

@end