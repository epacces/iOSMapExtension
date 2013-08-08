//
//  EPPointOfInterest.m
//  iOSMapExtension
//
//  Created by epacces on 5/7/13.
//  Copyright (c) 2013 it.hepakkes. All rights reserved.
//

#import "HKPointOfInterest.h"

@implementation HKPointOfInterest

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    if (self = [super init]) {
        _coordinate = coordinate;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    HKPointOfInterest *newPOI = [[[self class] allocWithZone:zone] init];
    newPOI->_coordinate = _coordinate;
    return newPOI;
}

@end

@implementation HKPointOfInterest (EPDraggablePointOfInterest)

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate
{
    _coordinate = newCoordinate;
}

@end
