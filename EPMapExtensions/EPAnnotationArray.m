//
//  EPAnnotationArray.m
//  iOSMapExtension
//
//  Created by epacces on 5/6/13.
//  Copyright (c) 2013 it.reply. All rights reserved.
//

#import "EPAnnotationArray.h"

@implementation EPAnnotationArray

- (id)init
{
    if (self = [super init]) {
        _annotationArray = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return self;
}

- (void)addAnnotations:(NSArray *)annotations
{
    for (id annotation in annotations)
        if (! [annotation conformsToProtocol:@protocol(MKAnnotation)])
            [NSException raise:NSInternalInconsistencyException format:@"annotations should contains only objs conforms to MKAnnotation protocol"];
    
    [_annotationArray addObjectsFromArray:annotations];
}

- (void)addAnnotation:(id <MKAnnotation>)annotation
{
    if ( ! [annotation conformsToProtocol:@protocol(MKAnnotation)] )
        [NSException raise:NSInternalInconsistencyException format:@"annotation should respond to MKAnnotation protocol"];
    else
        [_annotationArray addObject:annotation];
}

- (NSArray *)allAnnotations
{
    return [_annotationArray copy];
}

- (void)removeAllAnnotations
{
    [_annotationArray removeAllObjects];
}

- (void)removeAnnotationsConformsToProtocol:(Protocol *)protocol
{
    NSPredicate *predicate = [NSPredicate predicateWithBlock: ^BOOL(id evaluatedObject, NSDictionary *bindings ) {
        return [evaluatedObject conformsToProtocol:protocol];
    }];
    [_annotationArray filterUsingPredicate:predicate];
}


- (void)removeAnnotationsConformsToProtocols:(NSArray *)protocols
{
    for (Protocol *p in protocols) {
        [self removeAnnotationsConformsToProtocol:p];
    }
}

- (NSArray *)annotationsConformsToProtocol:(Protocol *)protocol
{
    NSPredicate *predicate = [NSPredicate predicateWithBlock: ^BOOL(id evaluatedObject, NSDictionary *bindings ) {
        return ![evaluatedObject conformsToProtocol:protocol];
    }];
    return [_annotationArray filteredArrayUsingPredicate:predicate];
}

- (NSArray *)annotationsConformsToProtocols:(NSArray *)protocols
{
    NSMutableArray *filteredArray = [[NSMutableArray alloc] init];
    for (Protocol *p in protocols) {
        [filteredArray addObjectsFromArray:[self annotationsConformsToProtocol:p]];
    }
    return filteredArray;
}

- (NSArray *)annotationsWithinRange:(CLLocationDistance)radius center:(CLLocationCoordinate2D)center
{
    CLLocation *centerPosition = [[CLLocation alloc] initWithLatitude:center.latitude longitude:center.longitude];
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id <MKAnnotation> evaluatedObject, NSDictionary *bindings ) {
        CLLocationCoordinate2D coordinate = [evaluatedObject coordinate];
        CLLocation *annotationPosition = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
        return [ annotationPosition distanceFromLocation:centerPosition ] <= radius;
    }];
    return [_annotationArray filteredArrayUsingPredicate:predicate];
}

- (void)removeAnnotation:(id<MKAnnotation>)annotation
{
    [_annotationArray removeObject:annotation];
}

- (void)removeAnnotations:(NSArray *)annotations
{
    [_annotationArray removeObjectsInArray:annotations];
}

- (NSUInteger)count
{
    return [_annotationArray count];
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(__unsafe_unretained id [])buffer count:(NSUInteger)len
{
    return [_annotationArray countByEnumeratingWithState:state objects:buffer count:len];
}

@end