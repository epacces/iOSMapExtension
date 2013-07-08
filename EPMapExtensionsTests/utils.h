//
//  utils.h
//  iOSMapExtension
//
//  Created by epacces on 7/8/13.
//  Copyright (c) 2013 it.reply. All rights reserved.
//

#ifndef iOSMapExtension_utils_h
#define iOSMapExtension_utils_h

#define ARC4RANDOM_MAX      0x100000000

static inline double RAND_IN_RANGE(double min, double max) {
    return min + ((double) arc4random() / ARC4RANDOM_MAX) * (max - min) ;
}

static inline CLLocationCoordinate2D EPRandomLocationCoordinateMake(void) {
    return CLLocationCoordinate2DMake(RAND_IN_RANGE(-90, 90), RAND_IN_RANGE(-180, 180));
}

static inline CLLocationCoordinate2D EPRandomLocationCoordinateInRangeMake(CLLocationDegrees latitude, CLLocationDegrees longitude) {
    return CLLocationCoordinate2DMake(RAND_IN_RANGE(-latitude, latitude), RAND_IN_RANGE(-longitude, longitude));
}

static inline BOOL EPCoordinateRegionIsEqual(MKCoordinateRegion firstRegion, MKCoordinateRegion secondRegion) {
    return (firstRegion.center.longitude == secondRegion.center.longitude && firstRegion.center.latitude == secondRegion.center.latitude
            && firstRegion.span.longitudeDelta == secondRegion.span.longitudeDelta && firstRegion.span.latitudeDelta == secondRegion.span.latitudeDelta);
    
}

#endif
