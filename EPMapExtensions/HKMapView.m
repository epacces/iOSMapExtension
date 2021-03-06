//
//  EPMapView.m
//  iOSMapExtension
//
//  Created by epacces on 5/6/13.
//  Copyright (c) 2013 it.hepakkes. All rights reserved.
//

#import "HKMapView.h"
#import "HKAnnotationArray.h"

#define SET_MIN(X, Y) X = ((Y) < (X)) ? (Y) : (X)
#define SET_MAX(X, Y) X = ((Y) < (X)) ? (X) : (Y)


@interface EPPrivateAnnotationArray : HKAnnotationArray

@end

@implementation HKMapView {
    EPPrivateAnnotationArray     *_annotationArray;
}

#pragma mark - Obj alloc/init/dealloc

- (id)initWithMapView:(MKMapView *)mapView
{
    if (self = [super initWithFrame:mapView.frame]) {
        _annotationArray = [[EPPrivateAnnotationArray alloc] init];
        [_annotationArray addAnnotations:[mapView annotations]];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _annotationArray = [[EPPrivateAnnotationArray alloc] init];
    }
    return self;
}

#pragma mark - Collection mutators

- (void)addAnnotations:(NSArray *)annotations
{
    [super addAnnotations:annotations];
    [_annotationArray addAnnotations:annotations];
}

- (void)addAnnotation:(id<MKAnnotation>)annotation
{
    [super addAnnotation:annotation];
    [_annotationArray addAnnotation:annotation];
}

- (void)removeAnnotation:(id<MKAnnotation>)annotation
{
    [super removeAnnotation:annotation];
    [_annotationArray removeAnnotation:annotation];
}

- (void)removeAnnotations:(NSArray *)annotations
{
    [super removeAnnotations:annotations];
    [_annotationArray removeAnnotations:annotations];
}

- (void)removeAllAnnotations
{
    [super removeAnnotations:[self annotations]];
    [_annotationArray removeAllAnnotations];
}


- (void)removeAnnotationsConformingToProtocol:(Protocol *)protocol
{
    [super removeAnnotations:[_annotationArray annotationsConformsToProtocol:protocol]];
    [_annotationArray removeAnnotationsConformsToProtocol:protocol];
}

- (void)removeAnnotationsConformingToProtocols:(NSArray *)protocols
{
    [super removeAnnotations:[_annotationArray annotationsConformsToProtocols:protocols]];
    [_annotationArray removeAnnotationsConformsToProtocols:protocols];
}

- (void)removeAnnotationsOfKindOfClass:(Class<MKAnnotation>)cls
{
    [super removeAnnotations:[_annotationArray annotationsOfKindOfClass:cls]];
    [_annotationArray removeAnnotationsOfKindOfClass:cls];
}

- (void)removeAnnotationsOfKindOfClasses:(NSArray *)array
{
    [super removeAnnotations:[_annotationArray annotationsOfKindOfClasses:array]];
    [_annotationArray removeAnnotationsOfKindOfClasses:array];
}

#pragma mark - Calculations of centered regions

- (MKCoordinateRegion)centeredRegionForAnnotations:(NSArray *)annotationArray
{
    if (![annotationArray count]) {
        NSLog(@"warning: annotation set is empty, returning the current visible map region");
        return [self region];
    }
    
    CLLocationDegrees min_lat = MAXFLOAT,
    max_lat = 0,
    min_lon = MAXFLOAT,
    max_lon = 0,
    latDelta = 0,
    lonDelta = 0,
    sum_x = 0,
    sum_y = 0;
    NSUInteger ncoord = [annotationArray count];
    
    for (id <MKAnnotation> p in annotationArray) { //compute the mean together with min and max
        
        CLLocationDegrees lat = p.coordinate.latitude;
        CLLocationDegrees lon = p.coordinate.longitude;
        sum_x += p.coordinate.longitude;
        sum_y += p.coordinate.latitude;
        
        
        SET_MIN(min_lat, lat);
        SET_MAX(max_lat, lat);
        
        SET_MIN(min_lon, lon);
        SET_MAX(max_lon, lon);
        
    }
    CLLocationCoordinate2D baricentrum = CLLocationCoordinate2DMake((sum_y/ncoord), (sum_x/ncoord));
    latDelta = fabs(max_lat - min_lat);
    lonDelta = fabs(max_lon - min_lon);
    MKCoordinateSpan span = MKCoordinateSpanMake(latDelta, lonDelta);
    return MKCoordinateRegionMake(baricentrum, span);
    
}

- (MKCoordinateRegion)centeredRegion
{
    return [self centeredRegionForAnnotations:[_annotationArray allAnnotations]];
}

- (MKCoordinateRegion)centeredRegionForAnnotationConformingToProtocol:(Protocol *)protocol
{
    return [self centeredRegionForAnnotations:[_annotationArray annotationsConformsToProtocol:protocol]];
}

- (MKCoordinateRegion)centeredRegionForAnnotationConformingToProtocols:(NSArray *)protocols
{
    return [self centeredRegionForAnnotations:[_annotationArray annotationsConformsToProtocols:protocols]];
}

- (MKCoordinateRegion)centeredRegionForAnnotationOfKindOfClass:(Class)cls
{
    return [self centeredRegionForAnnotations:[_annotationArray annotationsOfKindOfClass:cls]];
}

- (MKCoordinateRegion)centeredRegionForAnnotationOfKindOfClasses:(NSArray *)classes
{
    return [self centeredRegionForAnnotationOfKindOfClasses:[_annotationArray annotationsOfKindOfClasses:classes]];
}


#pragma mark - Visible Annotations

- (NSUInteger)visibleAnnotations
{
    return [[self annotationsInMapRect:[self visibleMapRect]] count];
}

- (NSUInteger)visibleAnnotationsConformingToProtocol:(Protocol *)protocol
{
    NSPredicate* p = [NSPredicate predicateWithBlock: ^BOOL(id evaluatedObject, NSDictionary *bindings) {
        return ([evaluatedObject conformsToProtocol:protocol]);
    }];
    return [[[self annotationsInMapRect:[self visibleMapRect]] filteredSetUsingPredicate:p] count];
}

- (NSUInteger)visibleAnnotationsConformingToProtocols:(NSArray *)protocols
{
    NSUInteger counter = 0;
    for (Protocol *p in protocols) {
        counter += [self visibleAnnotationsConformingToProtocol:p];
    }
    return counter;
}

- (NSUInteger)visibleAnnotationsOfKindOfClass:(Class)cls
{
    NSPredicate* p = [NSPredicate predicateWithBlock: ^BOOL(id evaluatedObject, NSDictionary *bindings) {
        return ([evaluatedObject isKindOfClass:cls]);
    }];
    return [[[self annotationsInMapRect:[self visibleMapRect]] filteredSetUsingPredicate:p] count];
}

- (NSUInteger)visibleAnnotationsOfKindOfClasses:(NSArray *)classes
{
    NSUInteger counter = 0;
    for (Class cls in classes) {
        counter += [self visibleAnnotationsOfKindOfClass:cls];
    }
    return counter;
}

@end


@implementation EPPrivateAnnotationArray

- (NSArray *)allAnnotations
{
    return [_annotationArray copy];
}

@end
