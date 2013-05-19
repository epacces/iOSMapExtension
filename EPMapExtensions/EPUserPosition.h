//
//  EPUserPosition.h
//  iOSMapExtension
//
//  Created by epacces on 5/6/13.
//  Copyright (c) 2013 it.reply. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface EPUserPosition : NSObject {
    CLLocation          *_userPosition;
}

- (id)initWithUserPosition:(CLLocation *)userLocation;

- (void)updatePosition:(CLLocation *)newUserLocation;

@property (nonatomic, readonly) CLLocation          *userPosition;  //contains the last valid user position
@property (nonatomic)           CLLocationDistance  minThresholdToUpdatePosition; //meters
@property (nonatomic, readonly) NSDate              *lastValidPositionDate; //
@property (nonatomic, readonly) CLLocationCoordinate2D  coordinate;

@end

extern const CLLocationDistance TSMinimumDefaultThresholdToUpdateUserPosition;