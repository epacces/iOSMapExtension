//
//  EPPointOfInterest.m
//  iOSMapExtension
//
//  Created by epacces on 5/7/13.
//  Copyright (c) 2013 it.reply. All rights reserved.
//

#import "EPPointOfInterest.h"

@implementation EPPointOfInterest

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    if (self = [super init]) {
        _coordinate = coordinate;
    }
    return self;
}

@end
