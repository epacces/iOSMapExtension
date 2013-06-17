//
//  EPAnnotationArray.h
//  iOSMapExtension
//
//  Created by epacces on 5/6/13.
//  Copyright (c) 2013 it.reply. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

/**
 Annotation Collection class which wraps up a mutable a `NSMutableArray` and contains `MKAnnotation` protocol conform objects
 */

@interface EPAnnotationArray : NSObject <NSFastEnumeration> {
    NSMutableArray        *_annotationArray;
}

- (id)initWithAnnotationArray:(NSArray *)annotations;

- (NSArray *)allAnnotations;

- (NSArray *)annotationsConformsToProtocol:(Protocol *)protocol;
- (NSArray *)annotationsConformsToProtocols:(NSArray *)protocols;

- (NSArray *)annotationsOfKindOfClass:(Class<MKAnnotation>)cls;
- (NSArray *)annotationsOfKindOfClasses:(NSArray *)classes;

- (NSArray *)annotationsWithinRange:(CLLocationDistance)radius center:(CLLocationCoordinate2D)center;

- (NSUInteger)count;

@end

@interface EPAnnotationArray (EPAnnotationMutableArray)

/**
 Adds annotation to the container
 @exception raises an exception if annotation is not conforming to `MKAnnotation` protocol
 */

- (void)addAnnotation:(id <MKAnnotation>)annotation;
- (void)addAnnotations:(NSArray *)annotations;

- (void)removeAnnotationsOfKindOfClass:(Class <MKAnnotation>)cls;
- (void)removeAnnotationsOfKindOfClasses:(NSArray *)classes;

- (void)removeAnnotationsConformsToProtocol:(Protocol *)protocol;
- (void)removeAnnotationsConformsToProtocols:(NSArray *)protocols;

- (void)removeAnnotation:(id <MKAnnotation>)annotation;
- (void)removeAnnotations:(NSArray *)annotations;

- (void)removeAllAnnotations;

@end