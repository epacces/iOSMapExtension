//
//  EPAnnotationArrayTest.m
//  iOSMapExtension
//
//  Created by Eriprando Pacces on 5/20/13.
//  Copyright (c) 2013 it.reply. All rights reserved.
//

#import "EPAnnotationArrayTest.h"
#import "EPAnnotationArray.h"
#import "EPPointOfInterest.h"

@implementation EPAnnotationArrayTest {
    EPAnnotationArray   *_annotationArray;
    EPPointOfInterest   *_poi;
}

- (void)setUp
{
    _annotationArray = [[EPAnnotationArray alloc] init];
    _poi = [[EPPointOfInterest alloc] initWithCoordinate:CLLocationCoordinate2DMake(22, 22)];
}

- (void)testAddAnnotation
{
    [_annotationArray addAnnotation:_poi];
    STAssertTrue([_annotationArray count] == 1, @"annotation array count shold be equal to 1");
    EPPointOfInterest *poi = [_annotationArray allAnnotations][0];
    STAssertTrue(poi.coordinate.latitude == 22 && poi.coordinate.longitude == 22, @"the array should contain annotation just added");
}

- (void)testAddNonAnnotation
{
    STAssertThrows([_annotationArray addAnnotation:(id<MKAnnotation>)@"ciao"], @"should raise a bad argument exception");
}

- (void)testAddBadAnnotations
{
    STAssertThrows([_annotationArray addAnnotations:(@[@"foo", @"meow", @"bar"])], @"should raise a bad argument exception");
}

- (void)testAddAnnotations
{
    NSArray *annotations = [NSArray arrayWithObjects:_poi, _poi, _poi, nil];
    [_annotationArray addAnnotations:annotations];
    STAssertTrue([_annotationArray count] == 3, @"annotation collection should contain three elements");
    EPPointOfInterest *poi = [_annotationArray allAnnotations][1];
    STAssertTrue(poi.coordinate.longitude == 22 && poi.coordinate.longitude == 22, @"collection should contain annotation just added");
}

- (void)testMutability
{
    [_annotationArray addAnnotation:_poi];
    EPPointOfInterest *poi = [_annotationArray allAnnotations][0];
    [poi setCoordinate:CLLocationCoordinate2DMake(1, 2)];
    EPPointOfInterest *poi2 = [_annotationArray allAnnotations][0];
    STAssertTrue(poi2.coordinate.longitude != poi.coordinate.longitude && poi2.coordinate.latitude != poi.coordinate.latitude,
                 @"coordinates should be different");
}

@end
