//
//  EPPointOfInterest.h
//  iOSMapExtension
//
//  Created by epacces on 5/7/13.
//  Copyright (c) 2013 it.hepakkes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

/**
 `EPPointOfInterest` represent an annotation object responding to `MKAnnotation` protocol
 */

@interface EPPointOfInterest : NSObject <MKAnnotation, NSCopying>

///-----------------------------------------------------
/// @name Creation
///-----------------------------------------------------


/**
 @param coordinate Point of interest coordinate
 */
- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate;

/**
 Coordinate of the point of interest
 */

@property (readonly) CLLocationCoordinate2D coordinate;

@end


@interface EPPointOfInterest (EPDraggablePointOfInterest)

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;

@end