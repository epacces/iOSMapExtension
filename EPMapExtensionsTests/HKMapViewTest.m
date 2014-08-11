//
//  EPMapViewTest.m
//  iOSMapExtension
//
//  Created by epacces on 7/8/13.
//  Copyright (c) 2013 it.hepakkes. All rights reserved.
//

#import "HKMapViewTest.h"
#import "HKMapView.h"
#import "utils.h"
#import <QuartzCore/QuartzCore.h>

#import "HKTestAnnotation.h"
#import "HKPointOfInterest.h"

@implementation HKMapViewTest {
    HKMapView *_mapView;
    MKMapView *_innerMapView;
    NSArray *_testAnnotations;
    NSArray *_poiAnnotations;
}

- (void)setUp
{
    _mapView = [[HKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    _innerMapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    _testAnnotations = @[
                         [[HKTestAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake(45.11, 7.67)
                                                    addressDictionary:nil],
                         [[HKTestAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake(45.08, 7.67)
                                                    addressDictionary:nil],
                         ];
    _poiAnnotations = @[
                        [[HKPointOfInterest alloc] initWithCoordinate:CLLocationCoordinate2DMake(46.12, 8.98)],
                        ];
}

- (void)testMapViewInitializationWithFrame
{
    XCTAssertTrue(CGRectEqualToRect(_mapView.frame, CGRectMake(0, 0, 320, 480)), @"mapView's frame should be {0, 0, 320, 480}");
}

- (void)testMapViewInializationWithMap
{
    HKMapView *mapView = [[HKMapView alloc] initWithMapView:_innerMapView];
    XCTAssertTrue(CGRectEqualToRect(mapView.frame, CGRectMake(0, 0, 320, 480)), @"mapView's frame should be {0, 0, 320, 480}");
}

- (void)testMapViewGetCenteredRegionWithNoAnnotationsInMap
{
    MKCoordinateRegion region = [_mapView region];
    MKCoordinateRegion centeredRegion = [_mapView centeredRegion];
    
    XCTAssertTrue( EPCoordinateRegionIsEqual(region, centeredRegion), @"centered region should be equal to the mapView visible region");
}

- (void)testMapViewGetCenteredRegionForAllAnnotations
{

    [_mapView addAnnotation:_testAnnotations[0]];
    [_mapView addAnnotation:_testAnnotations[1]];
    
    MKCoordinateRegion expectedCenteredRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake((45.11 + 45.08) / 2, 7.67),
                                                                       MKCoordinateSpanMake(45.11 - 45.08, 0));
    MKCoordinateRegion centeredRegion = [_mapView centeredRegion];
    
    XCTAssertTrue(EPCoordinateRegionIsEqual(centeredRegion, expectedCenteredRegion), @"centered region should be centered around expectedCenteredRegion");
}

- (void)testMapViewGetCenteredRegionForAnnotationConformingToProtocol
{
    [_mapView addAnnotation:_testAnnotations[0]];
    [_mapView addAnnotation:_testAnnotations[1]];
    [_mapView addAnnotation:_poiAnnotations[0]];
    
    MKCoordinateRegion expectedCenteredRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake((45.11 + 45.08) / 2, 7.67),
                                                                       MKCoordinateSpanMake(45.11 - 45.08, 0));
    MKCoordinateRegion centeredRegion = [_mapView centeredRegionForAnnotationConformingToProtocol:@protocol(HKAnnotation)];
    
    XCTAssertTrue(EPCoordinateRegionIsEqual(centeredRegion, expectedCenteredRegion), @"centered region should be centered around expectedCenteredRegion");
}

- (void)testMapViewGetCenteredRegionForAnnotationConformingProtocolReturningAnEmptyArray
{
    [_mapView addAnnotation:_testAnnotations[0]];
    [_mapView addAnnotation:_testAnnotations[1]];
    [_mapView addAnnotation:_poiAnnotations[0]];
    
    MKCoordinateRegion expectedCenteredRegion = [_mapView region];
    MKCoordinateRegion centeredRegion = [_mapView centeredRegionForAnnotationConformingToProtocol:nil];
    
    XCTAssertTrue(EPCoordinateRegionIsEqual(centeredRegion, expectedCenteredRegion), @"centered region should be centered around expectedCenteredRegion");
}

- (void)testMapViewGetCenteredRegionForAnnotationOfKindOfClass
{    
    [_mapView addAnnotation:_testAnnotations[0]];
    [_mapView addAnnotation:_testAnnotations[1]];
    [_mapView addAnnotation:_poiAnnotations[0]];
    
    MKCoordinateRegion expectedCenteredRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake((45.11 + 45.08) / 2, 7.67),
                                                                       MKCoordinateSpanMake(45.11 - 45.08, 0));
    MKCoordinateRegion centeredRegion = [_mapView centeredRegionForAnnotationOfKindOfClass:[HKTestAnnotation class]];
    
    XCTAssertTrue(EPCoordinateRegionIsEqual(centeredRegion, expectedCenteredRegion), @"centered region should be centered around expectedCenteredRegion");
}

- (void)testMapViewGetCenteredRegionForAnnotationOfKindOfClassReturningAnEmptyArray
{
    [_mapView addAnnotation:_testAnnotations[0]];
    [_mapView addAnnotation:_testAnnotations[1]];
    [_mapView addAnnotation:_poiAnnotations[0]];
    
    MKCoordinateRegion expectedCenteredRegion = [_mapView region];
    MKCoordinateRegion centeredRegion = [_mapView centeredRegionForAnnotationOfKindOfClass:nil];
    
    XCTAssertTrue(EPCoordinateRegionIsEqual(centeredRegion, expectedCenteredRegion), @"centered region should be centered around expectedCenteredRegion");
}

- (void)testMapViewGetVisibleAnnotation
{
    [_mapView addAnnotation:_testAnnotations[0]];
    [_mapView addAnnotation:_testAnnotations[1]];
    [_mapView addAnnotation:_poiAnnotations[0]];
    
    [_mapView setRegion:[_mapView centeredRegion]];
    
    XCTAssertTrue([_mapView visibleAnnotations] == 3, @"the visibleAnnotation within the visible mapView region should be 3");
}

- (void)testMapViewGetVisibleAnnotationConformingToProtocol
{
    [_mapView addAnnotation:_testAnnotations[0]];
    [_mapView addAnnotation:_testAnnotations[1]];
    [_mapView addAnnotation:_poiAnnotations[0]];
    
    [_mapView setRegion:[_mapView centeredRegion]];
    
    XCTAssertTrue([_mapView visibleAnnotationsConformingToProtocol:@protocol(HKAnnotation)] == 2,
                 @"the visibleAnnotation within the visible mapView region should be 2");
}

- (void)testMapViewGetVisibleAnnotationConformingToProtocolReturningAnEmptySet
{
    [_mapView addAnnotation:_testAnnotations[0]];
    [_mapView addAnnotation:_testAnnotations[1]];
    [_mapView addAnnotation:_poiAnnotations[0]];
    
    [_mapView setRegion:[_mapView centeredRegion]];
    
    XCTAssertTrue([_mapView visibleAnnotationsConformingToProtocol:nil] == 0,
                 @"the visibleAnnotation within the visible mapView region should be 0");
}

- (void)testMapViewGetVisibleAnnotationConformingToRootProtocol
{
    [_mapView addAnnotation:_testAnnotations[0]];
    [_mapView addAnnotation:_testAnnotations[1]];
    [_mapView addAnnotation:_poiAnnotations[0]];
    
    [_mapView setRegion:[_mapView centeredRegion]];
    
    XCTAssertTrue([_mapView visibleAnnotationsConformingToProtocol:@protocol(MKAnnotation)] == 3,
                 @"the visibleAnnotation within the visible mapView region should be 3");
}

- (void)testMapRemoveAllAnnotations
{
    [_mapView addAnnotation:_testAnnotations[0]];
    [_mapView addAnnotation:_testAnnotations[1]];
    [_mapView addAnnotation:_poiAnnotations[0]];

    XCTAssertTrue([[_mapView annotations] count], @"annotation count should be 0");
}

- (void)testMapRemoveAnnotationsConformingToProtocol
{
    [_mapView addAnnotation:_testAnnotations[0]];
    [_mapView addAnnotation:_testAnnotations[1]];
    [_mapView addAnnotation:_poiAnnotations[0]];

    [_mapView removeAnnotationsConformingToProtocol:@protocol(HKAnnotation)];
    
    XCTAssertTrue([[_mapView annotations] count] == 1, @"mapView should contain only one annotation");
    
}

- (void)testMapRemoveAnnotationsConformingToProtocols
{
    [_mapView addAnnotation:_testAnnotations[0]];
    [_mapView addAnnotation:_testAnnotations[1]];
    [_mapView addAnnotation:_poiAnnotations[0]];
    
    [_mapView removeAnnotationsConformingToProtocols:@[@protocol(HKAnnotation)]];
    
    XCTAssertTrue([[_mapView annotations] count] == 1, @"mapView should contain only one annotation");
}

- (void)testMapRemoveAnnotationsOfKindOfClass
{
    [_mapView addAnnotation:_testAnnotations[0]];
    [_mapView addAnnotation:_testAnnotations[1]];
    [_mapView addAnnotation:_poiAnnotations[0]];
    
    [_mapView removeAnnotationsOfKindOfClass:[HKTestAnnotation class]];
    
    XCTAssertTrue([[_mapView annotations] count] == 1, @"mapView should contain only one annotation");
    XCTAssertTrue([[_mapView annotations][0] isKindOfClass:[HKPointOfInterest class]], @"should contain only EPPointOfInterest class");
}

- (void)testMapRemoveAnnotationsOfKindOfClasses
{
    [_mapView addAnnotation:_testAnnotations[0]];
    [_mapView addAnnotation:_testAnnotations[1]];
    [_mapView addAnnotation:_poiAnnotations[0]];
    
    [_mapView removeAnnotationsOfKindOfClasses:@[[HKTestAnnotation class]]];
    
    XCTAssertTrue([[_mapView annotations] count] == 1, @"mapView should contain only one annotation");
    XCTAssertTrue([[_mapView annotations][0] isKindOfClass:[HKPointOfInterest class]], @"should contain only EPPointOfInterest class");
}

@end
