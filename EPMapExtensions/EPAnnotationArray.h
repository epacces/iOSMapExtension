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
 Designed initializer
 
 @param annotations Annotation array which contains objects conforming to `MKAnnotation` protocol
 */

- (id)initWithAnnotationArray:(NSArray *)annotations;

/**
 It returns all the annotations in the collection
 */

- (NSArray *)allAnnotations;

/**
 @param protocol It's the protocol whose retrieved annotations must adhere to 

 @note all the annotations are conforming to `MKAnnotation` protocol by definition
 
 */

- (NSArray *)annotationsConformsToProtocol:(Protocol *)protocol;

/**
 @param protocols Array of protocols retrieved annotations must adhere to 
 
 @note all the annotations are conforming to `MKAnnotation` protocol by definition
 */

- (NSArray *)annotationsConformsToProtocols:(NSArray *)protocols;

/**
 
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