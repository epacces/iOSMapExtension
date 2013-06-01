//
//  EPUserPosition.h
//  iOSMapExtension
//
//  Created by epacces on 5/6/13.
//  Copyright (c) 2013 it.reply. All rights reserved.
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
///  Creating object
///-------------------------------------------------

/**
 @param userLocation Takes the user location
 */

- (id)initWithUserPosition:(CLLocation *)userLocation;

///-------------------------------------------------
///  Updating user position
///-------------------------------------------------

/**
 Takes the fresh user position
 @param newUserLocation New acquired user location
 */

- (void)updatePosition:(CLLocation *)newUserLocation;

/**
 Contains the last valid user position
 */

@property (nonatomic, readonly) CLLocation          *userPosition;  //contains the last valid user position

/**
 Contains the timestamp of the last valid user position
 */

@property (nonatomic, readonly) NSDate              *lastValidPositionDate;

/**
 
 */

@property (nonatomic)           CLLocationDistance  minThresholdToUpdatePosition; //meters

@property (nonatomic, readonly) CLLocationCoordinate2D  coordinate;

@end

extern const CLLocationDistance TSMinimumDefaultThresholdToUpdateUserPosition;