//
//  EPAnnotationArrayTest.m
//  iOSMapExtension
//
//  Created by Eriprando Pacces on 5/20/13.
//  Copyright (c) 2013 it.hepakkes. All rights reserved.
//

#import "HKAnnotationArrayTest.h"
#import "HKAnnotationArray.h"
#import "HKPointOfInterest.h"
#import "HKTestAnnotation.h"

@implementation HKAnnotationArrayTest {
    HKAnnotationArray   *_annotationArray;
    HKPointOfInterest   *_poi;
    HKTestAnnotation    *_testAnnotation;
}

- (void)setUp
{
    _annotationArray = [[HKAnnotationArray alloc] init];
    _poi = [[HKPointOfInterest alloc] initWithCoordinate:CLLocationCoordinate2DMake(22, 22)];
    _testAnnotation = [[HKTestAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake(22, 24)
                                                                  addressDictionary:nil];
}

- (void)testInitWithAnnotationsConformingToMKAnnotationProtocol
{
    _annotationArray = [[HKAnnotationArray alloc] initWithAnnotationArray:@[_poi, _poi]];
    STAssertTrue([_annotationArray count] == 2, @"annotation array obj should contain 2 pois");
}

- (void)testInitWithAnnotationsNotConformingToMKAnnotationProtocol
{
    STAssertThrows((_annotationArray = [[HKAnnotationArray alloc] initWithAnnotationArray:@[_poi, @"test"]]),
                   @"should raise exception");
    STAssertTrue([_annotationArray count] == 0, @"annotation array should be nil");
}

- (void)testWithNilAnnoatationsCollection
{
    _annotationArray = [[HKAnnotationArray alloc] initWithAnnotationArray:nil];
    STAssertTrue(_annotationArray != nil, @"annotation array should have been allocated");
    STAssertTrue([_annotationArray count] == 0, @"annotation array should contain 0 elements");
}

- (void)testAddAnnotationConformToProtocol
{
    [_annotationArray addAnnotation:_poi];
    STAssertTrue([_annotationArray count] == 1, @"annotation array count shold be equal to 1");
    HKPointOfInterest *poi = [_annotationArray allAnnotations][0];
    STAssertTrue(poi.coordinate.latitude == 22 && poi.coordinate.longitude == 22, @"the array should contain annotation just added");
}

- (void)testAddAnnotationNotConformToProtocol
{
    STAssertThrows([_annotationArray addAnnotation:(id<MKAnnotation>)@"ciao"], @"should raise a bad argument exception");
}

- (void)testAddAnnotationsNotConformingToProtocol
{
    STAssertThrows([_annotationArray addAnnotations:(@[@"foo", @"meow", @"bar"])], @"should raise a bad argument exception");
}

- (void)testAddAnnotationsConformingToProtocol
{
    NSArray *annotations = [NSArray arrayWithObjects:_poi, _poi, _poi, nil];
    [_annotationArray addAnnotations:annotations];
    STAssertTrue([_annotationArray count] == 3, @"annotation collection should contain three elements");
    HKPointOfInterest *poi = [_annotationArray allAnnotations][1];
    STAssertTrue(poi.coordinate.longitude == 22 && poi.coordinate.longitude == 22, @"collection should contain annotation just added");
}

- (void)testAllAnnotationsShouldBeEmpty
{
    STAssertTrue([_annotationArray count] == 0, @"annotation array should be empty by default");
}

- (void)testMutability
{
    [_annotationArray addAnnotation:_poi];
    HKPointOfInterest *poi = [_annotationArray allAnnotations][0];
    [poi setCoordinate:CLLocationCoordinate2DMake(1, 2)];
    HKPointOfInterest *poi2 = [_annotationArray allAnnotations][0];
    STAssertTrue(poi2.coordinate.longitude != poi.coordinate.longitude && poi2.coordinate.latitude != poi.coordinate.latitude,
                 @"coordinates should be different");
}

- (void)testRemoveNotContainedAnnotation
{
    STAssertNoThrow([_annotationArray removeAnnotation:_poi], @"should not thow exception");
}

- (void)testRemoveNilAnnotation
{
    STAssertThrows([_annotationArray removeAnnotation:nil], @"should thow exception");
}

- (void)testRemoveAllAnnotationOnEmptyArray
{
    STAssertNoThrow([_annotationArray removeAllAnnotations], @"should not thow exception");
}

- (void)testRemoveAnnotation
{
    STAssertNoThrow([_annotationArray removeAnnotation:_poi], @"should not thow exception");
}

- (void)testRemoveAnnotationNotConformingToProtocol
{
    STAssertThrows([_annotationArray removeAnnotation:nil], @"should raise an exception");
}

- (void)testRemoveAnnotationsNotConformingToProtocol
{
    STAssertThrows(([_annotationArray removeAnnotations:@[_poi, @"bar", _poi]]), @"should raise an exception");
}

- (void)testRemoveAnnotationsConformingToProtocol
{
    [_annotationArray addAnnotations:@[_poi, _poi]];
    STAssertNoThrow(([_annotationArray removeAnnotations:@[_poi, _poi]]), @"should not throw exception");
    STAssertTrue([_annotationArray count] == 0, @"annotation array should be empty");
}

- (void)testRemoveAllAnnotations
{
    [_annotationArray addAnnotation:_poi];
    [_annotationArray addAnnotations:@[_poi, _poi]];
    [_annotationArray removeAllAnnotations];
    
    STAssertTrue([_annotationArray count] == 0, @"annotation array should be empty");
}

- (void)testRemoveAnnotationConformingToProtocol
{
    [_annotationArray addAnnotations:@[_poi, _poi]];
    [_annotationArray removeAnnotationsConformsToProtocol:@protocol(MKAnnotation)];
    STAssertTrue([_annotationArray count] == 0, @"annotation array should be empty");
}

- (void)testRemoveAnnotationConformingToProtocols
{
    [_annotationArray addAnnotations:@[_poi, _testAnnotation]];
    [_annotationArray removeAnnotationsConformsToProtocols:@[@protocol(MKAnnotation), @protocol(HKAnnotation)]];
    STAssertTrue([_annotationArray count] == 0, @"annotation array should be empty");
}

- (void)testRemoveAnnotations
{
    [_annotationArray addAnnotations:@[_poi, _testAnnotation]];
    [_annotationArray removeAnnotationsConformsToProtocols:@[@protocol(HKAnnotation)]];
    STAssertTrue([_annotationArray count] == 1, @"annotation array should contain 1 element");
}

- (void)testGetAnnotationOfKindOfClass
{
    [_annotationArray addAnnotations:@[_poi, _testAnnotation]];
    NSArray * res = [_annotationArray annotationsOfKindOfClass:[HKTestAnnotation class]];
    STAssertTrue([res count] == 1 && [res[0] isKindOfClass:[HKTestAnnotation class]], @"annotation array should contain one obj of kind EPTestAnnotation");
}

- (void)testGetAnnotationsOfKindOfClasses
{
    [_annotationArray addAnnotations:@[_poi, _testAnnotation]];
    NSArray *res = [_annotationArray annotationsOfKindOfClasses:@[[HKTestAnnotation class],[HKPointOfInterest class]]];
    STAssertTrue([res count] == 2, @"annotation array should contain 2 objs");
}

- (void)testGetAnnotationsConformingToProtocol
{
    [_annotationArray addAnnotations:@[_poi, _testAnnotation]];
    NSArray *res = [_annotationArray annotationsConformsToProtocol:@protocol(HKAnnotation)];
    STAssertTrue([res count] == 1 && [res[0] conformsToProtocol:@protocol(HKAnnotation)], @"should contain one object conforming to protocol EPAnnotation");
}

- (void)testGetAnnotationsConformingToProtocols
{
    [_annotationArray addAnnotations:@[_poi, _testAnnotation]];
    NSArray *res = [_annotationArray annotationsConformsToProtocols:@[@protocol(MKAnnotation)]];
    STAssertTrue([res count] == 2, @"annotation array should contain two object conform to MKAnnoation protocol");
}


- (void)testRemoveAnnotationsOfKindOfClass
{
    [_annotationArray addAnnotations:@[_poi, _testAnnotation]];
    [_annotationArray removeAnnotationsOfKindOfClass:[HKTestAnnotation class]];
    HKTestAnnotation *testAnnotation = [_annotationArray allAnnotations][0];
    STAssertTrue([_annotationArray count] == 1 && _testAnnotation.coordinate.latitude == testAnnotation.coordinate.latitude, @"annotation array should contain only EPTestAnnotation class");
}

- (void)testRemoveAnnotationsOfKindOfClasses
{
    [_annotationArray addAnnotations:@[_poi, _testAnnotation]];
    [_annotationArray removeAnnotationsOfKindOfClasses:@[[HKTestAnnotation class], [HKPointOfInterest class]]];
    STAssertTrue([_annotationArray count] == 0, @"annotation array should be empty");
}

- (void)testAnnotationWithinRange
{
    [_annotationArray addAnnotations:@[_poi, _testAnnotation]];
    NSArray *result = [_annotationArray annotationsWithinRange:2000 center:CLLocationCoordinate2DMake(22, 22)];
    HKPointOfInterest *poi = result[0];
    STAssertTrue([result count] == 1 && _poi.coordinate.latitude == poi.coordinate.latitude, @"should contain one poi");
}

@end
