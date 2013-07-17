//
//  EPUserPosition.h
//  iOSMapExtension
//
//  Created by epacces on 5/6/13.
//  Copyright (c) 2013 it.hepakkes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

/**
 `EPUserPosition` represent the user location
 */

@interface EPUserPosition : NSObject {
    CLLocation          *_userPosition;
}


///-------------------------------------------------
/// @name  Creating object
///-------------------------------------------------

/**
 Initialize the object with the specified user location
 
 @param userLocation Takes a valid user location
 
 */

- (id)initWithUserPosition:(CLLocation *)userLocation;

///-------------------------------------------------
/// @name Updating user position
///-------------------------------------------------

/**
 Updates the user location with a new valid one provided that it is a valid location far away at least `minThresholdToUpdatePosition` meters from the old position
 
 @param newUserLocation New acquired user location
 */

- (void)updatePosition:(CLLocation *)newUserLocation;


///-------------------------------------------------
/// @name Position updating property
///-------------------------------------------------

/**
 Minimum threshold to get the user position updated
 */

@property (nonatomic)           CLLocationDistance  minThresholdToUpdatePosition; //meters


///-------------------------------------------------
/// @name User position properties
///-------------------------------------------------


/**
 Contains the last valid user position
 */

@property (nonatomic, readonly) CLLocation          *userPosition;  //contains the last valid user position

/**
 Contains the timestamp of the last valid user position
 */

@property (nonatomic, readonly) NSDate              *lastValidPositionDate;


/**
 Latitude and longitude relevant to the user position
 */

@property (nonatomic, readonly) CLLocationCoordinate2D  coordinate;

@end

///-------------------------------------------------
/// @name Default constants
///-------------------------------------------------

/**
 Default threshold
 */

extern const CLLocationDistance TSMinimumDefaultThresholdToUpdateUserPosition; // 100m
