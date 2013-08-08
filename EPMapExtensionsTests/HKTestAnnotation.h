//
//  EPTestAnnotation.h
//  iOSMapExtension
//
//  Created by Eriprando Pacces on 6/17/13.
//  Copyright (c) 2013 it.hepakkes. All rights reserved.
//

#import <MapKit/MapKit.h>

@protocol HKAnnotation

@property (nonatomic, copy)  NSString *telephoneNumber;

@end

@interface HKTestAnnotation : MKPlacemark <HKAnnotation>

@property (nonatomic, copy)  NSString *telephoneNumber;

@end
