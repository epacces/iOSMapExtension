//
//  EPMapViewTest.m
//  iOSMapExtension
//
//  Created by epacces on 7/8/13.
//  Copyright (c) 2013 it.reply. All rights reserved.
//

#import "EPMapViewTest.h"
#import "EPMapView.h"
#import "utils.h"
#import <QuartzCore/QuartzCore.h>

#import "EPTestAnnotation.h"
#import "EPPointOfInterest.h"

@implementation EPMapViewTest {
    EPMapView *_mapView;
    MKMapView *_innerMapView;
}

- (void)setUp
{
    _mapView = [[EPMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    _innerMapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
}

- (void)testMapViewInitializationWithFrame
{
    STAssertTrue(CGRectEqualToRect(_mapView.frame, CGRectMake(0, 0, 320, 480)), @"mapView's frame should be {0, 0, 320, 480}");
}

- (void)testMapViewInializationWithMap
{
    EPMapView *mapView = [[EPMapView alloc] initWithMapView:_innerMapView];
    STAssertTrue(CGRectEqualToRect(mapView.frame, CGRectMake(0, 0, 320, 480)), @"mapView's frame should be {0, 0, 320, 480}");
}

- (void)testMapViewGetCenteredRegionWithNoAnnotationsInMap
{
    MKCoordinateRegion region = [_mapView region];
    MKCoordinateRegion centeredRegion = [_mapView centeredRegion];
    
    STAssertTrue( EPCoordinateRegionIsEqual(region, centeredRegion), @"centered region should be equal to the mapView visible region");
}

- (void)testMapViewGetCenteredRegionForAllAnnotations
{

    EPTestAnnotation *firstAnnotation = [[EPTestAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake(45.11, 7.67)
                                                                   addressDictionary:nil];
    EPTestAnnotation *secondAnnotation = [[EPTestAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake(45.08, 7.67)
                                                                    addressDictionary:nil];
    
    [_mapView addAnnotation:firstAnnotation];
    [_mapView addAnnotation:secondAnnotation];
    
    MKCoordinateRegion expectedCenteredRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake((45.11 + 45.08)/2, 7.67),
                                                                       MKCoordinateSpanMake(45.11 - 45.08, 0));
    MKCoordinateRegion centeredRegion = [_mapView centeredRegion];
    
    STAssertTrue(EPCoordinateRegionIsEqual(centeredRegion, expectedCenteredRegion), @"centered region should be centered around expectedCenteredRegion");
}

- (void)testMapViewGetCenteredRegionForAnnotationConformingToProtocol
{
    EPTestAnnotation *firstAnnotation = [[EPTestAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake(45.11, 7.67)
                                                                   addressDictionary:nil];
    EPTestAnnotation *secondAnnotation = [[EPTestAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake(45.08, 7.67)
                                                                    addressDictionary:nil];
    EPPointOfInterest *thirdAnnotation = [[EPPointOfInterest alloc] initWithCoordinate:CLLocationCoordinate2DMake(46.12, 8.98)];
    
    [_mapView addAnnotation:firstAnnotation];
    [_mapView addAnnotation:secondAnnotation];
    [_mapView addAnnotation:thirdAnnotation];
    
    MKCoordinateRegion expectedCenteredRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake((45.11 + 45.08)/2, 7.67),
                                                                       MKCoordinateSpanMake(45.11 - 45.08, 0));
    MKCoordinateRegion centeredRegion = [_mapView centeredRegionForAnnotationConformingToProtocol:@protocol(EPAnnotation)];
    
    STAssertTrue(EPCoordinateRegionIsEqual(centeredRegion, expectedCenteredRegion), @"centered region should be centered around expectedCenteredRegion");
}

- (void)testMapViewGetCenteredRegionForAnnotationConformingProtocolReturningAnEmptyArray
{
    EPTestAnnotation *firstAnnotation = [[EPTestAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake(45.11, 7.67)
                                                                   addressDictionary:nil];
    EPTestAnnotation *secondAnnotation = [[EPTestAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake(45.08, 7.67)
                                                                    addressDictionary:nil];
    EPPointOfInterest *thirdAnnotation = [[EPPointOfInterest alloc] initWithCoordinate:CLLocationCoordinate2DMake(46.12, 8.98)];
    
    [_mapView addAnnotation:firstAnnotation];
    [_mapView addAnnotation:secondAnnotation];
    [_mapView addAnnotation:thirdAnnotation];
    
    MKCoordinateRegion expectedCenteredRegion = [_mapView region];
    MKCoordinateRegion centeredRegion = [_mapView centeredRegionForAnnotationConformingToProtocol:nil];
    
    STAssertTrue(EPCoordinateRegionIsEqual(centeredRegion, expectedCenteredRegion), @"centered region should be centered around expectedCenteredRegion");
}

- (void)testMapViewGetCenteredRegionForAnnotationOfKindOfClass
{
    EPTestAnnotation *firstAnnotation = [[EPTestAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake(45.11, 7.67)
                                                                   addressDictionary:nil];
    EPTestAnnotation *secondAnnotation = [[EPTestAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake(45.08, 7.67)
                                                                    addressDictionary:nil];
    EPPointOfInterest *thirdAnnotation = [[EPPointOfInterest alloc] initWithCoordinate:CLLocationCoordinate2DMake(46.12, 8.98)];
    
    [_mapView addAnnotation:firstAnnotation];
    [_mapView addAnnotation:secondAnnotation];
    [_mapView addAnnotation:thirdAnnotation];
    
    MKCoordinateRegion expectedCenteredRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake((45.11 + 45.08)/2, 7.67),
                                                                       MKCoordinateSpanMake(45.11 - 45.08, 0));
    MKCoordinateRegion centeredRegion = [_mapView centeredRegionForAnnotationOfKindOfClass:[EPTestAnnotation class]];
    
    STAssertTrue(EPCoordinateRegionIsEqual(centeredRegion, expectedCenteredRegion), @"centered region should be centered around expectedCenteredRegion");
}

- (void)testMapViewGetCenteredRegionForAnnotationOfKindOfClassReturningAnEmptyArray
{
    EPTestAnnotation *firstAnnotation = [[EPTestAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake(45.11, 7.67)
                                                                   addressDictionary:nil];
    EPTestAnnotation *secondAnnotation = [[EPTestAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake(45.08, 7.67)
                                                                    addressDictionary:nil];
    EPPointOfInterest *thirdAnnotation = [[EPPointOfInterest alloc] initWithCoordinate:CLLocationCoordinate2DMake(46.12, 8.98)];
    
    [_mapView addAnnotation:firstAnnotation];
    [_mapView addAnnotation:secondAnnotation];
    [_mapView addAnnotation:thirdAnnotation];
    
    MKCoordinateRegion expectedCenteredRegion = [_mapView region];
    MKCoordinateRegion centeredRegion = [_mapView centeredRegionForAnnotationOfKindOfClass:nil];
    
    STAssertTrue(EPCoordinateRegionIsEqual(centeredRegion, expectedCenteredRegion), @"centered region should be centered around expectedCenteredRegion");
}


@end
