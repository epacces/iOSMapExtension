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

/**
 Annotation Collection class which wraps up a mutable a `NSMutableArray` and contains `MKAnnotation` protocol conform objects
 */

- (id)initWithAnnotationArray:(NSArray *)annotations;

/**
 Annotation Collection class which wraps up a mutable a `NSMutableArray` and contains `MKAnnotation` protocol conform objects
 */

- (NSArray *)allAnnotations;

/**
 Annotation Collection class which wraps up a mutable a `NSMutableArray` and contains `MKAnnotation` protocol conform objects
 */

- (NSArray *)annotationsConformsToProtocol:(Protocol *)protocol;

/**
 Annotation Collection class which wraps up a mutable a `NSMutableArray` and contains `MKAnnotation` protocol conform objects
 */

- (NSArray *)annotationsConformsToProtocols:(NSArray *)protocols;

/**
 Annotation Collection class which wraps up a mutable a `NSMutableArray` and contains `MKAnnotation` protocol conform objects
 */

- (NSArray *)annotationsOfKindOfClass:(Class<MKAnnotation>)cls;

/**
 Annotation Collection class which wraps up a mutable a `NSMutableArray` and contains `MKAnnotation` protocol conform objects
 */

- (NSArray *)annotationsOfKindOfClasses:(NSArray *)classes;

/**
 Annotation Collection class which wraps up a mutable a `NSMutableArray` and contains `MKAnnotation` protocol conform objects
 */

- (NSArray *)annotationsWithinRange:(CLLocationDistance)radius center:(CLLocationCoordinate2D)center;

/**
 Annotation Collection class which wraps up a mutable a `NSMutableArray` and contains `MKAnnotation` protocol conform objects
 */


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